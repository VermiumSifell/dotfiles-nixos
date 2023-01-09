{ pkgs, nur, ... }:

{
  programs.firefox = {
    enable = true;
    extensions = with nur.repos.rycee.firefox-addons; [
      bitwarden
      ublock-origin
      kristofferhagen-nord-theme
    ];
    profiles = {
      default = {
        isDefault = true;
        settings = {
          # Do not save passwords to Firefox...
          "security.ask_for_password" = false;

          # We handle this elsewhere
          "browser.shell.checkDefaultBrowser" = false;

          # Don't allow websites to prevent use of right-click, or otherwise
          # messing with the context menu.
          "dom.event.contextmenu.enabled" = true;

          # Don't allow websites to prevent copy and paste. Disable
          # notifications of copy, paste, or cut functions. Stop webpage
          # knowing which part of the page had been selected.
          "dom.event.clipboardevents.enabled" = true;

          # Do not track from battery status.
          "dom.battery.enabled" = false;

          # Show punycode. Help protect from character 'spoofing'.
          "network.IDN_show_punycode" = true;

          # Disable site reading installed plugins.
          "plugins.enumerable_names" = "";

          # Enable auto scrolling.
          "general.autoScroll" = true;

          # Remove those extra empty spaces in both sides
          "browser.uiCustomization.state" = ''
            {"placements":{"widget-overflow-fixed-list":[],"nav-bar":["back-button","forward-button","stop-reload-button","urlbar-container","downloads-button","fxa-toolbar-menu-button"],"toolbar-menubar":["menubar-items"],"TabsToolbar":["tabbrowser-tabs","new-tab-button","alltabs-button"],"PersonalToolbar":["import-button","personal-bookmarks"]},"seen":["developer-button"],"dirtyAreaCache":["nav-bar","PersonalToolbar"],"currentVersion":17,"newElementCount":4}
          '';
        };
      };
    };
  };
}
