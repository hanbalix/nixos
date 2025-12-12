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
    subUidRanges = [ { startUid = 100000; count = 65536; } ];
    subGidRanges = [ { startGid = 100000; count = 65536; } ];
};
}

