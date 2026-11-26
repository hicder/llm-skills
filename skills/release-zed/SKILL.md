---
name: release-zed
description: >-
  Cut a GitHub release for the current Zed branch, sanitize and zip
  `/Applications/Zed Nightly.app` for distribution without Gatekeeper/xattr
  issues, generate branch-specific release notes, and upload `Zed-Nightly.zip`.
  Use when the user asks to release Zed, cut a Zed GitHub release, upload
  `Zed Nightly.app` to a release, or invoke the `release-zed` skill.
---

# Release Zed

Package `/Applications/Zed Nightly.app` cleanly from a temporary copy, create a GitHub release targeting the current branch, upload `Zed-Nightly.zip`, and write release notes covering the commits specific to this branch.

## Workflow

### 1. Inspect repository, branch, and GitHub state

Run a quick check on the git repo, `gh` CLI authentication, and `/Applications/Zed Nightly.app`:

```bash
git status -sb
git branch --show-current
git remote -v
gh auth status
defaults read "/Applications/Zed Nightly.app/Contents/Info.plist" CFBundleShortVersionString CFBundleVersion
```

- Resolve the GitHub `<owner>/<repo>` from `origin` (for example, `hicder/zed`).
- Confirm the current branch is pushed and up to date with `origin/<branch>`. If local commits have not been pushed yet, push the branch (`git push origin <branch>`) before creating the release so `--target` resolves to the latest commit.
- Verify the version in `/Applications/Zed Nightly.app/Contents/Info.plist` (`CFBundleShortVersionString`) matches `crates/zed/Cargo.toml` (`version = "..."`). If they differ, warn the user before proceeding in case `/Applications/Zed Nightly.app` is from an older build.

### 2. Choose the release tag and collect branch changes

1. Use `v<CFBundleShortVersionString>` (for example, `v1.32.0`) as the tag and title unless the user specifies a different tag.
2. Check existing releases and tags to make sure the tag does not already exist:
   ```bash
   gh release list --repo <owner>/<repo> --limit 10
   git ls-remote --tags origin <tag>
   ```
3. Identify the commits specific to this branch (do **not** rely blindly on `--generate-notes`, which compares against the previous release tag across unrelated branches and pulls in upstream commits):
   - Inspect recent commits:
     ```bash
     git log -n 20 --format="%h %s (%an)"
     ```
   - Find the fork/custom commits on top of the upstream base commit (typically the commits at the tip of the branch without upstream PR numbers `(#...)`, or `git log origin/main..HEAD` if `origin/main` tracks upstream).
   - Inspect each branch commit to write accurate release notes:
     ```bash
     git show --stat <sha1> <sha2> ...
     ```
   - Record the base commit SHA (`<base_sha>`, i.e. the parent of the oldest branch-specific commit) for the compare link `https://github.com/<owner>/<repo>/compare/<base_sha>...<tag>`.

### 3. Copy, sanitize, zip, and verify the `.app` bundle

Never modify `/Applications/Zed Nightly.app` in place. Work in a temporary directory:

```bash
tmp_dir=$(mktemp -d /tmp/zed-release-XXXXXX)
cp -R "/Applications/Zed Nightly.app" "$tmp_dir/"
```

Remove extended attributes (such as `com.apple.quarantine`) and package without resource forks or `__MACOSX` AppleDouble metadata:

```bash
xattr -cr "$tmp_dir/Zed Nightly.app"
(
  cd "$tmp_dir" &&
    ditto -c -k --norsrc --keepParent "Zed Nightly.app" Zed-Nightly.zip
)
```

> [!IMPORTANT]
> - Do **not** strip `_CodeSignature` or remove the ad-hoc signature from `Zed Nightly.app`. Apple Silicon Macs require at least an ad-hoc code signature to launch arm64 Mach-O binaries.
> - Use `ditto -c -k --norsrc --keepParent` rather than Finder Compress or `--sequesterRsrc`: `--norsrc` omits extended attributes (`com.apple.quarantine`, `com.apple.provenance`) and `__MACOSX`/`._*` entries from the zip while preserving executable permissions and symlinks.

Verify the generated archive before uploading:

```bash
unzip -l "$tmp_dir/Zed-Nightly.zip"
mkdir -p "$tmp_dir/verify"
ditto -x -k "$tmp_dir/Zed-Nightly.zip" "$tmp_dir/verify"
codesign --verify --deep --strict --verbose=2 "$tmp_dir/verify/Zed Nightly.app"
rm -rf "$tmp_dir/verify"
```

Confirm that:
- `unzip -l` shows no `__MACOSX/` or `._*` files.
- `codesign --verify --deep --strict` reports `valid on disk` and `satisfies its Designated Requirement`.

### 4. Create the GitHub release and clean up

Create the release targeting the current branch with branch-specific changelog notes and upload `Zed-Nightly.zip`:

```bash
gh release create "<tag>" "$tmp_dir/Zed-Nightly.zip" \
  --repo "<owner>/<repo>" \
  --target "<branch>" \
  --title "<tag>" \
  --notes "$(cat <<'EOF'
## Changes on `<branch>`

* **<Short Title>** (`<short_sha>`): <Concise summary of the change>
...

**Full Changelog**: https://github.com/<owner>/<repo>/compare/<base_sha>...<tag>
EOF
)"
```

Verify the published release and remove the temporary directory:

```bash
gh release view "<tag>" --repo "<owner>/<repo>"
rm -rf "$tmp_dir"
```

### 5. Report to the user

Include:
- The GitHub release URL and tag
- The target branch and HEAD commit SHA
- The uploaded asset (`Zed-Nightly.zip`) and its size
- The branch-specific changelog items included in the release notes
