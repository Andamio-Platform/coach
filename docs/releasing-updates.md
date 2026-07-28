# Releasing Updates

How to publish a new version of Coach across all three distribution channels.

## Pre-release

1. Make your changes on a feature branch and merge to `main`.

2. Decide the version bump:
   - **Patch (1.0.1):** Wording improvements, typo fixes, minor knowledge corrections
   - **Minor (1.1.0):** New skills, significant instruction rewrites, new knowledge seed patterns
   - **Major (2.0.0):** Knowledge schema changes that break existing compound data, or skill removals

3. Update the version in three places:

   ```bash
   # package.json and plugin.json
   npm version patch   # or minor, or major
   ```

   This bumps `package.json` automatically. Then manually update `.claude-plugin/plugin.json` to match:

   ```bash
   # Edit .claude-plugin/plugin.json — change "version": "1.0.0" to new version
   ```

4. Update `CHANGELOG.md` with a new section:

   ```markdown
   ## [1.0.1] - 2026-03-25

   ### Fixed
   - Description of what changed

   [1.0.1]: https://github.com/Andamio-Platform/coach/releases/tag/v1.0.1
   ```

5. Update `metadata.version` in each changed SKILL.md frontmatter (if the skill itself changed).

6. Commit and push:

   ```bash
   git add .
   git commit -m "chore: release v1.0.1"
   git push origin main
   ```

7. Tag the release:

   ```bash
   git tag v1.0.1
   git push origin v1.0.1
   ```

## Channel 1: Claude Code Plugin Marketplace

### What users run

```
/plugin marketplace update
```

This pulls the latest from `Andamio-Platform/coach` main branch. Users get the new version automatically.

### What Andamio must do

Update the version in the marketplace entry:

```bash
cd $REPOS/andamio-marketplace
```

Edit `.claude-plugin/marketplace.json` — change the coach plugin's `"version"` to the new version:

```json
{
  "name": "coach",
  "version": "1.0.1",
  ...
}
```

Commit and push:

```bash
git add .
git commit -m "chore: bump coach to v1.0.1"
git push origin main
```

## Channel 2: npm (Pi.dev, Vercel Skills CLI)

### What users run

```bash
# Pi.dev
pi update npm:@andamio/coach

# npm direct
npm update @andamio/coach
```

### What Andamio must do

From the coach repo (after version bump in pre-release step):

```bash
npm publish --access public
```

Authenticate with OTP when prompted.

## Channel 3: Community Marketplaces (SkillsMP, SkillHub)

### What users do

Nothing — crawlers re-index automatically on their own schedule.

### What Andamio must do

Nothing beyond pushing to `main`. Crawlers pick up changes from the public GitHub repo. Ensure the GitHub release/tag exists for version tracking.

## Quick Reference

| Step | Command |
|------|---------|
| Bump version | `npm version patch` + edit `plugin.json` |
| Update changelog | Edit `CHANGELOG.md` |
| Push to GitHub | `git push origin main && git tag vX.Y.Z && git push origin vX.Y.Z` |
| Update marketplace | Edit `andamio-marketplace` version, push |
| Publish to npm | `npm publish --access public` |
| Community marketplaces | Automatic |
