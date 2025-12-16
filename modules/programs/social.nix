{ inputs, config, pkgs, ... }:

{
  home.packages = with pkgs; [
    vesktop
  ];

  xdg.desktopEntries.vesktop = {
    name = "Vesktop";
    exec = "vesktop --ozone-platform=x11 %U";
    icon = "vesktop";
    categories = [ "Network" "InstantMessaging" "Chat" ];
    comment = "Vesktop with X11 shim";
  };

  xdg.mimeApps.defaultApplications = {
    "x-scheme-handler/discord" = [ "vesktop.desktop" ];
  };
}
