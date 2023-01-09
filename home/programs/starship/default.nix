{ inputs, lib, config, pkgs, ... }: {
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
    # Configuration written to ~/.config/starship.toml
    settings = {
      add_newline = false;
      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[➜](bold red)";
      };
      time.disabled = false;
      conda.ignore_base = true;
      battery.display = [
        {
          threshold = 20;
          style = "bold red";
        }
        {
          threshold = 50;
          style = "bold yellow";
        }
        {
          threshold = 80;
          style = "bold green";
        }
      ];
    };
  };
}
