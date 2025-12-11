{ config, ... }:

   services.pipewire = {
     enable = true;
     pulse.enable = true;      
     alsa.enable = true;      
     alsa.support32Bit = true; # 32-bit ALSA support (for older apps)
   }

