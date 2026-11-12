import tempfile
from pathlib import Path
import unittest

from check_docs import anchors, check_repo, link_spans, mask_code


class MarkdownChecks(unittest.TestCase):
    def test_links_and_code(self):
        text = ('[inline](docs/a.md#one) ![image](pic.png)\n'
                '[ref]: <docs/a%20b.md> "title"\n'
                '<a href="docs/html.md">html</a>\n'
                '[nested](docs/a(b).md)\n'
                '`[ignored](missing.md)`\n'
                '```bash\n[ignored](missing-too.md)\n```\n')
        self.assertEqual([text[a:b] for a, b in link_spans(text)],
                         ['docs/a.md#one', 'pic.png', 'docs/a%20b.md', 'docs/html.md', 'docs/a(b).md'])

    def test_heading_anchors(self):
        self.assertEqual(anchors('# Title\n## Same\n## Same\n## `foo_bar` & Baz!\n'
                                 '<a id="custom"></a>\n```md\n# Not a heading\n```\n'),
                         {'title', 'same', 'same-1', 'foo_bar--baz', 'custom'})

    def test_code_mask_offsets(self):
        text = 'before\n   ~~~~sh\n[bad](x)\n   ~~~~\n`example` after\n'
        self.assertEqual(len(mask_code(text)), len(text))
        self.assertEqual(mask_code(text).count('\n'), text.count('\n'))
        self.assertNotIn('[bad]', mask_code(text))

    def test_missing_targets_and_anchors_fail(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            (root / 'docs').mkdir()
            (root / 'README.md').write_text('# Index\n[ok](docs/a.md#one)\n[bad](docs/a.md#missing)\n[missing](none.md)\n', encoding='utf-8')
            (root / 'docs/a.md').write_text('# A\n## One\n', encoding='utf-8')
            errors, count, links = check_repo(root)
            self.assertEqual((count, links), (2, 3))
            self.assertEqual(len(errors), 2)
            self.assertTrue(any('missing anchor' in e for e in errors))
            self.assertTrue(any('missing target' in e for e in errors))

    def test_valid_links_and_archive_boundary(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            (root / 'docs').mkdir()
            (root / 'archive/legacy').mkdir(parents=True)
            (root / 'README.md').write_text('# Index\n[one](docs/a.md#one)\n[archive](archive/README.md)\n', encoding='utf-8')
            (root / 'docs/a.md').write_text('# A\n## One\n[index](../README.md)\n', encoding='utf-8')
            (root / 'archive/README.md').write_text('# Archive\n[record](legacy/old.md)\n', encoding='utf-8')
            (root / 'archive/legacy/old.md').write_text('Historical record with [old](missing.md)\n', encoding='utf-8')
            errors, count, links = check_repo(root)
            self.assertEqual(errors, [])
            self.assertEqual((count, links), (3, 4))

    def test_repository_escape_fails(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            (root / 'docs').mkdir()
            (root / 'README.md').write_text('# Index\n[bad](../../outside.md)\n', encoding='utf-8')
            errors, _, _ = check_repo(root)
            self.assertTrue(any('escapes repository' in e for e in errors))


if __name__ == '__main__':
    unittest.main()
