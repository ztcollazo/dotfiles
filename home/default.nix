{ config, lib, host, ... }:

let
  modulesForHost = hostname: {
    "zacharys-inspiron" = [
      ./modules/hyprland.nix
      ./modules/tmux.nix
    ];
    "Zacharys-MacBook-Air" = [
      ./modules/tmux.nix
    ];
  }.${hostname} or [];

  packages = config._module.args.packages;
in {
  imports = [
    ./modules/common.nix
  ] ++ (modulesForHost host);

  home.packages = lib.mkMerge [
    packages.base
    (if (packages.hyprland or null) != null then packages.hyprland else [])
  ];
}
