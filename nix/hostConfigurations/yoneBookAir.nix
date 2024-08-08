# NOTE: This file is read by Nix-darwin
# Remember that this file goes into `nix-darwin.lib.darwinSystem.modules`

{ pkgs, ... }:
{
  imports = [
    ./darwin/homebrew.nix
  ];

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = [
    pkgs.hello
  ];

  # Set the YABAI environment variable system-wide
  environment.variables = {
    YABAI = "${pkgs.yabai}/bin/yabai";
    SKHD = "${pkgs.skhd}/bin/skhd";
  };


  # Always enable the shell system-wide, *even if it's already enabled in your home.nix*
  # https://nixos.wiki/wiki/Command_Shell
  programs.zsh.enable = true;
  programs.bash.enable = true;
  # users.defaultUserShell = pkgs.zsh;

  # NOTE: Many programs look at /etc/shells to determine
  # if a user is a "normal" user and not a "system" user.
  # Therefore it is recommended to add the user shells to this list.
  environment.shells = with pkgs; [ bash zsh ];

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;

  # NOTE: There is a bug in Nix Darwin, where Home Manager errors when this is not explictly set
  # Issue: https://github.com/nix-community/home-manager/issues/4026
  users.users."yoneda".home = "/Users/yoneda";

  services.yabai = {
    enable = true;
    enableScriptingAddition = true;
    package = pkgs.yabai;
    # NOTE: There's a config keyword, but better to use a sepearate file.
    extraConfig = (builtins.readFile ./darwin/yabairc);
  };

  services.skhd = {
    # NOTE: Configuration is not being reflected?
    # You can set enable = false and then darwin-rebuild switch, and then reenable it.
    # For whatever mysterious reasons, that reflects the configuration.
    enable = true;
    package = pkgs.skhd;
    skhdConfig = (builtins.readFile ./darwin/skhdrc);
  };

}
