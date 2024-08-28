{ config, pkgs, ... }:
{
    imports = [
        ./modules/i3.nix
        ./modules/alacritty.nix
        ./modules/user.nix
    ];

    nixpkgs.config.allowUnfree = true;
    home.enableNixpkgsReleaseCheck = false;
    home.packages = with pkgs; [
        # workspace
        alacritty
        firefox
	    dolphin
        qbittorrent
        filezilla
        mullvad-vpn
	
        # dev
        neovim
	vscode
        rustup
        python3
        fzf
        nodejs

        # wm
        i3status
	    feh
        rofi
        flameshot

	    # media & misc
        pavucontrol
        mpd
        mpc-cli
        ncmpcpp
        neofetch
        onefetch
        pfetch
        cava
        discord
    ];

    home.file = {
	    ".config/rofi/config.rasi".source = ./modules/raw/rofi/config.rasi;	
        ".config/i3/i3status.conf".source = ./modules/raw/i3/i3status.conf;
        ".config/starship.toml".source = ./modules/raw/starship.toml;
        ".wp/nixos_black.png".source = ./modules/raw/wp/nixos_black.png;

    };
    home.stateVersion = "24.11";
}
