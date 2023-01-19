{ config, pkgs, ... }:

with pkgs; {

  services = {
    xserver = {
      displayManager.gdm = {
        enable = true;
        #nvidiaWayland = true;
      };
      desktopManager = {
        gnome = {
          enable = true;
          sessionPath = with pkgs.gnome; [ mutter gnome-shell nautilus ];
        };
      };
    };

    gnome = {
      gnome-user-share.enable = true;
      gnome-browser-connector.enable = true;
      tracker.enable = true;
      tracker-miners.enable = true;
      # experimental-features.realtime-scheduling = true;
    };
  };

  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita";
  };

  programs = {
    gnupg.agent.pinentryFlavor = "gnome3";
    xwayland.enable = true;
    gnome-terminal.enable = true;
  };

  environment = {
    gnome.excludePackages = with pkgs.gnome; [
      epiphany
      geary
      #gnome-software
      #gnome-packagekit
    ];

    systemPackages = with pkgs; [
      qt5.qtwayland
      hicolor-icon-theme
      gnomeExtensions.appindicator
    ];
  };
}
