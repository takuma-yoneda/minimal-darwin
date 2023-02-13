{ config, lib, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "Takuma Yoneda";
    userEmail = "takuma-yoneda@users.noreply.github.com";
    aliases = {
      co = "checkout";
      br = "branch";
      ci = "commit";
      st = "status";
      rv = "remote --verbose";
      hist = "log --pretty=format:'%h %ad | %s%d [%an]' --graph --date=short";
      histall = "log --pretty=format:'%h %ad | %s%d [%an]' --graph --date=short --reflog";
    };
    delta = {
      enable = true;
    };
    ignores = [".DS_Store" "*.pyc" "__pycache__"];
    lfs.enable = true;
    extraConfig = {
      core.editor = "vi";
      init.defaultBranch = "main";
      pull = {
        ff = "only";
        rebase = false;
      };
    };
  };
}
