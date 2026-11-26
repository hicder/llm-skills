---
name: commit-changes
description: >-
  Create a new branch on top of the latest origin/main or origin/master and
  commit local changes with a Conventional Commit title and clear change
  description. Use when the user asks to commit changes, create a commit,
  or invoke the commit-changes skill.
---

# Commit Changes

Safely pull the latest default branch (`origin/main` or `origin/master`), create a fresh branch directly on top of it, and commit your changes with a Conventional Commit title and a clear description of what changed.

## Workflow

### 1. Inspect the working tree and repository state

Run `git status` and review all changes before modifying branches:

```bash
git status
git diff
git diff --staged
```

- If there are **no** uncommitted changes (staged, unstaged, or untracked), stop and inform the user there is nothing to commit.
- Note whether specific files were already staged (`git diff --staged --name-only`). If only a subset of changes was explicitly staged by the user, preserve that selection when committing; otherwise plan to stage all relevant modified/untracked files (excluding secrets such as `.env` or credential files—warn the user if any are present).
- Check `git remote -v` and determine the default base branch (`main` or `master`):
  ```bash
  git fetch origin
  ```
  Resolve which exists on `origin`: prefer `origin/HEAD` if set (`git symbolic-ref --short refs/remotes/origin/HEAD` -> `origin/main` or `origin/master`), otherwise check `git show-ref --verify refs/remotes/origin/main` then `refs/remotes/origin/master`. If neither exists, stop and ask the user which base branch to target.

### 2. Pull `origin/<base>` and create a new branch on top of it

Never commit directly to `main` or `master`. Ensure the new branch starts cleanly from the latest `origin/<base>`:

1. **Stash uncommitted work (if any):**
   ```bash
   git stash push -u -m "commit-changes: temporary stash"
   ```
   *(If the user had intentionally staged only a subset of files, record those paths beforehand so you only re-stage those paths after popping.)*

2. **Checkout and pull the base branch (`main` or `master`):**
   ```bash
   git checkout <base>
   git pull --ff-only origin <base>
   ```
   - If `git pull --ff-only origin <base>` fails (e.g., local `<base>` has diverged from `origin/<base>`), **stop immediately**, restore the stash if needed, and report the divergence to the user rather than force-resetting or creating a merge commit.

3. **Create a new branch on top of the freshly pulled `<base>`:**
   Choose a concise, descriptive branch name prefixed with the commit type (e.g., `feat/<short-kebab-summary>`, `fix/<short-kebab-summary>`, `refactor/<short-kebab-summary>`):
   ```bash
   git checkout -b <type>/<short-kebab-summary>
   ```

4. **Re-apply the stashed changes:**
   ```bash
   git stash pop
   ```
   - If `git stash pop` hits merge conflicts, **stop immediately** and report the conflicting files to the user (the stash entry is preserved on conflict).

### 3. Write a Conventional Commit title and clear description

Draft the commit message strictly following **Conventional Commits**:

1. **Title (subject line):**
   Format: `<type>[optional scope][!]: <description>`
   - **Allowed types:** `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `build`, `ci`, `chore`, `revert`
   - Use imperative, present-tense phrasing (e.g., `add`, `fix`, `remove`, not `added`/`fixes`), lowercase after the colon (except proper nouns/acronyms), no trailing period, and keep it concise (ideally <= 72 characters).
   - Add `!` before `:` (and a `BREAKING CHANGE:` footer) if the change breaks backwards compatibility.

2. **Body (clear description of what changes):**
   Separate from the title with a blank line. Explain clearly:
   - **What changed** across the modified files/components (use concise bullet points when multiple parts changed).
   - **Why** the change is needed or what problem it solves, plus any important caveats, assumptions, or breaking changes.
   - Avoid vague lines like "update code" or "misc fixes".

Example:
```text
feat(auth): enforce PKCE verification on OAuth callback

- Validate the code_verifier against the stored code_challenge before issuing session tokens
- Reject callback requests missing a valid state or verifier with HTTP 400
- Add unit tests covering missing, mismatched, and valid PKCE flows
```

### 4. Stage, commit, and verify

1. Stage the intended files (`git add <paths>` or `git add -A` when all changes belong in the commit, after confirming no untracked secrets/artifacts are included).
2. Commit with both title and body:
   ```bash
   git commit -m "<conventional-commit-title>" -m "<clear-description-body>"
   ```
3. Verify the result:
   ```bash
   git status
   git branch --show-current
   git log -1 --stat
   ```
4. Report to the user:
   - New branch name and base (`origin/<base>` @ `<base-short-sha>`)
   - Commit short SHA, title, and body
   - Summary of committed files
