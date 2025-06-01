{ config, pkgs, ... }:

let
  tmuxPlugins = with pkgs.tmuxPlugins; [
    sensible
    yank
    resurrect
    continuum
    tmux-powerline
    catppuccin
  ];
in {
  programs.tmux = {
    enable = true;
    terminal = "screen-256color";
    prefix = "C-a";  # More ergonomic than default C-b
    mouse = true;
    keyMode = "vi";

    extraConfig = ''
      set -g default-terminal "screen-256color"
      set -as terminal-overrides ",foot*:Tc"
      set -g history-limit 10000

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

      set -g @catpuccin_flavour 'mocha'
      set -g @atpuccin_window_tabs_enabled on
      set -g @catpuccin_date_time "%H:%M"
    '';

    plugins = tmuxPlugins;
  };
}

