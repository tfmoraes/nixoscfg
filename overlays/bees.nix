final: prev: rec {
  my_bees = prev.bees.bees.overrideAttrs (old: rec {
    version = "0.8";
    src = prev.fetchFromGitHub {
      owner = "Zygo";
      repo = "bees";
      rev = "v${version}";
      sha256 = "sha256-xBejyi/W8DLQmcicTqEQb5c4uZKu7jsLGjmWmW74t88=";
    };
  });
  bees = prev.bees.overrideAttrs (old: {
    bees = my_bees;
  });
}
