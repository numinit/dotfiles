{ config, pkgs, lib, ... }:

{
  programs.git = {
    enable = true;
    userName = "Morgan Jones";
    userEmail = "me" + "@" + "numin.it";
    signing = {
      key = "F819F1AF2FC1C1FF";
      signByDefault = true;
    };
    extraConfig.core.editor = "vim";
  };
}
