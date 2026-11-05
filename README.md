# dotfiles

My personal dotfiles, managed with [mise](https://mise.jdx.dev/). **macOS only.**

## Overview

| Area         | Tool                                                                 |
| ------------ | -------------------------------------------------------------------- |
| Dotfile mgmt | [mise](https://mise.jdx.dev/) (`mise dot`, `mise bootstrap`)          |
| Shell        | [fish](https://fishshell.com/) + [fisher](https://github.com/jorgebucaran/fisher) + [Tide](https://github.com/IlanCosman/tide) |
| Editor       | [Neovim](https://neovim.io/) + [lazy.nvim](https://github.com/folke/lazy.nvim) |
| VCS          | [git](https://git-scm.com/) + [Jujutsu (jj)](https://github.com/jj-vcs/jj) + [jjui](https://github.com/idursun/jjui) |
| Diffs        | [difftastic](https://github.com/Wilfred/difftastic)                  |
| Runtimes     | [mise](https://mise.jdx.dev/) (Go, Rust, Lua LS, …)                  |
| Terminal     | [Ghostty](https://ghostty.org/)                                      |
| Snippets     | [Espanso](https://espanso.org/)                                      |

## Install

Install Homebrew and mise first, then clone this repository to `~/.dotfiles`:
the `[dotfiles]` entries name their sources under that path.

```sh
git clone git@github.com:alphatroya/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
mise trust
mise bootstrap --dry-run
mise bootstrap
```

If you keep the checkout somewhere else, link it into place first:

```sh
ln -s /path/to/checkout ~/.dotfiles
```

## Layout

Sources keep their chezmoi-era names (`dot_config/`, `private_Library/`,
`dot_gitconfig.tmpl`), so every `[dotfiles]` entry names its source explicitly:

- `dot_config/mise/conf.d/*.toml` holds the durable mise config: dotfiles
  (`dotfiles.toml`), settings, tools, aliases, and bootstrap packages and
  hooks. mise links the directory into `~/.config/mise/conf.d`, so it applies
  to every mise invocation.
- Everything else is a source listed in `dotfiles.toml` together with its
  `$HOME` target.
- Machine-local mise config stays in `~/.config/mise/config.toml`.

Directories that applications also write to (Espanso, `~/.config/mise/conf.d`)
are linked file by file, so other files there are left alone.

## Updating

```sh
cd ~/.dotfiles
git pull
mise dot apply
```

`mise dot diff` previews the change, and `mise dot status` reports drift.

## Adding a file

Copy it into this repository, then add an entry with both source and target to
`[dotfiles]` in `dot_config/mise/conf.d/dotfiles.toml` and apply:

```toml
"~/.config/foo/config.toml" = { source = "dot_config/private_foo/config.toml" }
```

`mise dot add --source <repo path> <target>` writes the same entry for you.

```sh
mise dot apply --dry-run
mise dot apply
```

## What's included

- **fish** — interactive shell config: git aliases, difftastic integration,
  `zoxide` and `atuin` setup, `xcrecord` helper for recording iOS Simulator video.
- **Neovim** — modern Lua config:
  - `blink.cmp` autocompletion, `conform.nvim` auto-formatting, Telescope fuzzy finder
  - `gitsigns.nvim`, `indent-blankline`
  - LSP for Go (`gopls`), Lua (`lua_ls`), Swift (`sourcekit`)
  - Tree-sitter parsers and a Monokai Pro colorscheme
  - Russian/English keyboard `langmap` support
- **git** — sane defaults: rebase-on-pull, `autosquash`, `rerere`, diff/merge via
  Neovim, plus a macOS-aware global `.gitignore`.
- **jj / jjui** — Jujutsu config with difftastic as the diff formatter and a
  `swiftformat` fix tool.
- **mise** — managed runtimes and tools (`go`, `rust`, `jj-cli`, `jjui`,
  `lua-language-server`, `difftastic`, …), plus the dotfile deployments and
  bootstrap packages/hooks.
- **Ghostty** — Monokai Pro theme, option-as-alt, and a quick-terminal hotkey.
- **Espanso** — text-expansion snippets for emoji, timestamps, and
  app-specific snippets for Ghostty and Xcode (e.g. `gss_` → `guard let self else { return }`).

## License

[MIT](LICENSE.md) © Alexey Korolev
