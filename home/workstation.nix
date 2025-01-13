{ ... }:

{
  programs.git = {
    enable = true;
    userName = "Morgan Jones";
    userEmail = "me" + "@" + "numin.it";
    signing = {
      key = "5c3eb94d198f1491";
      signByDefault = true;
    };
    extraConfig.core.editor = "vim";
  };
}
