{ pkgs, ... }:

{
  # Import modular *.nix files
  imports = [
    ./configs/zsh.nix
    ./configs/git.nix
    ./configs/yabai.nix
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
    exa
    pdftk
    rsync
    ripgrep
    gnused
    texlive.combined.scheme-full
    tree
    youtube-dl
    wget

    # Fonts
    nerdfonts
  ];

  fonts.fontconfig.enable = true;

  programs.fzf = {
    enable = true;
    # tmux.enableShellIntegration = true;
  };

  programs.tmux = {
    enable = true;

    aggressiveResize = true;
    baseIndex = 1;
    escapeTime = 0;  # Allows for faster key repetition
    clock24 = true;
    historyLimit = 50000;
    keyMode = "vi";  # vi or emacs
    shortcut = "t";  # Same as prefix; Use Ctrl-t rather than the default Ctrl-b
    terminal = "screen-256color";
    extraConfig = ''
    ### Mouse support ###
    set -g mouse on

    ### Styles ###
    # https://github.com/seebi/tmux-colors-solarized/blob/master/tmuxcolors-256.conf
    set-option -g status-bg colour235 #base02
    set-option -g status-fg colour136 #yellow
    set-option -g status-attr default

    # default window title colors
    set-window-option -g window-status-fg colour244 #base0
    set-window-option -g window-status-bg default
    #set-window-option -g window-status-attr dim

    # active window title colors
    set-window-option -g window-status-current-fg colour166 #orange
    set-window-option -g window-status-current-bg default
    #set-window-option -g window-status-current-attr bright

    # pane border
    set-option -g pane-border-fg colour235 #base02
    set-option -g pane-active-border-fg colour240 #base01

    # message text
    set-option -g message-bg colour235 #base02
    set-option -g message-fg colour166 #orange

    # pane number display
    set-option -g display-panes-active-colour colour33 #blue
    set-option -g display-panes-colour colour166 #orange

    # clock
    set-window-option -g clock-mode-colour green #green

    # Alignment
    set -g status-interval 1
    set -g status-justify centre # center align window list
    set -g status-left-length 20
    set -g status-right-length 140
    set -g status-left '#[fg=green]#H #[fg=black]• #[fg=green,bright]#(uname -r | cut -c 1-6)#[default]'
    # set -g status-right '#[fg=green,bg=default,bright]#(tmux-mem-cpu-load) #[fg=red,dim,bg=default]#(uptime | cut -f 4-5 -d " " | cut -f 1 -d ",") #[fg=white,bg=default]%a%l:%M:%S %p#[default] #[fg=blue]%Y-%m-%d'

    ### Activity monitoring ###
    setw -g monitor-activity on
    set -g visual-activity on

    ### Key binds ###
    # set window split
    bind-key v split-window -h
    bind-key b split-window

    # hjkl pane traversal
    bind h select-pane -L
    bind j select-pane -D
    bind k select-pane -U
    bind l select-pane -R

    bind-key C-t last-window

    # C-n, C-p to move to other pane
    bind-key C-n next-window
    bind-key C-p previous-window
    '';
  };
}
