# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.kernelModules = [ 
    "uinput"
  ];

  networking.hostName = "pteropusx"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Chicago";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  services.openssh = {
    enable = true;
    
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  # Enable Avahe daemon for mDNS resolution
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    nssmdns6 = true;

    # Enable the Avahi daemon to announce the host's name
    publish = {
      enable = true;
      addresses = true;
      workstation = true;
    };
  };

  # Setup for Graphics/Nvidia
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;
  
  # 1. Enable the X server (required for GNOME fallback and XWayland on Hyprland) 
  services.xserver.enable = true;
  
  # 2. Tell the X server to use the NVIDIA video driver
  services.xserver.videoDrivers = [ "nvidia" ];
  
  # 3. Use the stable NVIDIA package set (CRUCIAL)
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;

  hardware.nvidia.open = false;

  # 5. Keep this for Wayland support
  hardware.nvidia.modesetting.enable = true;

  # Essential environment variables for Wayland Compositors on NVIDIA
  environment.sessionVariables = {
    GBM_BACKEND = "nvidia-drm";
    LIBVA_DRIVER_NAME = "nvidia";
    NIXOS_OZONE_WL = "1"; # Helps with Electron/Chrome apps on Wayland

    #__GLX_VENDOR_LIBRARY_NAME = "nvidia"; # Forces X applications to use NVIDIA's GLX libraries
    #__EGL_VENDOR_LIBRARY_FILENAMES = "/run/opengl-driver/share/glvnd/egl_vendor.d/50_nvidia.json"; # Forces EGL (Wayland) to use NVIDIA files
  };

  # Enable the GNOME Desktop Environment.
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  # --- Hyprland/Wayland Configuration ---

  programs.hyprland = {
    enable = true;
    # Required to correctly initialize the driver/Wayland bridge on NVIDIA
    package = pkgs.hyprland; 
  };

  # Set Hyprland as the default display manager session
  services.displayManager.defaultSession = "hyprland";
  
  # XDG Portals (for file dialogs, screenshots, etc.)
  xdg.portal = {
    enable = true;
    wlr.enable = true; # Wlroots backend for Hyprland
    # Use GTK backend for file dialogs when not running GNOME
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ]; 
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  services.flatpak.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
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

  # Enable Syncthing as a system service running under your user account
  services.syncthing = {
    enable = true;
    user = "deiussum"; # <-- REPLACE WITH YOUR ACTUAL USERNAME
    dataDir = "/home/deiussum/.local/share/syncthing"; # Default data directory
    configDir = "/home/deiussum/.config/syncthing"; # Default config directory
    
    # Optional: If you want to enable the GUI web interface from other hosts:
    # openDefaultPorts = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;
  services.hardware.openrgb.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.deiussum = {
    isNormalUser = true;
    description = "Dan Jenkins";
    extraGroups = [ "networkmanager" "wheel" "input" "uinput" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Install 1Password
  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ "deiussum" ];
  };

  #OBS studio
  programs.obs-studio= {
    enable = true;
    enableVirtualCamera = true;

    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
      obs-vaapi
      obs-gstreamer
      obs-vkcapture
    ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim 
    neovim
    wget
    git
    tmux
    kitty
    grim
    slurp
    wofi
    waybar
    hyprpaper
    hypridle
    hyprshot
    hyprlock
    hyprpolkitagent
    swappy
    mako
    mesa-demos
    libglvnd
    libxrandr
    steam
    vulkan-tools
    stow
    libnotify
    brightnessctl
    openrgb
    wl-clipboard
    cliphist
    neofetch
    screenfetch
    fastfetch
    wlogout
    starship
  ];

  # --- System-Wide Font Configuration ---
  fonts = {
    # This option ensures Fontconfig is set up correctly
    fontconfig.enable = true; 

    packages = with pkgs; [
      # Add the specific package for Font Awesome icons
      font-awesome 

      # We can also add a general Nerd Font for completeness, 
      # using the full set of patched fonts:
      # This should work in modern NixOS versions:
      nerd-fonts.fira-code
    ];
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  networking.firewall.allowedUDPPorts = [ 5353 ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

}
