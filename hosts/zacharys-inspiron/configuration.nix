{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.networkmanager.enable = true;

  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
  };

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  users.users.ztcollazo = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" ];
  };

  hardware.firmware = with pkgs; [ linux-firmware ];
  boot.extraModulePackages = with config.boot.kernelPackages; [ broadcom_sta ];
  boot.blacklistedKernelModules = [ "b43" "ssb" "bcma" "brcmsmac" "brcmfmac" ];
}
