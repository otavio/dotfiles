{ config, pkgs, lib, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix

      <home-manager/nixos>

      ../nixos/base.nix
      ../nixos/bluetooth.nix
      ../nixos/desktop.nix
      ../nixos/udev.nix
      ../nixos/x11.nix
    ];

  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    kernelPackages = pkgs.linuxPackages_latest;
  };

  hardware.cpu.intel.updateMicrocode = true;

  powerManagement.cpuFreqGovernor = "performance";

  networking.hostName = "nano"; # Define your hostname.

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;

  networking.networkmanager.enable = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "br-latin1-us";
  };

  # Enable fstrim (for SSD disks)
  services.fstrim.enable = true;
  services.fstrim.interval = "weekly";

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    forwardX11 = true;
  };

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 22 ];

  virtualisation.docker.enable = true;
  users.users.otavio.extraGroups = [ "docker" ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.05"; # Did you read the comment?
}
