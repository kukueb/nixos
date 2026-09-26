# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.efiSupport = true;
  # boot.loader.grub.efiInstallAsRemovable = true;

  boot.loader.grub.device = "nodev";
  boot.loader.efi.canTouchEfiVariables = true;

  # boot.loader.efi.efiSysMountPoint = "/boot/efi";
  # Define on which hard drive you want to install Grub.
  # boot.loader.grub.device = "/dev/sda"; # or "nodev" for efi only

  # networking.hostName = "nixos"; # Define your hostname.

  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Moscow";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Graphics
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;

    open = false;

    nvidiaSettings = true;

    package = config.boot.kernelPackages.nvidiaPackages.legacy_580;
  };

  environment.sessionVariables = {
    GBM_BACKEND = "nvidia-drm";
    LIBVA_DRIVER_NAME = "nvidia";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    WLR_NO_HARDWARE_CURSORS = "1";
    EDITOR = "nvim";
  };

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # auto mount
  fileSystems."/mnt/xfspart/" = {
    device = "/dev/disk/by-uuid/f4d62fb5-fd19-4a89-b289-93680aecd6d2";
    fsType = "xfs"; # Укажите вашу файловую систему (ntfs3, btrfs, ext4 и т.д.)
    options = [ 
      "users"          # Позволяет обычным пользователям монтировать/размонтировать
      "nofail"         # Не останавливать загрузку ПК, если диск отсутствует
      "x-systemd.automount" # Монтировать на лету при первом обращении к папке
    ];
  };

  users.users.kukueb = {
    isNormalUser = true;
    description = "kukueb";
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
      "audio"
    ];
    shell = pkgs.zsh;
  };

  # graphical environment
  programs.niri.enable = true;
  programs.hyprland.enable = true;

  # programs.firefox.enable = true;

  programs.throne.enable = true;
  programs.throne.tunMode.enable = true;

  programs.zsh.enable = true;

  programs.zsh.ohMyZsh = {
    enable = true;
    theme = "robbyrussell";
    plugins = [
    	"git"
    	"sudo"
    ];
  };

  environment.systemPackages = with pkgs; [
    vim
    wget
    neovim
    btop
    yazi
    zellij
    git
    nix-search
    fastfetch
  ];

  hardware.usb-modeswitch.enable = true; # For my usb wifi adapter
  hardware.enableRedistributableFirmware = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };


  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gnome ];
  };

	# System fonts (optional but recommended)
	fonts.packages = with pkgs; [
		rubik
		nerd-fonts.ubuntu
		nerd-fonts.jetbrains-mono
	];

  programs.steam = {
    enable = true;
    package = pkgs.steam.override {
      extraArgs = "-system-composer";
    };
  };

  # List services that you want to enable:
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;

  services.xserver.videoDrivers = [ "nvidia" ];

  # illogical impulse
	# services.geoclue2.enable = true;  # For QtPositioning
	# services.networkmanager.enable = true;  # For network management

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "26.05"; # Did you read the comment?

}

