"""Verifies the three resume artifacts tell the same story.

There are three renderings of one resume — lib/resume_data.dart (the site page),
web/jeremiah-parrack-resume.pdf, and JeremiahParrackResume-2026.docx — and they
drift silently. Run this after changing any of them.

    pdftotext -layout web/jeremiah-parrack-resume.pdf /tmp/r.txt
    python3 tool/check_resume_sync.py
"""
import html, pathlib, re, subprocess, sys, zipfile

ROOT = pathlib.Path(__file__).resolve().parent.parent

# Facts that must appear in all three, and stale claims that must appear in none.
REQUIRED = [
    "4,000+ commits across 311 repositories in 26 GitHub organizations",
    "Over 1,000 users",
    "over 600 users",
    "Remediated GHSA-82j2-j2ch-gfr8",
    "Rack 3 support",
    "Ten releases, still shipping",
    "removed a spurious iOS simulator warning",
    "nine years",
]
FORBIDDEN = [
    "1,075 pull requests",   # trimmed from the fleet-scale bullet
    "3,200 public commits",  # commit-volume line was dropped
    "packages repository",   # documentation-only contribution was dropped
    "190 repositories",      # superseded by the full-history figure
    "customink/",            # Lamby and Crypteia moved to rails-lambda
]


def norm(t: str) -> str:
    t = (t.replace("—", "-").replace("–", "-").replace("’", "'")
          .replace("★", " stars").replace(" ", " "))
    return re.sub(r"\s+", " ", t)


def pdf_text() -> str:
    out = ROOT / "build" / "_resume.txt"
    out.parent.mkdir(exist_ok=True)
    subprocess.run(
        ["pdftotext", "-layout", str(ROOT / "web" / "jeremiah-parrack-resume.pdf"), str(out)],
        check=True,
    )
    return norm(out.read_text(errors="ignore"))


def docx_text() -> str:
    z = zipfile.ZipFile(ROOT / "JeremiahParrackResume-2026.docx")
    x = z.read("word/document.xml").decode("utf8", "ignore").replace("</w:p>", "\n")
    return norm(html.unescape(re.sub(r"<[^>]+>", "", x)))


def dart_text() -> str:
    s = (ROOT / "lib" / "resume_data.dart").read_text()
    # Adjacent Dart string literals concatenate; join them before matching.
    return norm(re.sub(r"'\s*\n?\s*'", "", s).replace("\\'", "'"))


def main() -> int:
    sources = {"pdf": pdf_text(), "docx": docx_text(), "dart": dart_text()}
    failures = []
    for s in REQUIRED:
        missing = [n for n, t in sources.items() if s not in t]
        if missing:
            failures.append(f"MISSING from {', '.join(missing)}: {s}")
    for s in FORBIDDEN:
        present = [n for n, t in sources.items() if s in t]
        if present:
            failures.append(f"STALE, still in {', '.join(present)}: {s}")
    for f in failures:
        print(f)
    print("resume artifacts in sync" if not failures
          else f"{len(failures)} problem(s)")
    return 1 if failures else 0


if __name__ == "__main__":
    sys.exit(main())
