{ inputs, lib, config, pkgs, ... }: {
  services.polybar = {
    enable = true;
    package = pkgs.polybar.override {
      i3Support = true;
      alsaSupport = true;
      iwSupport = true;
      githubSupport = true;
    };
    config = {
    };
    script = ''
    polybar top &
    '';
  };
}
