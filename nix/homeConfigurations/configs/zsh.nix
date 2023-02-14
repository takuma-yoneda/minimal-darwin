{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;
    historySubstringSearch = {
      enable = true;
      # Emacs-like keybinds
      searchUpKey = "^P";
      searchDownKey = "^N";
      # historySubstringSearchModule = {
      #   enable = true;
      #   # Emacs-like keybinds
      #   searchUpKey = "^P";
      #   searchDownKey = "^N";
      # };
    };

    shellAliases = {
      ls = "exa";
      ll = "exa -l";
      p = "python3";
      grep = "rg";
    };

    # NOTE: I guess all I need is a reasonable theme?
    # All the plugins look less attractive now.
    # oh-my-zsh = {
    #   enable = true;
    #   plugins = [];
    #   theme = "robbyrussell";
    # };
    initExtra = ''
    # fzf to search thru dot files while avoiding .git and node_modules
    # https://github.com/junegunn/fzf/issues/634#issuecomment-1008200731
    export FZF_DEFAULT_COMMAND="rg --files --follow --no-ignore-vcs --hidden -g '!{**/node_modules/*,**/.git/*}'"

    # NOTE: In nixpkgs, programs.zsh.autosuggestions option allows us to configure this,
    # But I have no idea how to use that from home-manager config file...
    # Thus manually writing this here
    # zsh-autosuggestions: Change suggest color
    (( ''${+ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE} )) &&
        typeset -g ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=6'

    # HACK: temporarily add to PATH!
    export PATH=$PATH:$HOME/.local/bin
    '';

    # NOTE: Look at
    # https://github.com/NixOS/nixpkgs/blob/nixpkgs-22.11-darwin/nixos/modules/programs/zsh/zsh-autosuggestions.nix
    # autosuggestions = {
    #   enable = true;
    #   # List of colors: https://coderwall.com/p/pb1uzq/z-shell-colors
    #   highlightStyle = "fg=4";
    # };

  };

  programs.starship = {
    enable = true;
    # Configuration written to ~/.config/starship.toml
    settings = {
    };
  };

}
