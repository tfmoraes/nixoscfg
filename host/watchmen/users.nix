{ config, pkgs, ... }:

with pkgs; {
  users = {
    groups = {
      thiago = {
        name = "thiago";
        gid = 1000;
      };
    };

    users = {
      thiago = {
        isNormalUser = true;
        description = "Thiago Franco de Moraes";
        group = "thiago";
        extraGroups = [ "wheel" "docker" "libvirtd" "lxd" ];
        shell = pkgs.fish;
        # subUidRanges = [{ startUid = 100000; count = 65536; }];
        # subGidRanges = [{ startGid = 100000; count = 65536; }];
      };
    };
  };
}
