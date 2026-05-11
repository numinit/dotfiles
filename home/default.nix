{
  config,
  pkgs,
  lib,
  username,
  homeDirectory,
  ...
}:

{
  home.username = username;
  home.homeDirectory =
    if homeDirectory == null || homeDirectory == "" then "/home/${username}" else homeDirectory;
  home.stateVersion = "24.11";

  programs = {
    home-manager.enable = true;
    command-not-found.enable = true;

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    delta = {
      enable = true;
      enableGitIntegration = true;
      options = {
        navigate = true;
        line-numbers = true;
        side-by-side = true;
      };
    };
  };

  home.packages = with pkgs; [
    claude-code
  ];

  imports = [
    ./bash
    ./tmux
    ./nvim
    ./z
  ];
}
