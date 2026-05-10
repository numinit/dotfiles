{ ... }:

{
  programs.git = {
    enable = true;
    signing = {
      key = "5c3eb94d198f1491";
      signByDefault = true;
    };
    settings = {
      user = {
        name = "Morgan Jones";
        email = "me" + "@" + "numin.it";
      };
      core.editor = "vim";
    };
  };
}
