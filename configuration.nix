# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # Include Home Manager
      <home-manager/nixos>
    ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking
  networking.hostName = "dizkneelande"; # Define your hostname.
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Australia/Brisbane";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_AU.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_AU.UTF-8";
    LC_IDENTIFICATION = "en_AU.UTF-8";
    LC_MEASUREMENT = "en_AU.UTF-8";
    LC_MONETARY = "en_AU.UTF-8";
    LC_NAME = "en_AU.UTF-8";
    LC_NUMERIC = "en_AU.UTF-8";
    LC_PAPER = "en_AU.UTF-8";
    LC_TELEPHONE = "en_AU.UTF-8";
    LC_TIME = "en_AU.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Enable Hyprland
  programs.hyprland.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.nell = {
    isNormalUser = true;
    description = "nell";
    extraGroups = [ "networkmanager" "wheel" "video" "audio" "disk" "lp" ];
    packages = with pkgs; [ ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Utils
    vim
    wget
    btop
    gtop
    htop
    git
    libvirt
    swww
    grim
    slurp
    lm_sensors
    unzip
    unrar
    gnome.file-roller
    libnotify
    wofi
    waybar
    mako
    networkmanagerapplet
    imv
    killall
    swaybg
    wlr-randr
    wlogout
    swappy
    pcmanfm
    kitty 
    nwg-look 
    xfce.thunar
    xfce.thunar-volman
    xfce.thunar-archive-plugin
    xfce.xfce4-terminal
    # Misc
    wl-clipboard
    cowsay
    lsd
    neofetch
    pkg-config
    cmatrix
    lolcat
    transmission-gtk
    tty-clock
    cool-retro-term
    home-manager
    gammastep
    # Photo & Video
    mpv
    gimp
    obs-studio
    blender
    # Online
    firefox
    thunderbird
    discord
    # Dev
    meson
    glibc
    hugo
    gnumake
    ninja
    go
    nodejs_21
    godot_4
    rustup
    rust-analyzer
    vscode
    # Audio and Brightness
    pavucontrol
    pamixer
    audacity
    brightnessctl
    # Gaming
    #zeroad
    #xonotic
    # Fonts
    ubuntu_font_family
    papirus-icon-theme
    catppuccin-papirus-folders
    tokyo-night-gtk
    bibata-cursors
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    google-fonts
    corefonts
    vistafonts
  ];
  
  # Nerdfonts
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "Ubuntu" "UbuntuMono" ]; })
  ];

  # Steam Configuration
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };
  
  # Nix Package Management
  nix = {
    settings.auto-optimise-store = true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
  
  ## -- home manager ---- ##
  
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.nell = import ./home.nix;
  };
  
}

