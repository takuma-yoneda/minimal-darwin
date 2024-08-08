# NOTE: This file is read by Home Manager
# Remember that this file is set to `home-manager.users.yoneda`

{ pkgs, ... }:

{
  # Import modular *.nix files
  imports = [
    ./configs/zsh.nix
    ./configs/git.nix
    ./configs/tmux.nix
    ./configs/borders.nix
    # ./emacs
  ];

  # nixpkgs.config.allowUnfree = true;

  home.stateVersion = "23.11";

  home.packages = with pkgs; [
    # Nix related
    nix
    nixfmt
    nix-prefetch-git
    alejandra
    niv
    # pip2nix.python310

    # Other packages
    cowsay
    docker
    fd

    # HACK: ffmpeg for darwin has a segfault issue
    # reference: https://github.com/NixOS/nixpkgs/issues/271313#issuecomment-1836274601
    # ffmpeg-full
    (pkgs.ffmpeg.override {
      x264 = pkgs.x264.overrideAttrs (old: {
        postPatch = old.postPatch
          + pkgs.lib.optionalString (pkgs.stdenv.isDarwin) ''
            substituteInPlace Makefile --replace '$(if $(STRIP), $(STRIP) -x $@)' '$(if $(STRIP), $(STRIP) -S $@)'
          '';
      });
    })
    htop
    eza # Modern ls
    pdftk
    rsync
    ripgrep
    gnused
    # texlive.combined.scheme-full  # LaTeX
    tree
    # youtube-dl
    yt-dlp
    watch
    wget

    # mathpix-snipping-tool  # Seems broken
    # It's better to have project specific directories
    # that have these inside, but it's easier to install globally honestly...
    nodePackages.pnpm
    nodePackages.vercel

    # A set of nice utilities to do simple manipulation of images
    imagemagick

    # Fonts
    # Managing fonts in Home Manager vs Nix-Darwin??
    # The installed fonts can be found at `$HOME/Library/Fonts/HomeManager/*`
    nerdfonts

    # Security
    nmap

    # Build kits
    cmake

    texlive.combined.scheme-full

    # Darwin packages
    darwin.iproute2mac
  ];

  fonts.fontconfig.enable = true;

  programs.fzf = {
    enable = true;
    # tmux.enableShellIntegration = true;
  };

  programs.bottom.enable = true;
  programs.less.enable = true;
  programs.vim.enable = true;
  # programs.texlive.enable = true;
}
