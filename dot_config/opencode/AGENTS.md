# VCS

- I use **Jujutsu** for working with version control instead of **Git**.
- When I **intend** to commit or edit the description for the current change, I use `jj commit -m` or `jj desc -m`.
- Use `jj abandon` instead of `git reset --hard` when needed.
- Use `jj fix` after changes to reformat source code with code formatters.
- Do not use conventional commits format in new jj commit messages.

# Commit Message Styleguide

- Use simple structure with clear distinctive title and short (3-5 lines) description
- If bug tracker ID is provided, prefix title with it using single space separator (e.g., "XXXX-1 Title")
- Keep commit messages concise and focused on the main change purpose

