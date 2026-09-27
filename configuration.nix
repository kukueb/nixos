{ config, lib, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.efiSupport = true;

  boot.loader.grub.device = "nodev";
  boot.loader.efi.canTouchEfiVariables = true;

  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Moscow";

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
    QT_QPA_PLATFORMTHEME = "qtct";
    QT_STYLE_OVERRIDE = "kvantum";
  };

  # auto mount
  fileSystems."/mnt/xfspart" = {
    device = "/dev/disk/by-uuid/f4d62fb5-fd19-4a89-b289-93680aecd6d2";
    fsType = "xfs"; 
    options = [
      "users"
      "nofail"
      "x-systemd.automount"
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
  programs.hyprland = {
    enable = true;
    withUWSM = false;
    xwayland.enable = true;
  };

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

  programs.gpu-screen-recorder = {
    enable = true;
    ui.enable = true;
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
    feh  

    dconf
    adw-gtk3
    gnome-themes-extra

    lazygit
    tldr
    fzf
    ripgrep

    7zip
    unzip
  ];

  programs.dconf.enable = true;

  hardware.usb-modeswitch.enable = true; # For my usb wifi adapter
  hardware.enableRedistributableFirmware = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;


  xdg.portal = {
    enable = true;
    extraPortals = [ 
      pkgs.xdg-desktop-portal-gnome 
      pkgs.xdg-desktop-portal-gtk 
    ];
    config.niri.default = ["gnome" "gtk"];
  };

	# System fonts
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

  # List of services
  services = {
    displayManager.sddm.enable = true;
    displayManager.sddm.wayland.enable = true;

    xserver.videoDrivers = [ "nvidia" ];

    pipewire = {
      enable = true;
      pulse.enable = true;
    };

  };

  # illogical impulse
	# services.geoclue2.enable = true;  # For QtPositioning
	# services.networkmanager.enable = true;  # For network management

  system.stateVersion = "26.11";

}

