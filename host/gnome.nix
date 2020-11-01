{ config, pkgs, ... }:

with pkgs; {
  services = {
    xserver = {
      displayManager.gdm = {
        enable = true;
        #nvidiaWayland = true;
      };
      desktopManager.gnome3.enable = true;
    };

    gnome3 = {
      gnome-user-share.enable = true;
      chrome-gnome-shell.enable = true;
      tracker.enable = true;
      tracker-miners.enable = true;
    };

  };

  qt5 = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita";
  };

  environment.gnome3.excludePackages = with pkgs.gnome3; [
    epiphany
    geary
    #gnome-software
    #gnome-packagekit
  ];
}
