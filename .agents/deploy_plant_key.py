#!/usr/bin/env python3
"""One-shot helper: SSH to the target with a password, plant ~/.ssh/id_rsa.pub
into /root/.ssh/authorized_keys, then verify key-only login works.

Run via: $env:DRS_PASS=<password> python .agents/deploy_plant_key.py
The env var must be set; the script will unset it immediately after reading.
"""

from __future__ import annotations

import os
import sys
from pathlib import Path

import paramiko

HOST = "36.213.175.224"
PORT = 22
USER = "root"
PUB_KEY_PATH = Path.home() / ".ssh" / "id_rsa.pub"


def die(msg: str, code: int = 1) -> None:
    print(f"ERROR: {msg}", file=sys.stderr)
    sys.exit(code)


def main() -> None:
    password = os.environ.pop("DRS_PASS", None)
    if not password:
        die("DRS_PASS env var missing — abort before any network call.")
    # Make sure no child process inherits it.
    os.environ["DRS_PASS"] = ""

    pubkey_text = PUB_KEY_PATH.read_text(encoding="utf-8").strip()
    if not pubkey_text.startswith("ssh-"):
        die(f"id_rsa.pub does not look like an SSH key: {pubkey_text[:40]!r}")

    client = paramiko.SSHClient()
    client.load_system_host_keys()
    client.set_missing_host_key_policy(paramiko.WarningPolicy())
    try:
        print(f"[1/4] Connecting to {USER}@{HOST}:{PORT} via password …")
        client.connect(
            hostname=HOST,
            port=PORT,
            username=USER,
            password=password,
            look_for_keys=False,
            allow_agent=False,
            timeout=15,
            banner_timeout=15,
            auth_timeout=15,
        )
        print("    password login OK")

        plant_cmd = (
            "set -e; "
            "mkdir -p /root/.ssh; "
            "chmod 700 /root/.ssh; "
            "touch /root/.ssh/authorized_keys; "
            "chmod 600 /root/.ssh/authorized_keys; "
            "grep -qxF '{pubkey}' /root/.ssh/authorized_keys "
            "  || printf '%s\\n' '{pubkey}' >> /root/.ssh/authorized_keys; "
            "wc -l /root/.ssh/authorized_keys"
        ).format(pubkey=pubkey_text.replace("'", "'\\''"))

        print("[2/4] Planting public key …")
        stdin, stdout, stderr = client.exec_command(plant_cmd)
        out = stdout.read().decode("utf-8", errors="replace").strip()
        err = stderr.read().decode("utf-8", errors="replace").strip()
        if err:
            print(f"    stderr: {err}")
        print(f"    authorized_keys line count: {out}")

        verify_cmd = (
            "ssh-keygen -lf /etc/ssh/ssh_host_ed25519_key.pub 2>/dev/null || true; "
            "cat /root/.ssh/authorized_keys | wc -l; "
            "ls -ld /root/.ssh /root/.ssh/authorized_keys"
        )
        print("[3/4] Final state on server:")
        stdin, stdout, stderr = client.exec_command(verify_cmd)
        print(stdout.read().decode("utf-8", errors="replace").rstrip())
        err2 = stderr.read().decode("utf-8", errors="replace").strip()
        if err2:
            print(f"    stderr: {err2}")
    finally:
        client.close()

    # Second connection — public-key only, no password allowed.
    print("[4/4] Reconnecting with publickey only …")
    pkey = paramiko.RSAKey.from_private_key_file(str(Path.home() / ".ssh" / "id_rsa"))
    client2 = paramiko.SSHClient()
    client2.load_system_host_keys()
    client2.set_missing_host_key_policy(paramiko.WarningPolicy())
    try:
        client2.connect(
            hostname=HOST,
            port=PORT,
            username=USER,
            pkey=pkey,
            look_for_keys=False,
            allow_agent=False,
            timeout=15,
            banner_timeout=15,
            auth_timeout=15,
        )
        stdin, stdout, stderr = client2.exec_command(
            "whoami; uname -a; id; which docker || echo NO_DOCKER; "
            "docker --version 2>/dev/null || echo NO_DOCKER_VERSION; "
            "(docker compose version 2>/dev/null) || echo NO_COMPOSE_VERSION"
        )
        print(stdout.read().decode("utf-8", errors="replace").rstrip())
        err3 = stderr.read().decode("utf-8", errors="replace").strip()
        if err3:
            print(f"    stderr: {err3}")
    finally:
        client2.close()

    print("DONE: public-key auth established.")


if __name__ == "__main__":
    try:
        main()
    finally:
        # Best-effort: scrub the variable even if main() threw early.
        os.environ.pop("DRS_PASS", None)