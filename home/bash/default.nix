{ config, pkgs, lib, ... }: {
  programs.bash = {
    enable = true;
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
