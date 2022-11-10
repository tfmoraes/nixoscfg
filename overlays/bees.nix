final: prev: rec {
  my_bees = prev.bees.bees.overrideAttrs (old: rec {
    version = "0.7.3";
    src = prev.fetchFromGitHub {
      owner = "Zygo";
      repo = "bees";
      rev = "5040303f5067ac266b274a44888e0b49c06da816";
      sha256 = "sha256-MREn0yigG2QDCYbTZYggGUX4uJKte8diRJNVR6nMEQM=";
    };
  });
  bees = prev.bees.overrideAttrs (old: {
    bees = my_bees;
  });
}
