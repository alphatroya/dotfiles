---
description: Describe the commit
agent: build
---

Describe the current changeset using `jj desc -m`.
Use "$ARGUMENTS" as a bug tracker ID if it not empty.

- Use simple structure with clear distinctive title and short (3-5 lines) description
- If bug tracker ID is provided, prefix title with it using single space separator (e.g., "XXXX-1 Title")
- Keep commit messages concise and focused on the main change purpose
- Do not use conventional commits format in new jj commit messages.
- You can retrieve the current changeset using `jj diff --git`.

