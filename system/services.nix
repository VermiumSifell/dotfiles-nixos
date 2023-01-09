{ inputs, lib, config, pkgs, ... }: {
  services = {
    xserver = {
      enable = true;

      videoDrivers = [ "nvidia" ];

      layout = "se";

      libinput = {
        enable = true;
        touchpad = { tapping = true; };
      };

      desktopManager = { xterm = { enable = false; }; };

      displayManager = {
        defaultSession = "none+i3";
      };

      windowManager.i3 = {
        enable = true;
        extraPackages = with pkgs; [
          dmenu
          libnotify
          slock
          playerctl
          rofi
          brightnessctl
          feh
          pulseaudio
          rofi-bluetooth
        ];
      };
    };


    openssh = {
      enable = true;
      # Forbid root login through SSH.
      permitRootLogin = "no";
      # Use keys only. Remove if you want to SSH using password (not recommended)
      passwordAuthentication = false;
    };

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # If you want to use JACK applications, uncomment this
      #jack.enable = true;
    };

    autorandr = { enable = true; };

    blueman = { enable = true; };

  };
}
