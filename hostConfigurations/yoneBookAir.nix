{ pkgs, ... }:
{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = [
    pkgs.hello
  ];


  # Always enable the shell system-wide, *even if it's already enabled in your home.nix*
  # https://nixos.wiki/wiki/Command_Shell
  programs.zsh.enable = true;
  # users.defaultUserShell = pkgs.zsh;

  # NOTE: Many programs look at /etc/shells to determine
  # if a user is a "normal" user and not a "system" user.
  # Therefore it is recommended to add the user shells to this list.
  environment.shells = with pkgs; [ bash zsh ];

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;
}
