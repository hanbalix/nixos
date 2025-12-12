{ config, lib, pkgs, ... }:

{
  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  users.users.x = {
    extraGroups = [ "docker" ];
    subUidRanges = [ { count = 65536; startUid = 1000; } ];
    subGidRanges = [ { count = 65536; startGid = 1000; } ];
  };
}

