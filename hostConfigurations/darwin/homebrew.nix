{ config, lib, pkgs, ... }:

{
  homebrew = {
    enable = true;

    # NOTE: With these
    # 1. Running a brew command does not update packages automatically (even after 5 min)
    # 2. Running darwin-rebuild switch does not update packages
    # 3. Update happens only when you
    #   a. run `brew update` and
    #   b. run `darwin-rebuild switch`
    global.autoUpdate = false;
    onActivation.autoUpdate = false;
    onActivation.upgrade = true;

    onActivation = {
      # "zap" removes manually installed brews and casks
      cleanup = "none";
    };

    brews = [
      "hunspell"
      "qt"

      # Yabai family
      {
        name = "skhd";
        start_service = true;  # This will register it to launch at boot
        restart_service = "changed";
      }
      {
        name = "yabai";
        start_service = true;  # This will register it to launch at boot
        restart_service = "changed";
      }
      "yabai"
    ];
    casks = [
      "macfuse"
    ];
    taps = [
      # default
      "homebrew/bundle"
      "homebrew/cask"
      "homebrew/cask-drivers"
      "homebrew/cask-fonts"
      "homebrew/core"
      "homebrew/services"
      # custom
      "koekeishiya/formulae" # yabai
    ];
  };
}
