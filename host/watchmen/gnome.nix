{ config, pkgs, ... }:

with pkgs; {

  services = {
    xserver = {
      displayManager.gdm = {
        enable = true;
        #nvidiaWayland = true;
      };
      desktopManager.gnome.enable = true;
    };

    gnome = {
      gnome-user-share.enable = true;
      chrome-gnome-shell.enable = true;
      tracker.enable = true;
      tracker-miners.enable = true;
      experimental-features.realtime-scheduling = true;
    };
  };

  qt5 = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita";
  };

  programs = {
    gnupg.agent.pinentryFlavor = "gnome3";
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
    ];
  };
}
