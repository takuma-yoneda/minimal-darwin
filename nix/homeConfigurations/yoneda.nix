{ pkgs, ... }:

{
  # Import modular *.nix files
  imports = [
    ./configs/zsh.nix
    ./configs/git.nix
    ./configs/yabai.nix
    ./configs/tmux.nix
    # ./emacs
  ];

  # nixpkgs.config.allowUnfree = true;

  home.stateVersion = "22.11";
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
    exa  # Modern ls
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

    # Fonts
    nerdfonts
  ];

  fonts.fontconfig.enable = true;

  programs.fzf = {
    enable = true;
    # tmux.enableShellIntegration = true;
  };

  programs.bottom = {
    enable = true;
  };

  programs.less.enable = true;
  programs.vim.enable = true;
  programs.texlive.enable = true;
}
