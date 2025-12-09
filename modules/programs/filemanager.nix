{ inputs, config, pkgs, ... }:

{
  home.packages = with pkgs; [
    superfile
    
    nemo-with-extensions
    
    unzip
    p7zip
    unrar
    
    file-roller 
  ];

  xdg.mimeApps.defaultApplications = {
    "inode/directory" = [ "nemo.desktop" ];
  };
  
  dconf.settings = {
    "org/nemo/preferences" = {
      show-hidden-files = true;
      show-advanced-permissions = true;
    };
  };
}
