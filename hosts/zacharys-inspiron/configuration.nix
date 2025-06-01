{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.networkmanager.enable = true;

  catppuccin.enable = true;
  catppuccin.flavor = "mocha";

  systemd.services."getty@tty1".enable = false;
  services.displayManager.sessionPackages = [ pkgs.hyprland ];
  services.displayManager.ly = {
    enable = true;
  };

  services.upower.enable = true;

  programs.thunar.enable = true;

  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  swapDevices = [{ device = "/swapfile"; }];
  
  environment.systemPackages = with pkgs; [
    alacritty
    nh
    brightnessctl
    bluez
  ];

  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
  };

  time.timeZone = "America/New_York";

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  services.xserver.videoDrivers = [ "modesetting" ];
  hardware.graphics.enable = true;
  hardware.graphics.extraPackages = with pkgs; [
    intel-media-driver
  ];

  users.users.ztcollazo = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" "bluetooth" ];
  };

  hardware.firmware = with pkgs; [ linux-firmware ];
  hardware.enableAllFirmware = true;
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  boot.kernelModules = [ "i915" ];
  boot.kernelParams = [
    "zswap.enabled=1"
    "zswap.compressor=zstd"
    "zswap.max_pool_percent=20"
  ];
  boot.extraModulePackages = with config.boot.kernelPackages; [ broadcom_sta ];
  boot.blacklistedKernelModules = [ "b43" "ssb" "bcma" "brcmsmac" "brcmfmac" ];
}
