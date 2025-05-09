{ config, lib, pkgs, modulesPath, ... }: {
    imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

    boot.initrd.availableKernelModules = [ "xhci_pci" "ehci_pci" "ahci" "usb_storage" "sd_mod" "sr_mod" "rtsx_usb_sdmmc" ];
    boot.initrd.kernelModules = [  ];
    boot.kernelModules = [ "kvm-intel" ];
    boot.extraModulePackages = [  ];

    filesystems."/" = {
        devices = "/dev/disk/by-label/NIXROOT";
        fsType = "ext4";
    };

    filesystems."/boot" = {
        device = "/dev/disk/by-label/NIXBOOT";
        fsType = "vfat";
        options = [ "fmask=0022" "dmask=0022" ];
    }

    swapDevices = [  ];

    networking.useDHCP = lib.mkDefault true;

    nixpkgs.hostPlatform = "x86_64-linux";
    hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}