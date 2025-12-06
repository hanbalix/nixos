#this goes in my config file
# add this to my configuration file
# "${self}/system/packages.nix" but fix file path

{
  pkgs,
  ...
}:

{
  xdg.portal = {
    enable = true;
    config = {
      #common.default = "*";
      common = {
        default = [
          "gtk"
        ];
        "org.freedesktop.impl.portal.ScreenCast" = "wlr";
        "org.freedesktop.impl.portal.Screenshot" = "gtk";
        "org.freedesktop.impl.portal.RemoteDesktop" = "gtk";
      };
    };
    xdgOpenUsePortal = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal
      #  xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk

      # Niri
    #  xdg-desktop-portal-gnome
    ];
  };
}
