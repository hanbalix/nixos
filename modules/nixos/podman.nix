{ config, lib, pkgs, ... }:

{
  virtualisation = {
    podman = {
      enable = true;
      # dockerCompat = true; aliases using docker commands
      defaultNetwork.settings.dns_enabled = true;
    };
    containers.enable = true;
  };

  users.users.x = {
    isNormalUser = true;
    extraGroups = [ "podman" ];
    subUidRanges = [ { count = 65536; startUid = 1000; } ];
    subGidRanges = [ { count = 65536; startGid = 1000; } ];
  };
}

