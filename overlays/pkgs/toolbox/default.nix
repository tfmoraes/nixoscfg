{
  lib,
  fetchFromGitHub,
  buildGoModule,
  go-md2man,
  installShellFiles,
  fetchpatch,
  glibc,
}:
buildGoModule rec {
  pname = "toolbox";
  version = "0.0.99.2";

  src = fetchFromGitHub {
    owner = "containers";
    repo = "toolbox";
    rev = version;
    sha256 = "sha256-W8SDmF4ht8AwhMwcbvys+eZCtvq2KPK9U0awv4QkGSM=";
  };

  modRoot = "src";

  patches = [
    ./toolbox_glibc.patch
    # (fetchpatch {
    #   url = "https://github.com/containers/toolbox/commit/14cacc4ea6dc8fc51cb1e6bffa221e2dbcb61a0b.patch";
    #   sha256 = "DFakCVBj/RgKU5pem3KxKgjorl8FNlHApR56wxWpkpA=";
    # })
    # (fetchpatch {
    #   url = "https://github.com/containers/toolbox/commit/a0f34e65c0c6b25b9300ed5f511403a29943a06a.patch";
    #   sha256 = "9PZ7pDKlvkpEBQMyfR089nkDvRNRQ4Xzcij3ku1cdqE=";
    # })

    # (fetchpatch {
    #   url = "https://gist.githubusercontent.com/tfmoraes/583bb66269216768fbe72b4e57cdd221/raw/149b5e7703dd6eb25590dd0705cac9c1a9cb65ae/etc_static.patch";
    #   sha256 = "B6J5cLVKmtWX6TL/REJBb5oi120YFmRlQhPp2aKACrs=";
    # })
  ];

  postPatch = ''
    substituteInPlace src/cmd/create.go --subst-var-by glibc ${glibc}
  '';

  vendorSha256 = "sha256-wBYpOk+q9hIDfSrACjvv77CRUsXYSMl0eiUrJatnN30=";

  buildFlagsArray = [
    "-ldflags=-X github.com/containers/toolbox/pkg/version.currentVersion=${version}"
  ];

  nativeBuildInputs = [
    go-md2man
    installShellFiles
  ];

  preConfigure = ''
    substituteInPlace src/cmd/create.go \
      --replace '"/etc/profile.d/toolbox.sh"}' '"${placeholder "out"}/share/profile.d/toolbox.sh"}'
  '';

  postInstall = ''
    cd ..
    for d in doc/*.md; do
      go-md2man -in $d -out ''${d%.md}
    done
    installManPage doc/*.[1-9]
    installShellCompletion --bash completion/bash/toolbox
    install profile.d/toolbox.sh -Dt $out/share/profile.d
  '';

  meta = with lib; {
    description = "Unprivileged development environment";
    homepage = "https://github.com/containers/toolbox";
    license = licenses.asl20;
    maintainers = with maintainers; [mjlbach];
    platforms = platforms.linux;
  };
}
