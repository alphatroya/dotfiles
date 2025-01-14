eval "$(/opt/homebrew/bin/brew shellenv)"

if status is-interactive
    set -x EDITOR "nvim"
    set -x VISUAL "nvim"
    set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"

    # Russian typos
    alias учше="exit"

    # alternatives to standard tools
    alias vim="nvim"
    alias less="bat"
    alias cat="bat -pp"
    alias ls="ls --color=auto"

    # git aliases
    alias ga="git add"
    alias gaa="git add --all"
    alias gco="git checkout"
    alias gc="git commit --verbose"
    alias gs="git status"
    alias gp="git push"
    alias gP="git pull"
    alias gloga="git log --all --graph --pretty=format:'%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative"
    alias gfap="git fetch --all"

    # difftastic
    alias gd="GIT_EXTERNAL_DIFF=difft git diff"
    alias gdc="GIT_EXTERNAL_DIFF=difft git diff --cached"
    alias gsh="GIT_EXTERNAL_DIFF=difft git show --ext-diff"

    alias qc="atr-capture"
    alias йс="atr-capture"

    alias typora="open -a typora"

    mise activate fish | source

    # Configure zoxide
    mise exec zoxide -- zoxide init fish --cmd cd | source

    # starship prompt
    mise exec -- starship init fish | source

    # configure atuin
    atuin init fish --disable-up-arrow | source

    # jj completion
    mise exec -- jj util completion fish | source
end
