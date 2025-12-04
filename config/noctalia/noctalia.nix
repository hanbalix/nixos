# noctalia.nix (separate module)
{ config, pkgs, self, ... }:
let
  inputs = self.inputs;
in {
  programs.noctalia-shell = {
    enable = true;
    settings = {
      bar = {
        density = "compact";
        position = "right";
        showCapsule = false;
        widgets = {
          left = [
            { id = "ControlCenter"; useDistroLogo = true; }
            { id = "WiFi"; }
            { id = "Bluetooth"; }
          ];
          center = [
            { hideUnoccupied = false; id = "Workspace"; labelMode = "none"; }
          ];
          right = [
            { alwaysShowPercentage = false; id = "Battery"; warningThreshold = 30; }
            { formatHorizontal = "HH:mm"; id = "Clock"; useMonospacedFont = true; usePrimaryColor = true; }
          ];
        };
      };
      colorSchemes.predefinedScheme = "Monochrome";
      general = {
        avatarImage = "/home/x/.face";
        radiusRatio = 0.2;
      };
      location = {
        monthBeforeDay = true;
        name = "Your City";
      };
    };
  };

  home.packages = with pkgs; [
    quickshell
    roboto
    noto-fonts
    gpu-screen-recorder
    brightnessctl
    cliphist
    cava
    wlsunset
  ];
}

