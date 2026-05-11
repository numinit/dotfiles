{ config, pkgs, ... }:

{
  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
    options = [ "--cmd z" ];
  };
}
