{ config, pkgs, ... }:

let
  tmuxPlugins = with pkgs.tmuxPlugins; [
    sensible
    yank
    resurrect
    continuum
    battery
    cpu
    catppuccin
  ];
in {
  config = {
    programs.tmux = {
      enable = true;
      terminal = "tmux-256color";
      prefix = "C-a";  # More ergonomic than default C-b
      mouse = true;
      keyMode = "vi";

      extraConfig = ''
        set -g default-terminal "tmux-256color"
        set -as terminal-overrides ",xterm-256color:Tc"
        set -g history-limit 10000

        set -g default-shell "${pkgs.zsh}/bin/zsh"
        set -g default-command "${pkgs.zsh}/bin/zsh -l"

        # Improve split behavior
        bind | split-window -h
        bind - split-window -v

        # Reload config
        bind r source-file ~/.tmux.conf \; display-message "Config reloaded!"

        # Clipboard integration (via yank plugin)
        set-option -g set-clipboard on

        # Easier pane navigation with vi keys
        bind -n C-h select-pane -L
        bind -n C-l select-pane -R
        bind -n C-j select-pane -D
        bind -n C-k select-pane -U

        set -g @catppuccin_flavour 'mocha'
        set -g @catppuccin_window_tabs_enabled on
        set -g @catppuccin_date_time "%H:%M"

        set -g @catppuccin_directory_text " #{=/-32/...:#{s|$USER|~|:#{b:pane_current_path}}} "

        set -g @catppuccin_window_current_number ""
        set -g @catppuccin_window_current_number_color "#{E:@thm_mauve}"
        set -g @catppuccin_window_current_text "#[fg=#{@thm_mauve},bg=#{@thm_surface_1}]#I#[fg=#{@thm_surface_1},bg=#{@thm_mauve}] #[fg=#{@thm_mantle},bg=#{@thm_mauve}]#{?#{!=:#{window_name},}, #W,}"
        
        set -g @catppuccin_window_number ""
        set -g @catppuccin_window_number_color "#{E:@thm_surface_0}"
        set -g @catppuccin_window_text "#[fg=#{@thm_rosewater},bg=#{@thm_surface_0}] #I#{?#{!=:#{window_name},},  #W,}"
        
        set -g @catppuccin_window_number_position "right"
        set -g @catppuccin_window_status_style "rounded"
        set -g @catppuccin_window_flags "icon"
        
        set -g @catppuccin_status_background '#0C0C0C'
        set -g @catppuccin_status_connect_separator "no"
        set -g @catppuccin_status_left_separator  " "
        set -g @catppuccin_status_right_separator " "

        set -g @catppuccin_pane_status_enabled "yes"
        set -g @catppuccin_pane_border_status "yes"
        set -g @catppuccin_pane_active_border_style "##{?pane_in_mode,fg=#{@thm_mauve},##{?pane_synchronized,fg=#{@thm_rosewater},fg=#{@thm_mauve}}}"
        set -g @catppuccin_pane_color "#{@thm_rosewater}"

        run "${pkgs.tmuxPlugins.catppuccin}/share/tmux-plugins/catppuccin/catppuccin.tmux"

        set -g renumber-window on
        set -g base-index 1
        set -g pane-base-index 1

        set -g status-style bg=default

        set -g status-left-length 100
        set -g status-left '#{E:@catppuccin_status_directory}'
        
        set -g status-right-length 100
        set -g status-right "#{E:@catppuccin_status_application}"
        set -agF status-right "#{E:@catppuccin_status_cpu}"
        set -ag status-right "#{E:@catppuccin_status_session}"
        set -ag status-right "#{E:@catppuccin_status_uptime}"
        set -agF status-right "#{E:@catppuccin_status_battery}"

        run-shell ${pkgs.tmuxPlugins.cpu}/share/tmux-plugins/cpu/cpu.tmux
        run-shell ${pkgs.tmuxPlugins.battery}/share/tmux-plugins/battery/battery.tmux
      '';

      plugins = tmuxPlugins;
    };
  };
}

