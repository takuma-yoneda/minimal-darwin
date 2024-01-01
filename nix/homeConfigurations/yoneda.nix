# NOTE: This file is read by Home Manager
# Remember that this file is set to `home-manager.users.yoneda`

{ pkgs, nixpkgs, ... }:

{
  # Import modular *.nix files
  imports = [
    ./configs/zsh.nix
    ./configs/git.nix
    ./configs/tmux.nix
    # ./emacs
  ];

  # nixpkgs.config.allowUnfree = true;

  home.stateVersion = "23.11";


  home.packages = with pkgs; [
    # Nix related
    nix
    nixfmt
    alejandra
    niv

    # Other packages
    cowsay
    docker
    fd
    ffmpeg
    htop
    eza  # Modern ls
    pdftk
    rsync
    ripgrep
    gnused
    # texlive.combined.scheme-full  # LaTeX
    tree
    youtube-dl
    watch
    wget

    # It's better to have project specific directories
    # that have these inside, but it's easier to install globally honestly...
    nodePackages.pnpm

    # A set of nice utilities to do simple manipulation of images
    imagemagick

    # Fonts
    nerdfonts
  ];

  fonts.fontconfig.enable = true;

  programs.fzf = {
    enable = true;
    # tmux.enableShellIntegration = true;
  };

  programs.bottom.enable = true;
  programs.less.enable = true;
  programs.vim.enable = true;
  programs.texlive.enable = true;
}
