{ config, pkgs, settings, ... }: {


  services.swayidle =
let
  lock = "${pkgs.swaylock}/bin/swaylock --daemonize";
  display = status: "${pkgs.niri}/bin/niri msg action power-${status}-monitors";
in
{
  enable = true;
  timeouts = [
    {
      timeout = 295; # 4min 55s in seconds
      command = "${pkgs.libnotify}/bin/notify-send 'Locking in 5 seconds' -t 5000";
    }
    {
      timeout = 300; #5min
      command = lock;
    }
    {
      timeout = 310; 
      command = display "off";
      resumeCommand = display "on";
    }
    {
      timeout = 320;
      command = "${pkgs.systemd}/bin/systemctl suspend";
    }
  ];
  events = {
    {
      event = "before-sleep";
      # adding duplicated entries for the same event may not work
      command = (display "off") + "; " + lock;
    }
    {
      event = "after-resume";
      command = display "on";
    }
    {
      event = "lock";
      command = (display "off") + "; " + lock;
    }
    {
      event = "unlock";
      command = display "on";
    }
        };
};

}
