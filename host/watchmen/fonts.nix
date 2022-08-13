{ config, pkgs, ... }:

with pkgs; {
  fonts = {
    fontDir = {
      enable = true;
    };
    enableDefaultFonts = true;
    fonts = with pkgs; [
      hack-font
      fira-code
      ubuntu_font_family
      inconsolata
      noto-fonts
      noto-fonts-emoji
      # iosevka
      jetbrains-mono
      nerdfonts
      corefonts
      liberation_ttf
      source-code-pro
      jetbrains-mono
      montserrat
      inter
    ];
  };
}
