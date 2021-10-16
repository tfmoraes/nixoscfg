{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "thiago";
  # home.homeDirectory = "/home/thiago";

  home.packages = with pkgs; [
    any-nix-shell
    cachix
    fortune
    htop
    ncdu
    niv

    # gnome
    gnome.gnome-boxes
    gnome.gnome-tweak-tool
    transmission-gtk

    # neovim and language server
    black
    clang-analyzer
    # cmake-language-server
    glow
    gopls
    ltrace
    luajitPackages.lua-lsp
    neovim
    neovim-qt
    #neovide
    neovim-remote
    ninja
    nixpkgs-fmt
    nodePackages.pyright
    nodePackages.vim-language-server
    nodePackages.vscode-html-languageserver-bin
    nodePackages.prettier
    python-language-server
    rnix-lsp
    rust-analyzer
    strace
    # sumneko
    universal-ctags
    vimlsp
    vscode
    tree-sitter

    # chromium
    # gimp
    # inkscape
    keepassxc
    # libreoffice-fresh
    # meshlab
    pavucontrol
    # paraview
    thunderbird-bin
    virtmanager
    vlc
    zettlr
    zotero

    appimage-run
    binutils
    buildah
    fdupes
    ffmpeg-full
    gitg
    # haskellPackages.pandoc-citeproc
    imagemagick
    pandoc
    patchelf
    starship
    steam-run
    texlive.combined.scheme-full
    toolbox
    vulkan-tools
    wineWowPackages.fonts
    wineWowPackages.full

    cudatoolkit
    cudnn
    opencl-icd

    (pkgs.python3.withPackages (ps:
      with ps; [
        beautifulsoup4
        click
        cython
        gdcm
        imageio
        ipython
        isort
        Keras
        keras-applications
        keras-preprocessing
        matplotlib
        networkx
        nibabel
        numba
        numpy
        opencv4
        pandas
        plaidml
        psutil
        pycairo
        pydot
        pygobject3
        pypubsub
        requests
        scikitimage
        scikitlearn
        scipy
        seaborn
        sympy
        TheanoWithCuda
        vtk_9
        wxPython_4_0
        yapf
      ]))
  ];

  services = {

    nextcloud-client = {
      enable = true;
    };

    # dropbox = {
    # enable = true;
    # # path = "${config.home.homeDirectory}/Dropbox/";
    # };

    gnome-keyring = { enable = true; };

  };

  # nixpkgs.overlays = [
  # (self: super: {
  # dropbox-cli = pkgs.writeScriptBin "dummy-dropbox-cli" "" // {
  # outPath = "@dropbox-cli@";
  # };
  # })
  # ];

  # nmt.script = ''
  # serviceFile=home-files/.config/systemd/user/dropbox.service
  # assertFileExists $serviceFile
  # '';

  programs = {

    starship = {
      enable = true;
      enableFishIntegration = true;
    };

    firefox = {
      enable = true;
      package = pkgs.firefox-bin;
    };

    chromium = {
      enable = true;
      package = pkgs.chromium.override {
        commandLineArgs = "--enable-features=UseOzonePlatform --ozone-platform=wayland";
      };
    };

    fish = {
      enable = true;
      promptInit = ''
        any-nix-shell fish --info-right | source
      '';
      functions = { fish_greeting = ""; };
    };

    fzf = {
      enable = true;
      enableFishIntegration = true;
    };

    direnv = {
      enable = true;
      enableFishIntegration = true;
      nix-direnv = {
        enable = true;
        enableFlakes = true;
      };
      # stdlib = ''
      # mkdir -p $HOME/.cache/direnv/layouts
      # pwd_hash=$(echo -n $PWD | shasum | cut -d ' ' -f 1)
      # direnv_layout_dir=$HOME/.cache/direnv/layouts/$pwd_hash
      # '';
    };

    #command-not-found = {
    #  enable = true;
    #};

    nix-index = {
      enable = true;
      enableFishIntegration = true;
    };

    git = {
      enable = true;
      lfs.enable = true;
      userName = "Thiago Franco de Moraes";
      userEmail = "totonixsame@gmail.com";
      aliases = {
        fo = "fetch origin";
        fu = "fetch upstream";
        lol = "log --graph --decorate --pretty=oneline --abbrev-commit";
        lola = "log --graph --decorate --pretty=oneline --abbrev-commit --all";
      };
      signing = {
        signByDefault = true;
        key = "1B96996EE6559B7A";
      };
      extraConfig = {
        init.defaultBranch = "main";
      };
    };

    jq = { enable = true; };

    # neovim = {
    # enable = true;
    # withNodeJs = true;
    # withPython = true;
    # withPython3 = true;
    # withRuby = true;

    # extraPythonPackages = (ps: with ps; [
    # pynvim
    # ]);

    # extraPython3Packages = (ps: with ps; [
    # pynvim
    # black
    # isort
    # pylint
    # ]);

    # extraPackages = [
    # pkgs.cscope
    # pkgs.nixpkgs-fmt
    # pkgs.rnix-lsp
    # ];
    # };
  };

  home.file = rec {
    ".config/fish/functions/nix-shell-with-gc.fish".text = ''
      function nix-shell-with-gc
        mkdir -p .gcroots

        # add shell as gc-root in /nix/var/nix/gcroots/auto
        nix-instantiate shell.nix --indirect --add-root $PWD/.gcroots/shell.drv

        nix-shell (readlink $PWD/.gcroots/shell.drv) $argv[2..-1]
      end
    '';


    # "bin/command-not-found-handle".text = ''
    # #!/usr/bin/env bash
    # source ${pkgs.nix-index}/etc/profile.d/command-not-found.sh
    # command_not_found_handle $@
    # '';

    # "bin/command-not-found-handle".executable = true;

    # ".config/fish/functions/fish_greeting.fish".text = ''
    # '';

    # ".config/fish/functions/nix_index.fish".text = ''
    # function __fish_command_not_found_handler --on-event fish_command_not_found
    # $HOME/bin/command-not-found-handle $argv
    # end
    # '';
  };

  home.sessionVariables = {
    # PLAIDML_NATIVE_PATH = "${pkgs.python3Packages.plaidml}/lib/libplaidml.so";
    # RUNFILES_DIR = "${pkgs.python3Packages.plaidml}/share/plaidml";
    LD_LIBRARY_PATH = "$LD_LIBRARY_PATH:${pkgs.ocl-icd}/lib";
    EDITOR = "nvim";
    MOZ_ENABLE_WAYLAND = "1";
    QT_QPA_PLATFORM = "wayland-egl";
  };

  home.stateVersion = "20.09";
}
