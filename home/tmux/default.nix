{ config, pkgs, lib, ... }: {
  programs.tmux = {
    enable = true;
    aggressiveResize = true;
    disableConfirmationPrompt = true;
    escapeTime = 300;
    newSession = true;
    keyMode = "vi";
    plugins = with pkgs.tmuxPlugins; [
      cpu
      net-speed
      sidebar
      better-mouse-mode
      {
        plugin = catppuccin;
        extraConfig = ''
          set -g @catppuccin_flavor 'mocha'
          set -g @catppuccin_window_status_style 'rounded'
          set -g @catppuccin_status_background 'default'
        '';
      }
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
      bind < resize-pane -L 1
      bind > resize-pane -R 1
      bind - resize-pane -D 1
      bind + resize-pane -U 1

      bind : command-prompt

      setw -g mode-keys vi

      set -g default-terminal "screen-256color"

      # Status line — assembled after catppuccin has loaded.
      set -g status-left-length 100
      set -g status-right-length 200
      set -g status-left  "#{E:@catppuccin_status_session}"
      set -g status-right "#{E:@catppuccin_status_user}"
      set -agF status-right "#{E:@catppuccin_status_directory}"
      set -agF status-right "#{E:@catppuccin_status_cpu}"
      set -ag  status-right "#[fg=#{@thm_crust},bg=#{@thm_sapphire}] ↑#{upload_speed} ↓#{download_speed} "
      set -agF status-right "#{E:@catppuccin_status_date_time}"
    '';
  };
}
