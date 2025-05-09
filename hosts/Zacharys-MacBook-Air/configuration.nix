{ config, pkgs, ...}:

{
    environment.systemPackages = with pkgs; [
        pinentry_mac
        colima
        lima
        maccy
    ];

    users.users."ztcollazo".home = "/Users/ztcollazo";


    system.defaults = {
        dock.autohide = true;
        finder.AppleShowAllExtensions = true;
    };

    nixpkgs.hostPlatform = "aarch64-darwin";


    homebrew = {
        enable = true;

        onActivation = {
            autoUpdate = true;
            cleanup = "zap";  # "zap" nukes unlisted brews/casks; "uninstall" just removes unlisted ones
        };

        casks = [
            "arc"
            "iterm2"
            "dbngin"
            "protonvpn"
            "syncthing"
            "raycast"
            "balenaetcher"
            "appcleaner"
            "devcleaner"
            "gpg-suite-no-mail"
        ];
    };
}
