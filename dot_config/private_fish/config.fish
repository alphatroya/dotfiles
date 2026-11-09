fish_add_path --path "$HOME/.local/bin"
# >>> mise:activate >>> managed by mise — do not edit between markers
if status is-interactive
    mise activate fish | source
else
    mise activate fish --shims | source
end
# <<< mise:activate <<<
eval "$(/opt/homebrew/bin/brew shellenv)"
mise exec -- zoxide init fish --cmd cd | source
mise exec -- atuin init fish --disable-up-arrow | source
mise exec -- jj util completion fish | source
