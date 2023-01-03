{ inputs, lib, config, pkgs, ... }: {
  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        normal.family = "Fira Code";
        size = 10.5;
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
