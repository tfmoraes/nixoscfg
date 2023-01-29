python-self: python-super: {
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

  # fastparquet = python-super.fastparquet.overrideAttrs (oldAttrs: rec {
  #   version = "2022.12.0";
  #   src = python-super.pkgs.fetchFromGitHub {
  #     owner = "dask";
  #     repo = oldAttrs.pname;
  #     rev = version;
  #     hash = "sha256-/DSe2vZwrHHTuAXWJh9M1wCes5c4/QAVUnJVEI4Evyw=";
  #   };

  #   SETUPTOOLS_SCM_PRETEND_VERSION="${version}";

  #   nativeBuildInputs = with python-super.pkgs; [
  #     git
  #     python-super.cython
  #     python-super.setuptools-scm
  #   ] ++ oldAttrs.nativeBuildInputs;
  # });

  # pycurl = python-super.pycurl.overrideAttrs (oldAttrs: rec{
  #   doCheck = false;
  #   doInstallCheck = false;
  # });

  # remarshal = python-super.remarshal.overrideAttrs (oldAttrs: rec{
  #   postPatch = ''
  #     substituteInPlace pyproject.toml \
  #       --replace "poetry.masonry.api" "poetry.core.masonry.api" \
  #       --replace 'PyYAML = "^5.3"' 'PyYAML = "*"' \
  #       --replace 'tomlkit = "^0.7"' 'tomlkit = "*"'
  #   '';
  # });

  # dask = python-super.dask.overrideAttrs (oldAttrs: rec {
  #   version = "2023.1.0";
  #   src = python-super.pkgs.fetchFromGitHub {
  #     owner = "dask";
  #     repo = oldAttrs.pname;
  #     rev = version;
  #     hash = "sha256-avyrKBAPyYZBNgItnkNCferqb6+4yeGpBAZhSkL/fFA=";
  #   };

  #   patches = [];

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

  plaidml = python-self.callPackage ./plaidml {};

  djhtml = python-self.callPackage ./djhtml {};

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
