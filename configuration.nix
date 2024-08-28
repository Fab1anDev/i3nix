{ config, pkgs, ... }:
let
    home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/master.tar.gz";
in
{
    imports =
    [ 
        ./hardware-configuration.nix
        (import "${home-manager}/nixos")
    ];

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    
    nix.gc = { 
        automatic = true; 
        dates = "weekly"; 
        options = "--delete-older-than 3d"; 
    }; 

    networking.hostName = "NixOS"; 
    networking.networkmanager.enable = true;  
    time.timeZone = "Europe/Berlin";
        
    nixpkgs.config.allowUnfree = true;
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    
    hardware.pulseaudio.extraConfig = "load-module module-combine-sink";
    hardware.pulseaudio.enable = true;
    hardware.pulseaudio.support32Bit = true;
    hardware.bluetooth.enable = true;
    
    # security
    security = {
        doas = {
            enable = true;
            extraRules = [{
                users = [ "fabian" ];
                persist = true;
            }];
        }; 
    };

    # services
    services.mullvad-vpn.enable = true;
    services.xserver = {
        enable = true;
        displayManager.startx.enable = true;
    };
    
    programs = {
        nix-ld.enable = true;    
    };

    users.users.fabian = {
        isNormalUser = true;
        initialPassword = "1601";
        extraGroups = [ "wheel" "audio" ];
    };

    fonts.fontconfig.enable = true;
    fonts.fontDir.enable = true;
    fonts.packages = with pkgs; [
        noto-fonts
        noto-fonts-cjk
        noto-fonts-emoji
        liberation_ttf
        fira-code
        fira-code-symbols
        fantasque-sans-mono
        mplus-outline-fonts.githubRelease
        dina-font
        proggyfonts
        (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
    ]; 
    environment.systemPackages = with pkgs; [
        wget
        git
        curl
        vim
        pacman
        ntfs3g
        dosfstools
        unzip
    ];

    system.stateVersion = "unstable";  
    # home-manager
    
    environment.etc = {
        "makepkg.conf".source = "${pkgs.pacman}/etc/makepkg.conf";
        "pacman.conf".source = ./modules/raw/pacman.conf;
    };
    home-manager.users.fabian = import ./home.nix;
}

