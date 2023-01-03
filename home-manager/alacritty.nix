{ inputs, lib, config, pkgs, ... }: {
  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        normal.family = "JetbrainsMono Nerd Font";
        size = 10.5;
      };

      colors = {
        primary = {
          background = "#2e3440";
          foreground = "#d8dee9";
        };

        cursor = {
          text = "#2e3440";
          cursor = "#d8dee9";
        };

        vi_mode_cursor = {
          text = "#2e3440";
          cursor = "#d8dee9";
        };

        selection = {
          text = "CellForeground";
          background = "#4c566a";
        };

        search = {
          matches = {
            foreground = "CellBackground";
            background = "#88c0d0";
          };
          footer_bar = {
            background = "#434c5e";
            foreground = "#d8dee9";
          };
        };

        normal = {
          black: "#3b4252";
          red: "#bf616a";
          green: "#a3be8c";
          yellow: "#ebcb8b";
          blue: "#81a1c1";
          magenta: "#b48ead";
          cyan: "#88c0d0";
          white: "#e5e9f0";
        };

        bright = {
          black: "#4c566a";
          red: "#bf616a";
          green: "#a3be8c";
          yellow: "#ebcb8b";
          blue: "#81a1c1";
          magenta: "#b48ead";
          cyan: "#8fbcbb";
          white: "#eceff4";
        };

      };

      window = {
        opacity = 0.8;
        dynamic_title = true;
      };
      draw_bold_text_with_bright_colors = true;
      bell = {
        animation = "EaseOutExpo";
        duration = 10.0;
      };
      cursor.style.blinking = "On";
      mouse.hide_when_typing = true;
    };
  };
}
