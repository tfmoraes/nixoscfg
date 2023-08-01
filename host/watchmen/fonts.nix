{ config, pkgs, ... }:

with pkgs; {
  fonts = {
    fontDir = {
      enable = true;
    };
    enableDefaultPackages = true;
    packages = with pkgs; [
      corefonts
      fira-code
      hack-font
      inconsolata
      inter
      iosevka
      jetbrains-mono
      jetbrains-mono
      liberation_ttf
      libertine
      montserrat
      nerdfonts
      noto-fonts
      noto-fonts-emoji
      source-code-pro
      ubuntu_font_family
    ];
  };
}
