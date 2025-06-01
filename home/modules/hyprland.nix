{ lib, config, pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    xorg.xhost
    nh
    htop
    calcurse
    tldr
  ];

  programs.helix.enable = true;
  programs.neovim.enable = true;
  programs.btop.enable = true;

  programs.aerc = {
    enable = true;
  };

  services.hyprpolkitagent.enable = true;

  programs.hyprpanel = {
    enable = true;
    overwrite.enable = true;
    systemd.enable = true;
    hyprland.enable = true;
    settings = {
      theme.name = "catppuccin_mocha";
      theme.font.name = "JetBrainsMono Nerd Font";
      scalingPriority = "both";
      bar.launcher.autoDetectIcon = true;
      theme.bar.scaling = 65;
      theme.osd.scaling = 65;
      theme.notification.scaling = 70;
      theme.bar.menus.menu = {
        dashboard.scaling = 65;
        dashboard.confirmation_scaling = 65;
        media.scaling = 65;
        volume.scaling = 65;
        network.scaling = 70;
        bluetooth.scaling = 70;
        battery.scaling = 65;
        clock.scaling = 65;
      };
      menus.dashboard.shortcuts.left = {
        shortcut1 = {
          tooltip = "QuteBrowser";
          command = "qutebrowser";
          icon = "󰖟";
        };
        shortcut2 = {
          command = "foot -a lf lf";
          tooltip = "Files";
          icon = "";
        };
        shortcut3 = {
          command = "foot";
          tooltip = "Foot";
          icon = "";
        };
        shortcut4.command = "fuzzel";
      };
      wallpaper = {
        enable = true;
        image = builtins.toString ./config/wallpaper/Clearnight.jpg;
      };
      terminal = "foot";
    };
  };

  programs.lf.enable = true;
  programs.qutebrowser.enable = true;
  programs.mpv.enable = true;
  programs.imv.enable = true;
  programs.zathura.enable = true;

  programs.hyprlock = {
    enable = true;
  };

  services.hypridle = {
    enable = true;

    settings = {
      general = {
        lock_cmd = "hyprlock";
        before_sleep_cmd = "hyprlock";
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };

      listener = [
        {
          timeout = 600;
          on-timeout = "hyprlock";
        }
        {
          timeout = 900;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
        {
          timeout = 1800;
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };

  programs.foot = {
    enable = true;
    settings = {
      main = {
        term = "xterm-256color";
        font = "JetBrainsMono Nerd Font:size=11";
        dpi-aware = "yes";
      };

      mouse = {
        hide-when-typing = "yes";
      };
    };
  };

  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        font = "JetBrainsMono Nerd Font:size=11";
        terminal = "foot";
      };
    };
  };

  catppuccin.enable = true;
  catppuccin.qutebrowser.enable = true;
  catppuccin.flavor = "mocha";

  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;
    xwayland.enable = true;
    systemd.enable = true;

    plugins = with pkgs.hyprlandPlugins; [
      hyprgrass
      hypr-dynamic-cursors
      hyprspace
    ];
    
    settings = {
      "$mod" = "SUPER";
      exec_once = [
        "${lib.getExe pkgs.xorg.xhost} +local"
        "hyprpanel"
      ];
      bind = [
        "$mod, t, exec, foot"
        "$mod, e, exec, qutebrowser"
        "$mod, Space, exec, fuzzel"
        "$mod, w, killactive, "
        "$mod + ALT, q, exit, "
        "$mod + SHIFT, q, exec, loginctl terminate-user"
        "$mod, f, togglefloating, "
        ", F11, fullscreen, "
        "$mod, Left, movefocus, l"
        "$mod, Right, movefocus, r"
        "$mod, Up, movefocus, u"
        "$mod, Down, movefocus, d"
        "$mod + SHIFT, Left, movewindow, l"
        "$mod + SHIFT, Right, movewindow, r"
        "$mod + SHIFT, Up, movewindow, u"
        "$mod + SHIFT, Down, movewindow, d"
        "$mod, Tab, cyclenext,"
      ] ++ builtins.concatLists (map (i: [
        "$mod, ${i}, workspace, ${i}"
        "$mod + SHIFT, ${i}, movetoworkspace, ${i}"
      ]) (builtins.genList (i: toString(i + 1)) 8));
      general = {
        border_size = 2;
        "col.active_border" = "rgb(cba6f7)";
        "col.inactive_border" = "rgba(cba6f7CC)";
        layout = "master";
        snap = {
          enabled = true;
        };
      };
      decoration = {
        dim_inactive = true;
        rounding = 5;
      };
      gestures = {
        workspace_swipe = true;
      };
      input = {
        natural_scroll = true;
      };
      misc = {
        disable_hyprland_logo = true;
      };
    };
  };

  catppuccin.cursors.enable = true;
  catppuccin.cursors.flavor = "mocha";
  catppuccin.cursors.accent = "mauve";
  catppuccin.gtk.enable = true;
  catppuccin.gtk.flavor = "mocha";

  home.pointerCursor = {
    size = 24;
  };

  gtk = {
    enable = true;
  };

  xdg.configFile."qutebrowser" = {
    source = ./config/qutebrowser;
    recursive = true;
  };
}
