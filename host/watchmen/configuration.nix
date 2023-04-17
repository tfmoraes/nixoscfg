{
  config,
  pkgs,
  inputs,
  ...
}:
with pkgs; {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./nvidia.nix
    ./sensors.nix
    ./network.nix
    ./gnome.nix
    ./fonts.nix
    ./dropbox.nix
    ./users.nix
    ./pi.nix
    # ./nix-ld.nix
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  nix = {
    # package = pkgs.nixUnstable;
    settings = {
      sandbox = true;
      trusted-users = ["root" "thiago"];
      auto-optimise-store = true;
    };
    # readOnlyStore = false;
    extraOptions = ''
      keep-outputs = true
      keep-derivations = true
      preallocate-contents = false
      experimental-features = nix-command flakes
    '';
    nixPath = let
      path = toString ./.;
    in [
      "nixpkgs=/etc/${config.environment.etc.nixpkgs.target}"
      "home-manager=/etc/${config.environment.etc.home-manager.target}"
      "nixos-config=${path}/configuration.nix"
    ];
    registry.nixpkgs.flake = inputs.nixpkgs;
  };

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    tmp.useTmpfs = true;
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      grub = {
        enable = false;
        devices = ["nodev"];
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
    podman = {
      enable = true;
      enableNvidia = true;
      extraPackages = with pkgs; [
        skopeo
        conmon
        runc
      ];
    };
    libvirtd = {
      enable = true;
    };
    # lxd = {
    # enable = true;
    # };
    # lxc = {
    # enable = true;
    # };
  };

  xdg = {
    portal = {
      enable = true;
      # extraPortals = with pkgs; [
      #   xdg-desktop-portal-kde
      # ];
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
      flamegraph
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

      egl-wayland
      qt5.qtwayland
      qt5ct

      docker-compose

      gcc
      clang
      clang-tools
      nodejs
      go
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
    fish = {
      enable = true;
    };

    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    steam = {
      enable = true;
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

    enableRedistributableFirmware = true;

    cpu = {
      amd.updateMicrocode = true;
    };

    pulseaudio = {
      enable = false;
      # package = pkgs.pulseaudioFull;
    };

    opengl = {
      driSupport = true;
      driSupport32Bit = true;
      extraPackages32 = with pkgs.pkgsi686Linux;
        [libva]
        ++ lib.optionals config.services.pipewire.enable [pipewire];
    };

    sane = {
      enable = true;
      extraBackends = with pkgs; [hplipWithPlugin];
    };

    bluetooth = {
      enable = true;
    };
  };

  security = {
    rtkit = {
      enable = true;
    };
  };

  services = {
    printing = {
      enable = true;
      drivers = with pkgs; [gutenprint hplipWithPlugin];
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

    openssh = {
      enable = true;
      settings.X11Forwarding = true;
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

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      # media-session.enable = false;
      wireplumber.enable = true;
    };

    # teamviewer.enable = true;

    locate = {
      enable = true;
    };
  };

  # 2020-12-25 Bug in systemd-resolved, workaround:
  # systemd.services.systemd-resolved.environment = with lib; {
  # LD_LIBRARY_PATH = "${getLib pkgs.libidn2}/lib";
  # };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
