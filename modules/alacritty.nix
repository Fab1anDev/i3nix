{ config, pkgs, ... }:
{
    programs.alacritty = {
        enable = true;
        settings = {
            window.dimensions = {
                lines = 4;
                columns = 200;
            };
            font = {
                size = 15;
                normal = {
                    family = "FantasqueSansMono";
                    style = "Regular";
                };
            };
            shell = {
                program = "bash";
            };
            colors = {
                primary = {
                    foreground = "#FFFFFF";
                    background = "#282828";
                };
            };
        };
    };
}
