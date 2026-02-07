if status is-interactive
    set fish_tmux_autostart true
    set fish_tmux_config "~/.config/tmux/tmux.conf"

    set -g fish_key_bindings fish_vi_key_bindings

    starship init fish | source

    set -Ux CARAPACE_BRIDGES 'zsh,fish,bash,inshellisense' # optional
    carapace _carapace | source

    fzf --fish | source
    zoxide init fish | source

    atuin init fish | source

    abbr -a --position anywhere -- --help '--help | bat -plhelp'
    abbr -a --position anywhere -- -h '-h | bat -plhelp'

    set -Ux MANPAGER "bat -plman"
    set -Ux EZA_CONFIG_DIR "$HOME/.config/eza"
    set -Ux EZA_ICONS_AUTO

    set -Ux _ZO_FZF_OPTS "--tmux center,90% \
      --layout reverse \
      --border rounded \
      --preview \"echo {} | choose 1: | eza -a --tree --level=2 --git --color=always --icons=always --group-directories-first\" \
      --color=bg+:#313244,bg:#1E1E2E,spinner:#F5E0DC,hl:#F38BA8 \
      --color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC \
      --color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8 \
      --color=selected-bg:#45475A \
      --color=border:#6C7086,label:#CDD6F4"

    set -Ux FZF_DEFAULT_OPTS "--tmux center,90% \
      --layout reverse \
      --border rounded \
      --preview \"bat --color=always --style=numbers --line-range=:500 {}\" \
      --color=bg+:#313244,bg:#1E1E2E,spinner:#F5E0DC,hl:#F38BA8 \
      --color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC \
      --color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8 \
      --color=selected-bg:#45475A \
      --color=border:#6C7086,label:#CDD6F4"
    set -Ux FZF_CTRL_T_OPTS "
      --walker-skip .git,node_modules,target
      --preview 'bat -n --color=always {}'
      --bind 'ctrl-/:change-preview-window(down|hidden|)'"
    set -Ux FZF_CTRL_R_OPTS "
      --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
      --color header:italic
      --header 'Press CTRL-Y to copy command into clipboard'
      --preview \"\""

    set -Ux FZF_ALT_C_OPTS "
      --walker-skip .git,node_modules,target
      --preview 'tree {}'"

    bind -M insert \cF rfv

    fish_config theme choose "Catppuccin Mocha"
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
