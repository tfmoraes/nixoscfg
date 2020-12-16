{ config, pkgs, inputs, ... }:

with pkgs;
{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./nvidia.nix
      ./sensors.nix
      ./network.nix
      ./gnome.nix
      ./fonts.nix
      ./dropbox.nix
      ./users.nix
    ];

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  nix = {
    package = pkgs.nixUnstable;
    useSandbox = true;
    trustedUsers = [ "root" "thiago" ];
    readOnlyStore = false;
    autoOptimiseStore = true;
    extraOptions = ''
      keep-outputs = true
      keep-derivations = true
      preallocate-contents = false
      experimental-features = nix-command flakes
    '';
    nixPath = [
      "nixpkgs=/etc/${config.environment.etc.nixpkgs.target}"
      "home-manager=/etc/${config.environment.etc.home-manager.target}"
    ];
    registry.nixpkgs.flake = inputs.nixpkgs;
  };

  boot = {
    tmpOnTmpfs = true;
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      grub = {
        enable = false;
        devices = [ "nodev" ];
        efiSupport = true;
        useOSProber = true;
      };
    };
  };


  virtualisation = {
    docker = {
      enable = true;
      enableNvidia = true;
    };
    libvirtd = {
      enable = true;
    };
    lxd = {
      enable = true;
    };
    podman = {
      enable = true;
      extraPackages = [
        pkgs.crun
      ];
    };
  };

  # Select internationalisation properties.
  i18n.defaultLocale = "pt_BR.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  # List packages installed in system profile. To search, run:
  # $ nix search wget

  environment = {
    systemPackages = with pkgs; [
      curl
      firefox-bin
      git
      vim
      wget

      aspell
      aspellDicts.en
      aspellDicts.pt_BR
      direnv
      duperemove
      exfat
      file
      killall
      flameGraph
      gnupg
      graphviz
      htop
      lz4
      ntfs3g
      p7zip
      pciutils
      tree
      unrar
      unzip
      zlib
      xclip

      bat
      exa
      fd
      fzf
      hyperfine
      ripgrep
      tokei

      docker-compose

      gcc
      clang
      clang-tools
      nodejs
      go_bootstrap
      gnumake
      rustup
      (python3.withPackages (py: [
        py.requests
        py.ipython
        py.numpy
        py.scipy
      ]))
    ];

    etc = {
      home-manager.source = "${inputs.home-manager}";
      nixpkgs.source = "${inputs.nixpkgs}";
    };

  };

  programs = {
    fish.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  #   pinentryFlavor = "gnome3";
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  sound = {
    enable = true;
  };

  hardware = {

    enableAllFirmware = true;

    cpu = {
      amd.updateMicrocode = true;
    };

    pulseaudio = {
      enable = true;
      package = pkgs.pulseaudioFull;
    };

    opengl = {
      driSupport = true;
      driSupport32Bit = true;
    };

    sane = {
      enable = true;
      extraBackends = with pkgs; [ hplipWithPlugin ];
    };
  };

  services = {

    printing = {
      enable = true;
      drivers = with pkgs; [ gutenprint hplipWithPlugin ];
    };

    avahi = {
      enable = true;
      hostName = config.networking.hostName;
      ipv4 = true;
      nssmdns = true;
      publish = {
        enable = true;
        userServices = true;
      };
    };

    resolved = {
      enable = true;
    };

    smartd = {
      enable = true;
    };

    sshd = {
      enable = true;
    };

    xserver = {
      enable = true;
    };

    flatpak = {
      enable = true;
    };

    fstrim = {
      enable = true;
    };

    fwupd = {
      enable = true;
    };

    acpid = {
      enable = true;
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.09"; # Did you read the comment?
}
