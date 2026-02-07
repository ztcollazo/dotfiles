mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")
atuin init nu | save -f ($nu.data-dir | path join "vendor/autoload/atuin.nu")
carapace _carapace nushell | save -f ($nu.data-dir | path join "vendor/autoload/carapace.nu")
zoxide init nushell | save -f ($nu.data-dir | path join "vendor/autoload/zoxide.nu")

use alias.nu *

$env.config = ($env.config | merge {
    edit_mode: vi
    cursor_shape: {
        vi_insert: line
        vi_normal: block
        emacs: block
    }
    completions: {
        quick: true
        partial: true
        algorithm: "prefix"
        external: {
            enable: true
            max_results: 100
        }
    }
    table: {
        index_mode: always
        header_on_separator: true
    }
    rm: {
        always_trash: false
    }
})

$env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense'

$env.MANPAGER          = "bat -l man -p"
$env.EZA_CONFIG_DIR    = $"($env.HOME)/.config/eza"
$env.EZA_ICONS_AUTO    = true

$env._ZO_FZF_OPTS = ("--tmux center,90%
  --layout reverse
  --border rounded
  --preview \"echo {} | choose 1: | eza -a --tree --level=2 --git --color=always --icons=always --group-directories-first\"
  --color=bg+:#313244,bg:#1E1E2E,spinner:#F5E0DC,hl:#F38BA8
  --color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC
  --color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8
  --color=selected-bg:#45475A
  --color=border:#6C7086,label:#CDD6F4" | str replace --all --multiline "\\s+" " ")

$env.FZF_DEFAULT_OPTS = ("
  --tmux center,90%
  --layout reverse
  --border rounded
  --preview \"bat --color=always --style=numbers --line-range=:500 {}\"
  --color=bg+:#313244,bg:#1E1E2E,spinner:#F5E0DC,hl:#F38BA8
  --color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC
  --color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8
  --color=selected-bg:#45475A
  --color=border:#6C7086,label:#CDD6F4" | str replace --all --multiline "\\s+" " ")

$env.FZF_CTRL_T_OPTS = ("
  --walker-skip '.git,node_modules,target'
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"| str replace --all --multiline "\\s+" " ")

$env.FZF_CTRL_R_OPTS = ""
$env.FZF_CTRL_R_COMMAND = ""

$env.FZF_ALT_C_OPTS = ("
  --walker-skip .git,node_modules,target
  --preview 'eza -a --tree --level=2 --git --color=always --icons=always --group-directories-first'" | str replace --all --multiline "\\s+" " ")

def --wrapped h [...rest] {
    $rest | str join ' ' | append "| bat -plhelp" | str join ' ' | nu -c $in
}

$env.PATH = ($env.PATH | prepend ($env.HOME | path join ".local" "bin"))
$env.PATH = ($env.PATH | prepend ($env.CARGO_HOME? | default ($env.HOME | path join ".cargo" "bin")))

source ~/.cargo/env.nu
