{ config, lib, pkgs, ... }:

{
    home.file.borders = {
        executable = true;
        target = ".config/borders/bordersrc";
        text = let
            borders = "/opt/homebrew/bin/borders";
        in
            ''
            #!/usr/bin/env bash
            options=(
                style=round
                width=6.0
                hidpi=off
                active_color=0xffe2e2e3
                inactive_color=0xff414550
            )
            ${borders} "''${options[@]}"
            '';
    };
}