{ config, pkgs, ... }:

{
  networking = {
    hostName = "watchmen";
    useDHCP = false;
    #interfaces.enp3s0.useDHCP = false;
    networkmanager.enable = true;
    firewall = {
      enable = true;
      trustedInterfaces = [ "virbr0" ];
      # allowedTCPPorts = [ 80 443 ];
    };
  };
}
