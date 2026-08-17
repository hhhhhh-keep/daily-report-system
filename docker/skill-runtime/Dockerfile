FROM python:3.12-slim-bookworm

COPY daily-api/skill-runtime-requirements.txt /tmp/skill-runtime-requirements.txt
RUN pip install --no-cache-dir -r /tmp/skill-runtime-requirements.txt \
    && rm /tmp/skill-runtime-requirements.txt \
    && groupadd --system skillrunner \
    && useradd --system --gid skillrunner --create-home skillrunner

USER skillrunner
WORKDIR /workspace
ENTRYPOINT ["python"]
