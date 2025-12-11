#this goes in my config file
# add this to my configuration file
# "${self}/system/packages.nix" but fix file path
{
config,
  pkgs,
  ...
}:

{
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal
      xdg-desktop-portal-gtk
      xdg-desktop-portal-wlr
      # xdg-desktop-portal-gnome
      # xdg-desktop-portal-kde  # <--- add this for Dolphin KDE support
    ];
    config = {
      common = {
        default = [
          "kde"
          "gtk"
          "gnome"
        ];
        "org.freedesktop.impl.portal.ScreenCast" = "gtk";  # was gnome
        "org.freedesktop.impl.portal.Screenshot" = "gtk"; # was gnome
        "org.freedesktop.impl.portal.RemoteDesktop" = "gtk";
      };
    };
  };
}

