final: prev: {
  gnome-boxes = prev.gnome3.gnome-boxes.overrideAttrs (oldAttrs: rec {
    buildInputs = with prev.pkgs; [
      acl
      cyrus_sasl
      freerdp
      gdbm
      glib
      glib-networking
      gmp
      gnome3.adwaita-icon-theme
      gtk-vnc
      gtk3
      gtksourceview4
      json-glib
      libapparmor
      libarchive
      libcap
      libcap_ng
      libgudev
      libhandy_0
      libosinfo
      librsvg
      libsecret
      libsoup
      libusb1
      libvirt
      libvirt-glib
      libxml2
      numactl
      spice-gtk
      spice-protocol
      systemd
      tracker
      tracker-miners
      vte
      webkitgtk
      yajl
    ];
  });
}