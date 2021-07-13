python-self: python-super:
let
  pkgs = import <nixpkgs> { };
in
{

  # nibabel = python-super.nibabel.overrideAttrs (oldAttrs: {
  # doInstallCheck = false;
  # propagatedBuildInputs = oldAttrs.propagatedBuildInputs
  # ++ [python-super.packaging];
  # });

  Keras = python-super.Keras.overrideAttrs (oldAttrs: rec {
    pname = "Keras";
    version = "2.2.4";
    name = "${pname}-${version}";
    src = python-super.fetchPypi {
      pname = "Keras";
      version = "2.2.4";
      sha256 = "1j8bsqzh49vjdxy6l1k4iwax5vpjzniynyd041xjavdzvfii1dlh";
    };
  });

  # dask = python-super.dask.overrideAttrs (oldAttrs: rec {
    # doCheck = false;
    # doInstallCheck = false;
    # checkInputs = [];
  # });

  # fsspec = python-super.fsspec.overrideAttrs (oldAttrs: rec {
    # disabledTests = [
      # # Test assumes user name is part of $HOME
      # # AssertionError: assert 'nixbld' in '/homeless-shelter/foo/bar'
      # "test_strip_protocol_expanduser"
      # # flaky: works locally but fails on hydra
      # # as it uses the install dir for tests instead of a temp dir
      # # resolved in https://github.com/intake/filesystem_spec/issues/432 and
      # # can be enabled again from version 0.8.4
      # "test_pathobject"
    # ];
  # });

  plaidml = python-self.callPackage ./plaidml { };

  # pypubsub = python-super.callPackage ./pubsub {
  # buildPythonPackage = python-super.buildPythonPackage;
  # };

  # gdcm = python-super.toPythonModule ((
  # python-super.callPackage ./gdcm {
  # enablePython = true;
  # }).override {}) ;

  # wxPython_4_1 = python-super.callPackage ./wxPython/4.1.nix { };

  # vtk_9 = python-super.toPythonModule (
    # pkgs.vtk_9.override {
      # inherit (python-self) python;
      # inherit (python-super.darwin) libobjc;
      # inherit (python-super.darwin.apple_sdk.libs) xpc;
      # inherit (python-super.darwin.apple_sdk.frameworks) Cocoa CoreServices DiskArbitration
        # IOKit CFNetwork Security ApplicationServices
        # CoreText IOSurface ImageIO OpenGL GLUT;
      # enablePython = true;
    # }
  # );
}
