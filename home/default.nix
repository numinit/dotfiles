{ config, pkgs, lib, username, ... }:

{
  home.username = username;
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "23.05";

  programs = {
    home-manager.enable = true;
    command-not-found.enable = true;
  };

  xsession.enable = true;

  imports = [ ./bash ./tmux ./nvim ];
}
