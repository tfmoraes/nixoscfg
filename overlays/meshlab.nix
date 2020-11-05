self: super: {
  # meshlab = super.meshlab.overrideDerivation (oldAttrs: rec{
    # pname = "meshlab";
    # version = "MeshLab-2020.07";
    # name="${pname}-${version}";
    # src = super.pkgs.fetchFromGitHub {
      # owner = "cnr-isti-vclab";
      # repo = "meshlab";
      # rev = "Meshlab-2020.07";
      # sha256 = "00gg1sssicxb47s283kj160lhg03bd62rf6pbpad6qfx1lca4l8w";
    # };

    # postInstall = ''
      # ls -l
      # install -m 444 -D install/meshlab.png $out/share/pixmaps/meshlab.png
      # install -m 444 -D install/linux/resources/meshlab.desktop $out/share/applications/meshlab.desktop
      # substituteInPlace $out/share/applications/meshlab.desktop --replace 'Icon=/usr/share/pixmaps/meshlab.png' 'Icon=$out/share/pixmaps/meshlab.png'
    # '';

  # });
}
