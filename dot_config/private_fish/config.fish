if status is-interactive
    set -x EDITOR "nvim"
    set -x VISUAL "nvim"
    set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"

    # Configure zoxide
    zoxide init fish --cmd cd | source

    # configure atuin
    atuin init fish --disable-up-arrow | source

    # jj completion
    mise exec -- jj util completion fish | source
end

function xcrecord
    xcrun simctl io booted recordVideo ~/Desktop/(uuidgen).mp4
end
