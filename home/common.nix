{ config, pkgs, ... }:

{
    home.username = "ztcollazo";
    home.homeDirectory = if pkgs.system == "aarch64-darwin" then "/Users/ztcollazo" else "/home/ztcollazo";

    imports = [
        ./modules/tmux.nix  
    ];

    home.sessionVariables.ZSH_TMUX_AUTOSTART = "true";

    programs.zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;

        initContent = ''
            eval "$(starship init zsh)"
        '';

        shellAliases = {
            ll = "ls -l";
        };

        oh-my-zsh = {
            enable = true;
            plugins = [ "git" "tmux" ];
        };
        history.size = 10000;
    };

    programs.starship = {
        enable = true;
        settings = {
            add_newline = true;
            command_timeout = 1300;
            scan_timeout = 50;
            format = "$all$nix_shell$nodejs$lua$golang$rust$php$git_branch$git_commit$git_state$git_status\n$username$hostname$directory";
            character = {
            success_symbol = "[](bold green) ";
            error_symbol = "[✗](bold red) ";
            };
        };
    };

    home.stateVersion = "25.05"; # or your current NixOS version
}
