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
in {
  imports = [
    ./modules/common.nix
  ] ++ (modulesForHost host);

  home.packages = lib.mkMerge [
    config._module.args.basePkgs
    (if (config._module.args.hyprlandPkgs or null) != null then config._module.args.hyprlandPkgs else [])
  ];
}
