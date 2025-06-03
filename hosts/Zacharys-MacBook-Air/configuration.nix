{ config, pkgs, ...}:

{
    environment.systemPackages = with pkgs; [
        pinentry_mac
        colima
        lima
        maccy
        obsidian
        iterm2
    ];

    users.users."ztcollazo".home = "/Users/ztcollazo";
    system.primaryUser = "ztcollazo";

    system.defaults = {
        dock.autohide = true;
        finder.AppleShowAllExtensions = true;
    };

    nixpkgs.hostPlatform = "aarch64-darwin";
    system.stateVersion = 6;

    homebrew = {
        enable = true;

        onActivation = {
            autoUpdate = true;
            cleanup = "zap";  # "zap" nukes unlisted brews/casks; "uninstall" just removes unlisted ones
        };

        casks = [
            "arc"
            "dbngin"
            "protonvpn"
            "syncthing"
            "raycast"
            "balenaetcher"
            "appcleaner"
            "devcleaner"
            "gpg-suite-no-mail"
        ];

        masApps = {
            "Bluebook Exams" = 1645016851;
            HextEdit = 1557247094;
            Xcode = 497799835;
            Numbers = 409203825;
            Pages = 409201541;
            Keynote = 409183694;
            # Plash = 1494023538;
        };
    };
}
