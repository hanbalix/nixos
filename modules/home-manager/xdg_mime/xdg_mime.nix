{
  config,
  lib,
  pkgs,
  ...
}: {
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "image/jpeg" = ["qview.desktop"];
      "image/png" = ["qview.desktop"];
      "image/gif" = ["qview.desktop"];
      "image/webp" = ["qview.desktop"];
      "application/pdf" = ["org.kde.okular.desktop"];
      "application/epub+zip" = ["org.kde.okular.desktop"];
      "text/plain" = ["nvim.desktop"];
      "text/x-nix" = ["nvim.desktop"];
      "text/x-go" = ["nvim.desktop"];
      "text/x-c" = ["nvim.desktop"];
      "text/x-c++src" = ["nvim.desktop"];
      "application/json" = ["nvim.desktop"];
      "text/json" = ["nvim.desktop"];
      "text/x-lua" = ["nvim.desktop"];
      "text/x-python" = ["nvim.desktop"];
      "text/rust" = ["nvim.desktop"];
      "text/x-rust" = ["nvim.desktop"];
      "application/javascript" = ["nvim.desktop"];
      "text/javascript" = ["nvim.desktop"];
      "text/x-shellscript" = ["nvim.desktop"];
      "application/x-shellscript" = ["nvim.desktop"];
      "application/toml" = ["nvim.desktop"];
      "application/x-yaml" = ["nvim.desktop"];
      "text/markdown" = ["nvim.desktop"];
      "video/mp4" = ["org.videolan.VLC.desktop"];
      "video/mpeg" = ["org.videolan.VLC.desktop"];
      "audio/mpeg" = ["org.videolan.VLC.desktop"]; # .mp3
      "audio/flac" = ["org.videolan.VLC.desktop"];
      "audio/x-wav" = ["org.videolan.VLC.desktop"];
      "audio/mp4" = ["org.videolan.VLC.desktop"];
      # "inode/directory" = [ "org.kde.dolphin.desktop" ];
      "inode/directory" = ["dolphin.desktop"];
    };
  };
}
