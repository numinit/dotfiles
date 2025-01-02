{ config, pkgs, lib, username, homeDirectory, ... }:

{
  home.username = username;
  home.homeDirectory = if homeDirectory == null || homeDirectory == "" then
    "/home/${username}"
  else
    homeDirectory;
  home.stateVersion = "24.11";

  programs = {
    home-manager.enable = true;
    command-not-found.enable = true;
  };

  imports = [ ./bash ./tmux ./nvim ./z ];
}
