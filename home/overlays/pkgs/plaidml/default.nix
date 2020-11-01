{ lib, pkgs, buildPythonPackage, fetchPypi, unzip, python }:

buildPythonPackage rec {
  pname = "plaidml";
  version = "0.7.0";
  format = "other";

  srcs = [
    (fetchPypi {
      inherit pname version;
      format = "wheel";
      platform = "manylinux1_x86_64";
      sha256 = "1y21sq95c7p1g5n731qc5xsdhxibcs5nzsb33d673g326wysyixq";
    })
    (fetchPypi {
      inherit version;
      pname = "plaidml_keras";
      format = "wheel";
      python = "py2.py3";
      sha256 = "e49cc34d47a6eec6acca8a6bf5ac7af6a8172e333d422ffac8c85846d8521bbc";
    })
  ];

  doCheck = false;
  propagatedBuildInputs = [
    python.pkgs.cffi
    python.pkgs.numpy
    python.pkgs.six
    python.pkgs.pip
    python.pkgs.Keras
  ];

  nativeBuildInputs = [
    unzip
  ];

  unpackPhase = ''
    mkdir ${pname}-${version}
    cd ${pname}-${version}
    unzip -qq ${builtins.elemAt srcs 0}

    cp ${builtins.elemAt srcs 1} ${(builtins.elemAt srcs 1).name}
  '';

  installPhase = ''
    # Installing plaidml
    mkdir -p $out/lib/${python.libPrefix}/site-packages/plaidml
    install -m 644 plaidml/* $out/lib/${python.libPrefix}/site-packages/plaidml/
    cp -r plaidml-${version}.data/data/include -t $out/
    cp -r plaidml-${version}.data/data/lib -t $out/
    cp -r plaidml-${version}.data/data/share -t $out/

    # Installing plaidml-keras and keras
    ${python.pythonForBuild.interpreter} -m pip install --no-build-isolation --no-index --prefix=$out  --ignore-installed --no-dependencies --no-cache --build tmpbuild *.whl
  '';

  profile = ''
    export PLAIDML_NATIVE_PATH="$out/lib/libplaidml.so"
    export RUNFILES_DIR="$out/share/plaidml"
  '';


  meta = with lib; {
    homepage = https://github.com/plaidml/plaidml;
    description = "plaidml keras backend";
    license = licenses.apsl20;
  };
}
