{
  config,
  pkgs,
  lib,
  ...
}:
{
  programs.bash = {
    enable = true;
    enableCompletion = true;
    historyControl = [
      "ignoredups"
      "ignorespace"
      "erasedups"
    ];
    historyIgnore = [
      "ls"
      "ll"
      "la"
      "l"
      "cd"
      "pwd"
      "clear"
      "c"
      "history"
      "exit"
      "bg"
      "fg"
      "jobs"
    ];
    historySize = 1000000;
    historyFileSize = 10000000;
    sessionVariables.HISTTIMEFORMAT = "%F %T  ";
    shellAliases = {
      ls = "ls --color=auto";
      l = "ls -CF";
      la = "ls -A";
      ll = "ls -alhF";
      d = "cd";
      puts = "echo";
      p = "ipython";
      py = "python";
      r = "pry";
      rb = "ruby";
      c = "clear";

      pubkey = "cat ~/.ssh/id_rsa.pub";

      up = "cd ..";
      u = "up";
      back = "cd $OLDPWD";
      b = "back";
      o = "open .";

      mkdir = "mkdir -p";
    };
    initExtra = ''
      # powerline-go is only on PATH inside pure nix-shells; alias it so manual
      # invocations still work. The prompt function is installed by the
      # programs.powerline-go module below (with absolute path), so it doesn't
      # need this alias.
      if [ "$IN_NIX_SHELL" == "pure" ]; then
          if [ -x "$HOME/.nix-profile/bin/powerline-go" ]; then
              alias powerline-go="$HOME/.nix-profile/bin/powerline-go"
          elif [ -x "/run/current-system/sw/bin/powerline-go" ]; then
              alias powerline-go="/run/current-system/sw/bin/powerline-go"
          fi
      fi

      # Flush this session's history to disk on every prompt, so concurrent
      # shells (tmux panes, etc.) can see each other's commands live and a
      # crashed shell doesn't lose its session history.
      # Idempotent join with `''${...:+;$...}` avoids trailing semicolons that
      # would later collide with zoxide/direnv hooks (bash sees `;;` as a
      # case-statement terminator).
      PROMPT_COMMAND="history -a''${PROMPT_COMMAND:+;$PROMPT_COMMAND}"
    '';
  };
  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
    defaultOptions = [
      "--height 40%"
      "--layout=reverse"
      "--border"
    ];
  };

  programs.carapace = {
    enable = true;
    enableBashIntegration = true;
  };

  programs.powerline-go = {
    enable = true;
    modules = [
      "venv"
      "nix-shell"
      "direnv"
      "dotenv"
      "user"
      "host"
      "ssh"
      "cwd"
      "perms"
      "gitlite"
      "jobs"
      "exit"
      "root"
    ];
  };
}
