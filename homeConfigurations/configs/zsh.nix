{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;
    shellAliases = {
      hoge = "ls -l";
    };

    # NOTE: I guess all I need is a reasonable theme?
    # All the plugins look less attractive now.
    # oh-my-zsh = {
    #   enable = true;
    #   plugins = [];
    #   theme = "robbyrussell";
    # };
    initExtra = ''
    echo Hello World!
    '';
  };

  programs.starship = {
    enable = true;
    # Configuration written to ~/.config/starship.toml
    settings = {
    };
  };
}
