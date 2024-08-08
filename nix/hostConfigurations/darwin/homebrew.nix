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
      # if set to "zap", nix-darwin removes manually installed brews and casks
      cleanup = "none";
    };

    brews = [
      "hunspell"
      "qt"
      "portaudio"
      # {
      #   name = "borders";
      #   # start_service = true;
      #   restart_service = true;
      # }
    ];
    casks = [
      "macfuse"
      "whatsapp"
      "latexit"
      # "arc"
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
      # "koekeishiya/formulae" # yabai
      "FelixKratz/formulae"  # JankyBorders
    ];
  };
}
