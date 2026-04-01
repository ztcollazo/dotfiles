if status is-interactive
    set fish_tmux_autostart true
    set fish_tmux_config "~/.config/tmux/tmux.conf"

    set -g fish_key_bindings fish_vi_key_bindings

    starship init fish | source

    set -Ux CARAPACE_BRIDGES 'zsh,fish,bash,inshellisense' # optional
    carapace _carapace | source

    zoxide init fish | source
    tv init fish | source

    atuin init fish | source

    abbr -a --position anywhere -- --help '--help | bat -plhelp'
    abbr -a --position anywhere -- -h '-h | bat -plhelp'

    set -Ux MANPAGER "bat -plman"
    set -Ux EZA_CONFIG_DIR "$HOME/.config/eza"
    set -Ux EZA_ICONS_AUTO

    fish_config theme choose catppuccin-mocha
end

function y
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    command yazi $argv --cwd-file="$tmp"
    if read -z cwd <"$tmp"; and [ "$cwd" != "$PWD" ]; and test -d "$cwd"
        z -- "$cwd"
    end
    rm -f -- "$tmp"
end

fish_add_path ~/.local/bin
source ~/.cargo/env.fish
source ~/.config/fish/alias.fish
