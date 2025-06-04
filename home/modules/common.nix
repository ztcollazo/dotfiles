{ config, pkgs, host, ... }:

{
  config = {
    home.username = "ztcollazo";
    home.homeDirectory = if host == "Zacharys-MacBook-Air" then "/Users/ztcollazo" else "/home/ztcollazo";
  
    _module.args.basePkgs = with pkgs; [
      podman
      htop
      tldr
      pass
    ];
  
    catppuccin.enable = true;
    catppuccin.flavor = "mocha";
  
    programs.helix.enable = true;
    programs.neovim.enable = true;
    programs.btop.enable = true;

    accounts.email.accounts.Personal = {
      address = "ztcollazo08@gmail.com";
      primary = true;
      realName = "Zachary Collazo";
      userName = "ztcollazo08@gmail.com";
      flavor = "gmail.com";
      passwordCommand = "pass show email/ztcollazo08@gmail.com";
    };

    programs.git = {
      enable = true;
      userName = "Zachary Collazo";
      userEmail = "ztcollazo08@gmail.com";
      signing = {
        key = "D6DAF3A225E2D238572C2C963E484412695C0D9B";
        signByDefault = true;
      };
      extraConfig.credential.helper = "${
        pkgs.git.override { withLibsecret = true; }
      }/bin/git-credential-libsecret";
    };

    services.gpg-agent = {
      enable = true;
      pinentry.package = if host == "Zacharys-MacBook-Air" then pkgs.pinentry_mac else pkgs.pinentry-gnome3;
    };

    programs.gitui.enable = true;
  
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
  };
}
