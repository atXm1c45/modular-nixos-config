{
  inputs,
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    wf-recorder
    pavucontrol
  ];
}
