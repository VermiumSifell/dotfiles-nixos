{ pkgs, ... }:

{
  programs.firefox = {
    enable = true;
    extensions = with pkgs.nur.repos.rycee.firefox-addons; [
      bitwarden
      ublock-origin
      darkreader
      kristofferhagen-nord-theme
    ];
    profiles = {
      default = {
        isDefault = true;
        settings = {
          # Remove warnings
          "browser.aboutConfig.showWarning" = false;

          # Do not save passwords to Firefox...
          "security.ask_for_password" = false;
          "signon.management.page.breach-alerts.enabled" = false;
          "signon.rememberSignons" = false;

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

          # Privacy
          "app.shield.optoutstudies.enabled" = false;
          "services.sync.prefs.sync-seen.app.shield.optoutstudies.enabled" =
            false;
          "services.sync.prefs.sync.app.shield.optoutstudies.enabled" = false;
          "toolkit.telemetry.pioneer-new-studies-available" = false;
          "datareporting.healthreport.uploadEnabled" = false;

          # Show punycode. Help protect from character 'spoofing'.
          "network.IDN_show_punycode" = true;

          # Disable site reading installed plugins.
          "plugins.enumerable_names" = "";

          # Enable auto scrolling.
          "general.autoScroll" = true;

          # Remove those extra empty spaces in both sides
          "browser.uiCustomization.state" = ''
            {"placements":{"widget-overflow-fixed-list":[],"unified-extensions-area":[],"nav-bar":["back-button","forward-button","stop-reload-button","urlbar-container","downloads-button","fxa-toolbar-menu-button","addon_darkreader_org-browser-action","_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action","ublock0_raymondhill_net-browser-action"],"toolbar-menubar":["menubar-items"],"TabsToolbar":["firefox-view-button","tabbrowser-tabs","new-tab-button","alltabs-button"],"PersonalToolbar":["personal-bookmarks"]},"seen":["save-to-pocket-button","addon_darkreader_org-browser-action","ublock0_raymondhill_net-browser-action","_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action","developer-button"],"dirtyAreaCache":["unified-extensions-area","nav-bar","toolbar-menubar","TabsToolbar","PersonalToolbar"],"currentVersion":18,"newElementCount":3}          '';
        };
      };
    };
  };
}
