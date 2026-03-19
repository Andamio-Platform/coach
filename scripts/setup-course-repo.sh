#!/bin/bash
# setup-course-repo.sh
# Links a course repo to coach skills and knowledge base
#
# Usage:
#   ./setup-course-repo.sh /path/to/coach
#   ./setup-course-repo.sh  # Uses LESSON_COACH_PATH env var or prompts

set -e

# Determine coach path
if [ -n "$1" ]; then
    LESSON_COACH="$1"
elif [ -n "$LESSON_COACH_PATH" ]; then
    LESSON_COACH="$LESSON_COACH_PATH"
else
    echo "Coach path not provided."
    echo "Usage: $0 /path/to/coach"
    echo "Or set LESSON_COACH_PATH environment variable"
    exit 1
fi

# Expand to absolute path
LESSON_COACH=$(cd "$LESSON_COACH" && pwd)

# Verify coach exists
if [ ! -d "$LESSON_COACH/skills" ]; then
    echo "Error: $LESSON_COACH doesn't appear to be a coach repo"
    echo "Expected to find skills/ directory"
    exit 1
fi

echo "Setting up course repo with coach at: $LESSON_COACH"

# Create skills directory
mkdir -p skills

# Remove existing symlinks (in case of re-run)
for skill in andamio-cli apprentice assess-slts beginner classify-lesson-types compile compound course-workflow draft-slts gather-code-examples gather-screenshots self-assess-readiness start teacher; do
    rm -f "skills/$skill"
done
rm -f knowledge
rm -f research

# Symlink each skill
for skill in andamio-cli apprentice assess-slts beginner classify-lesson-types compile compound course-workflow draft-slts gather-code-examples gather-screenshots self-assess-readiness start teacher; do
    ln -s "$LESSON_COACH/skills/$skill" "skills/$skill"
    echo "  Linked skill: $skill"
done

# Symlink knowledge and research
ln -s "$LESSON_COACH/knowledge" knowledge
echo "  Linked: knowledge/"
ln -s "$LESSON_COACH/research" research
echo "  Linked: research/"

echo ""
echo "Setup complete. 14 skills linked from coach."
echo ""
echo "Knowledge will compound back to: $LESSON_COACH/knowledge/"
