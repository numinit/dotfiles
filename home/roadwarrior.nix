{ config, pkgs, lib, ... }:

{
  programs.git = {
    enable = true;
    settings.core.editor = "vim";
  };
}
