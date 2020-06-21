{ config, pkgs, lib, options, ... }:

with lib;

let cfg = config.profiles.system.base;
in {
  options.profiles.system.base.enable =
    mkEnableOption "my system base configuration";

  config = mkIf cfg.enable {
    environment.etc."nixos/overlays-compat/overlays.nix".text =
      builtins.readFile ./../../pkgs/overlays.nix;

    nix = {
      # required for remote builders
      trustedUsers = [ "root" "@wheel" ];
      nixPath = options.nix.nixPath.default
        ++ [ "nixpkgs-overlays=/etc/nixos/overlays-compat/" ];
      # conserve disk space by hardlinking identical store files
      autoOptimiseStore = true;
    };

    # steam, etc
    nixpkgs = {
      config = {
        allowUnfree = true;
        # lutris and protontricks depend on this
        permittedInsecurePackages = [ "p7zip-16.02" ];
      };
      overlays = [
        (self: super: {
          base-scripts = (super.runCommand "base-scripts" {
            preferLocalBuild = true;
            allowSubstitutes = false;
          } ''
            for tool in ${./../../bin/tools}"/"*; do
              install -D -m755 $tool $out/bin/$(basename $tool)
            done

            patchShebangs $out/bin
          '');
        })
      ];
    };

    boot = {
      # Use the systemd-boot EFI boot loader.
      loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
      };
      # ntfs write support
      supportedFilesystems = [ "ntfs-3g" ];
    };

    networking = {
      firewall = {
        allowedTCPPorts = [
          5900 # spice
          8384 # syncthing interface
          22000 # syncthing transfer
        ];
        allowedUDPPorts = [
          21027 # syncthing discovery
        ];
      };

      networkmanager = {
        enable = true;
        # wifi.backend = "iwd";
      };
    };

    console = {
      # font = "Lat2-Terminus16";
      keyMap = "us";
    };

    i18n.defaultLocale = "en_US.UTF-8";
    time.timeZone = "America/Chicago";

    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # programs.mtr.enable = true;
    # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

    programs.ssh.startAgent = true;

    services.openssh.enable = true;

    # users.mutableUsers = false;
    # Don't forget to set a password with ‘passwd’.
    users.users.lh = {
      isNormalUser = true;
      shell = pkgs.fish;
      extraGroups = [
        "wheel" # sudo
        "networkmanager" # networking
        "input" # uinput? steam controller?
        "video"
        "dialout" # serial ports for MCU programming
        "lp" # printing?
      ];
    };

    home-manager = {
      useUserPackages = true;
      useGlobalPkgs = true;
    };
  };
}
