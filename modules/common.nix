{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        git
        wget
        zsh
        curl
        cmake
        meson
        fd
        ripgrep
        libpq
        libssh
        gnupg
    ];

    programs.zsh.enable = true;

    programs.direnv = {
        enable = true;
        nix-direnv.enable = true;
    };

    fonts.packages = with pkgs; [ fontconfig jetbrains-mono nerd-fonts.jetbrains-mono ];

    users.users."ztcollazo".shell = pkgs.zsh;

    nix.package = pkgs.nix;

    nix.enable = true;
}
