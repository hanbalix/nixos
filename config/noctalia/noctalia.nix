{ config, pkgs, self, ... }:  # self already passed via extraSpecialArgs
{
  home.packages = with pkgs; [
    (self.inputs.noctalia.packages.${pkgs.system}.default)  # ✅ Via self.inputs
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

