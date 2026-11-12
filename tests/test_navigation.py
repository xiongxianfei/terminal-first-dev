"""Exercise shell snippets with fake tools and temporary homes; never install tools."""
import os
from pathlib import Path
import shlex
import shutil
import subprocess
import tempfile
import unittest

ROOT = Path(__file__).resolve().parents[1]


class NavigationCases:
    shell = "bash"

    def run_snippet(self, tools=(), body="", interactive=True, fail="", bad_eval=""):
        with tempfile.TemporaryDirectory(prefix="tfd-navigation-") as directory:
            home = Path(directory)
            binary = home / "bin"
            binary.mkdir()
            for tool in tools:
                script = binary / tool
                script.write_text(
                    '#!/bin/sh\n'
                    f'printf "%s\\n" "{tool}:$*" >> "$TFD_LOG"\n'
                    f'if [ "$TFD_FAIL" = "{tool}" ]; then\n'
                    '  printf "%s\\n" "__tfd_poison=1"; exit 1\n'
                    'fi\n'
                    f'if [ "$TFD_BAD_EVAL" = "{tool}" ]; then\n'
                    '  printf "%s\\n" "false"; exit 0\n'
                    'fi\n'
                    + ('printf "%s\\n" "z() { :; }; zi() { :; }"\n' if tool == 'zoxide'
                       else 'printf "%s\\n" "__tfd_mock_fzf() { :; }"\n'),
                    encoding="utf-8",
                )
                script.chmod(0o755)
            snippet = ROOT / "config/shell" / f"navigation.{self.shell}"
            source = f"source {shlex.quote(str(snippet))}"
            command = body.replace("SOURCE", source) if body else f"{source}; {source}; printf 'ALIVE\\n'"
            env = {
                "PATH": str(binary), "HOME": str(home), "ZDOTDIR": str(home),
                "TERM": "dumb", "LC_ALL": "C", "TFD_LOG": str(home / "calls"),
                "TFD_FAIL": fail, "TFD_BAD_EVAL": bad_eval,
                "FZF_DEFAULT_OPTS": "--height=35%", "FZF_CTRL_T_COMMAND": "user-choice",
            }
            executable = shutil.which(self.shell)
            args = [executable, "--noprofile", "--norc"] if self.shell == "bash" else [executable, "-d", "-f"]
            args += ["-ic" if interactive else "-c", command]
            result = subprocess.run(args, env=env, text=True, capture_output=True, timeout=10)
            self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
            log = home / "calls"
            return result, log.read_text().splitlines() if log.exists() else []

    def test_missing_tools_do_not_break_shell(self):
        result, calls = self.run_snippet()
        self.assertIn("ALIVE", result.stdout)
        self.assertEqual(calls, [])

    def test_noninteractive_shell_is_untouched(self):
        _, calls = self.run_snippet(("fzf", "zoxide"), interactive=False)
        self.assertEqual(calls, [])

    def test_success_is_idempotent_and_preserves_user_settings(self):
        _, calls = self.run_snippet(("fzf", "zoxide"), body='''
SOURCE; SOURCE
[[ "$FZF_DEFAULT_OPTS" == '--height=35%' ]] || exit 11
[[ "$FZF_CTRL_T_COMMAND" == 'user-choice' ]] || exit 12
[[ -z ${__tfd_init+x} ]] || exit 13
[[ $__tfd_fzf_loaded == 1 && $__tfd_zoxide_loaded == 1 ]] || exit 14
[[ "$(command -v cd)" == cd ]] || exit 15
z; zi; __tfd_mock_fzf
''')
        self.assertEqual(calls, [f"fzf:--{self.shell}", f"zoxide:init {self.shell}"])

    def test_each_tool_can_load_alone(self):
        for tool in ("fzf", "zoxide"):
            with self.subTest(tool=tool):
                _, calls = self.run_snippet((tool,))
                self.assertEqual(len(calls), 1)

    def test_unsupported_fzf_does_not_block_zoxide(self):
        result, calls = self.run_snippet(("fzf", "zoxide"), fail="fzf", body='''
SOURCE
[[ -z ${__tfd_poison+x} && -z ${__tfd_fzf_loaded+x} ]] || exit 21
[[ $__tfd_zoxide_loaded == 1 ]] || exit 22
z; zi
''')
        self.assertIn("update fzf", result.stderr)
        self.assertEqual(len(calls), 2)

    def test_failed_zoxide_output_is_not_evaluated(self):
        result, _ = self.run_snippet(("zoxide",), fail="zoxide", body='''
SOURCE
[[ -z ${__tfd_poison+x} && -z ${__tfd_zoxide_loaded+x} ]] || exit 23
''')
        self.assertIn("failed", result.stderr)

    def test_failed_initialization_can_be_retried(self):
        _, calls = self.run_snippet(("fzf", "zoxide"), fail="fzf", body='''
SOURCE
export TFD_FAIL=''
SOURCE; SOURCE
[[ $__tfd_fzf_loaded == 1 && $__tfd_zoxide_loaded == 1 ]] || exit 24
''')
        self.assertEqual(calls.count(f"fzf:--{self.shell}"), 2)
        self.assertEqual(calls.count(f"zoxide:init {self.shell}"), 1)

    def test_eval_failure_does_not_mark_tool_loaded(self):
        result, _ = self.run_snippet(("fzf", "zoxide"), bad_eval="zoxide", body='''
SOURCE
[[ -z ${__tfd_zoxide_loaded+x} && $__tfd_fzf_loaded == 1 ]] || exit 25
''')
        self.assertIn("zoxide initialization failed", result.stderr)


@unittest.skipUnless(os.name == "posix" and shutil.which("bash"), "Bash runtime unavailable")
class BashNavigation(NavigationCases, unittest.TestCase):
    shell = "bash"


@unittest.skipUnless(os.name == "posix" and shutil.which("zsh"), "Zsh runtime unavailable")
class ZshNavigation(NavigationCases, unittest.TestCase):
    shell = "zsh"


class PowerShellNavigation(unittest.TestCase):
    @unittest.skipUnless(shutil.which("pwsh"), "PowerShell runtime unavailable")
    def test_mocked_powershell_cases(self):
        result = subprocess.run(
            [shutil.which("pwsh"), "-NoProfile", "-NonInteractive", "-File",
             str(ROOT / "tests/shell/navigation.ps1")],
            text=True, capture_output=True, timeout=30,
        )
        self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertIn("PASS: 7 PowerShell snippet cases", result.stdout)


if __name__ == "__main__":
    unittest.main()
