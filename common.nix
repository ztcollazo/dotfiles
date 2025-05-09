{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        git
        neovim
        wget
        zsh
        curl
        cmake
        meson
        fd
        ripgrep
        podman
        libpq
        libssh
        obsidian
        starship
        gnupg
        helix
        direnv
        nix-direnv
    ];

    programs.zsh.enable = true;

    programs.direnv = {
        enable = true;
        nix-direnv.enable = true;
    };

    fonts.packages = with pkgs; [ fontconfig jetbrains-mono ];

    users.users."ztcollazo".shell = pkgs.zsh;

    nix.package = pkgs.nix;

    nix.enable = true;
}
