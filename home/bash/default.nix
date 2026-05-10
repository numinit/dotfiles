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
    initExtra = ''
      if [ "$IN_NIX_SHELL" == "pure" ]; then
          if [ -x "$HOME/.nix-profile/bin/powerline-go" ]; then
              alias powerline-go="$HOME/.nix-profile/bin/powerline-go"
          elif [ -x "/run/current-system/sw/bin/powerline-go" ]; then
              alias powerline-go="/run/current-system/sw/bin/powerline-go"
          fi
      fi

      function _update_ps1() {
          PS1="$(powerline-go -error $? -jobs $(jobs -p | wc -l))"

          # Uncomment the following line to automatically clear errors after showing
          # them once. This not only clears the error for powerline-go, but also for
          # everything else you run in that shell. Don't enable this if you're not
          # sure this is what you want.

          #set "?"
      }

      # Flush this session's history to disk on every prompt, so concurrent
      # shells (tmux panes, etc.) can see each other's commands live and a
      # crashed shell doesn't lose its session history.
      PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

      if [ "$TERM" != "linux" ]; then
          PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
      fi

      alias ls='ls --color=auto'
      alias l='ls -CF'
      alias la='ls -A'
      alias ll='ls -alhF'
      alias d='cd'
      alias puts='echo'
      alias p='ipython'
      alias py='python'
      alias r='pry'
      alias rb='ruby'
      alias c='clear'

      alias pubkey='cat ~/.ssh/id_rsa.pub'

      # Go to the higher directory
      alias up='cd ..'
      alias u='up'

      # Go to the previous directory
      alias back='cd $OLDPWD'
      alias b='back'

      # Open the current directory
      alias o='open .'

      # Always make intermediate directories
      alias mkdir='mkdir -p'
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
