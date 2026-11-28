# LLM Skills

A collection of reusable skills for LLM coding assistants and agents, paired with an install script that links them into local agent skill directories.

## Skills

### [`analyze-stock`](skills/analyze-stock/)

Delivers an objective, structured equity analysis of a stock or public company:

- Evaluates 7 dimensions in order: Company Overview, Peer Comparison, Financial Statements, Macroeconomic Factors, Sectoral Rotation, Management Outlook, and Shareholding Analysis
- Assigns a clear verdict and score out of 5 for each dimension, backed by evidence-based analysis
- Accounts for additional company-specific risks or catalysts and concludes with a synthesis of the scores and overall assessment

### [`commit-changes`](skills/commit-changes/)

Safely commits local work onto a fresh branch off the latest default branch (`origin/main` or `origin/master`):

- Inspects working tree status, staged vs. unstaged diffs, and detects `origin/main` or `origin/master`
- Stashes uncommitted changes, fast-forwards the local base branch from `origin` (stopping on divergence), creates a new branch (`<type>/<short-kebab-summary>`), and restores the stash
- Writes a **Conventional Commits** title and structured body explaining what changed and why, then stages, commits, and verifies the result

### [`executive-summary`](skills/executive-summary/)

Produces a scannable, high-signal executive research brief from a report, PDF, article, or long document:

- Captures exact numbers, entities, and source metadata before drafting
- Structures output into: Header & Central Thesis, 5–7 Numbered Takeaways (with charts/tables and KPI callouts), Implications Table (`Entity or Segment | Outlook | Rationale`), Analytical Synthesis, Bottom Line, and Follow-Up Options

### [`release-zed`](skills/release-zed/)

Cuts a GitHub release for a forked Zed branch and packages `/Applications/Zed Nightly.app`:

- Verifies branch push status, `gh` authentication, and version parity between `Info.plist` (`CFBundleShortVersionString`) and `crates/zed/Cargo.toml`
- Collects branch-specific commits (instead of relying on `--generate-notes`) and builds a compare link from the base commit
- Copies `/Applications/Zed Nightly.app` to a temporary directory, strips extended attributes (`xattr -cr`), zips with `ditto -c -k --norsrc --keepParent` (preserving the code signature while avoiding `__MACOSX`/`._*` artifacts), and verifies with `unzip -l` and `codesign --verify`
- Creates a GitHub release targeting the current branch and uploads `Zed-Nightly.zip`

### [`research-paper-summarize`](skills/research-paper-summarize/)

Produces a systems-engineering breakdown of a research paper, arXiv link, PDF, or technical system:

- Follows a 6-part structure: Header & Central Thesis, Headline Results (with caveats), Deep-Dive per Innovation, Novelty vs. Established Techniques table, Limitations/Regressions/Conditional Wins, and Reusable Takeaways & Actionable Next Steps
- Saves the full summary to `<repo-root>/<paper-slug>/summary.md` and outputs the exact same Markdown verbatim in the assistant response

## Installation

Run [`install.sh`](install.sh) to symlink every skill under [`skills/`](skills/) into your local agent skill directories:

```bash
./install.sh
```

The script links each `skills/<skill-name>` folder into:

- `~/.claude/skills`
- `~/.agents/skills`
- `~/.gemini/config/skills`

If one of those target directories is itself a symlink, `install.sh` replaces it with a real directory first. Existing non-symlink files or directories at individual skill destinations (`<target_dir>/<skill-name>`) are skipped rather than overwritten.

## Structure

```text
llm-skills/
├── README.md
├── install.sh
└── skills/
    ├── analyze-stock/
    │   └── SKILL.md
    ├── commit-changes/
    │   └── SKILL.md
    ├── executive-summary/
    │   └── SKILL.md
    ├── release-zed/
    │   └── SKILL.md
    └── research-paper-summarize/
        └── SKILL.md
```

## License

MIT
