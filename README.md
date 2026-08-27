# dotfiles

My personal dotfiles, managed with [chezmoi](https://www.chezmoi.io/). **macOS only.**

## Overview

| Area         | Tool                                                                 |
| ------------ | -------------------------------------------------------------------- |
| Dotfile mgmt | [chezmoi](https://www.chezmoi.io/)                                    |
| Shell        | [fish](https://fishshell.com/) + [fisher](https://github.com/jorgebucaran/fisher) + [Tide](https://github.com/IlanCosman/tide) |
| Editor       | [Neovim](https://neovim.io/) + [lazy.nvim](https://github.com/folke/lazy.nvim) |
| VCS          | [git](https://git-scm.com/) + [Jujutsu (jj)](https://github.com/jj-vcs/jj) + [jjui](https://github.com/idursun/jjui) |
| Diffs        | [difftastic](https://github.com/Wilfred/difftastic)                  |
| Runtimes     | [mise](https://mise.jdh.me/) (Go, Rust, Lua LS, …)                   |
| Terminal     | [Ghostty](https://ghostty.org/)                                      |
| Snippets     | [Espanso](https://espanso.org/)                                      |

## Install

```sh
brew install chezmoi
chezmoi init alphatroya/dotfiles
```

Review the changes first, then apply:

```sh
chezmoi diff
chezmoi apply
```

## What's included

- **fish** — interactive shell config: git aliases, difftastic integration,
  `zoxide` and `atuin` setup, `xcrecord` helper for recording iOS Simulator video.
- **Neovim** — modern Lua config:
  - `blink.cmp` autocompletion, `conform.nvim` auto-formatting, Telescope fuzzy finder
  - `gitsigns.nvim`, `indent-blankline`, `nvim-orgmode` (with daily journal + agenda)
  - LSP for Go (`gopls`), Lua (`lua_ls`), Swift (`sourcekit`), Typst (`tinymist`)
  - Tree-sitter parsers and a Monokai Pro colorscheme
  - Russian/English keyboard `langmap` support
- **git** — sane defaults: rebase-on-pull, `autosquash`, `rerere`, diff/merge via
  Neovim, plus a macOS-aware global `.gitignore`.
- **jj / jjui** — Jujutsu config with difftastic as the diff formatter and a
  `swiftformat` fix tool.
- **mise** — managed runtimes and tools (`go`, `rust`, `jj-cli`, `jjui`,
  `lua-language-server`, `difftastic`, …).
- **Ghostty** — Monokai Pro theme, option-as-alt, and a quick-terminal hotkey.
- **Espanso** — text-expansion snippets for emoji, timestamps, and
  app-specific snippets for Ghostty and Xcode (e.g. `gss_` → `guard let self else { return }`).

## License

[MIT](LICENSE.md) © Alexey Korolev
