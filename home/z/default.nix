{ config, pkgs, ... }:

{
  programs.z-lua = {
    enable = true;
    enableAliases = true;
    options = [
      "enhanced" "once" "fzf"
    ];
  };
}
