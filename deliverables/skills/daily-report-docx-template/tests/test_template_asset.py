from __future__ import annotations

import unittest
import zipfile
from pathlib import Path

from docx import Document
from docx.enum.section import WD_ORIENT
from docx.shared import Inches


SKILL_ROOT = Path(__file__).resolve().parents[1]
TEMPLATE = SKILL_ROOT / "assets" / "daily-report-template.docx"
ANCHORS = {"DR_TITLE", "DR_META", "DR_DASHBOARD", "DR_ATTENDANCE", "DR_WORK_SUMMARY",
           "DR_PROJECTS", "DR_RISKS", "DR_ACTIONS"}


class TemplateAssetTests(unittest.TestCase):
    def test_template_is_valid_and_contains_controlled_anchors_and_styles(self) -> None:
        with zipfile.ZipFile(TEMPLATE) as archive:
            self.assertIsNone(archive.testzip())
        document = Document(TEMPLATE)
        self.assertTrue(ANCHORS <= {paragraph.text for paragraph in document.paragraphs})
        section = document.sections[0]
        self.assertEqual(section.orientation, WD_ORIENT.PORTRAIT)
        self.assertAlmostEqual(section.page_width.inches, 8.5, places=2)
        self.assertAlmostEqual(section.page_height.inches, 11.0, places=2)
        for margin in (section.top_margin, section.bottom_margin,
                       section.left_margin, section.right_margin):
            self.assertAlmostEqual(margin.inches, Inches(0.83).inches, places=2)
        normal = document.styles["Normal"]
        heading1 = document.styles["Heading 1"]
        heading2 = document.styles["Heading 2"]
        self.assertEqual(normal.font.name, "仿宋_GB2312")
        self.assertEqual(round(normal.font.size.pt), 11)
        self.assertEqual(normal.paragraph_format.line_spacing, 1.5)
        self.assertAlmostEqual(normal.paragraph_format.first_line_indent.pt, 23.75, places=1)
        self.assertEqual(heading1.font.name, "黑体")
        self.assertEqual(round(heading1.font.size.pt), 15)
        self.assertEqual(heading2.font.name, "黑体")
        self.assertEqual(round(heading2.font.size.pt), 13)


if __name__ == "__main__":
    unittest.main()
