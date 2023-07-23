{ config, pkgs, lib, ... }: {
  programs.tmux = {
    enable = true;
    aggressiveResize = true;
    disableConfirmationPrompt = true;
    escapeTime = 300;
    newSession = true;
    keyMode = "vi";
    plugins = with pkgs.tmuxPlugins; [
      onedark-theme
      cpu
      net-speed
      sidebar
      better-mouse-mode
    ];
    extraConfig = ''
      # split windows like vim
      # vim's definition of a horizontal/vertical split is reversed from tmux's
      bind s split-window -v
      bind v split-window -h

      # move around panes with hjkl, as one would in vim after pressing ctrl-w
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

      # resize panes like vim
      # feel free to change the "1" to however many lines you want to resize by, only
      # one at a time can be slow
      bind < resize-pane -L 1
      bind > resize-pane -R 1
      bind - resize-pane -D 1
      bind + resize-pane -U 1

      # bind : to command-prompt like vim
      # this is the default in tmux already
      bind : command-prompt

      # vi-style controls for copy mode
      setw -g mode-keys vi

      # Default terminal
      set -g default-terminal "screen-256color"

      set -g @tmux_power_date_icon ' ' # set it to a blank will disable the icon
      set -g @tmux_power_time_icon '🕘' # emoji can be used if your terminal supports
      set -g @tmux_power_user_icon ' '
      set -g @tmux_power_session_icon ' '
      set -g @tmux_power_upload_speed_icon '↑'
      set -g @tmux_power_download_speed_icon '↓'
      #set -g @tmux_power_left_arrow_icon '<'
      #set -g @tmux_power_right_arrow_icon '>'
    '';
  };
}
