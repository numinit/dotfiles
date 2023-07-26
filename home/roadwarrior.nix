{ config, pkgs, lib, ... }:

{
  programs.git = {
    enable = true;
    extraConfig.core.editor = "vim";
  };
}
