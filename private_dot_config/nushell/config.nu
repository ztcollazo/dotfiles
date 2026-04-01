mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")
atuin init nu | save -f ($nu.data-dir | path join "vendor/autoload/atuin.nu")
carapace _carapace nushell | save -f ($nu.data-dir | path join "vendor/autoload/carapace.nu")
zoxide init nushell | save -f ($nu.data-dir | path join "vendor/autoload/zoxide.nu")
tv init nu | save -f ($nu.data-dir | path join "vendor/autoload/tv.nu")

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

def --wrapped h [...rest] {
    $rest | str join ' ' | append "| bat -plhelp" | str join ' ' | nu -c $in
}

$env.PATH = ($env.PATH | prepend ($env.HOME | path join ".local" "bin"))
$env.PATH = ($env.PATH | prepend ($env.CARGO_HOME? | default ($env.HOME | path join ".cargo" "bin")))

source ~/.cargo/env.nu
