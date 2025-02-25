{ inputs
, outputs
, lib
, config
, pkgs
, ...
}: {
  imports = [
    inputs.hardware.nixosModules.common-cpu-intel
    inputs.hardware.nixosModules.common-gpu-nvidia
    inputs.hardware.nixosModules.common-pc-ssd
    inputs.hardware.nixosModules.common-pc-laptop
    ./hardware-configuration.nix
    ../common.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "snowdrop"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
    # useXkbConfig = true; # use xkb.options in tty.
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.rs = {
    isNormalUser = true;
    initialPassword = "123";
    extraGroups = [ "wheel" "docker" ]; # Enable ‘sudo’ for the user.
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    neovim
    wget
    git
  ];
	
  hardware.nvidia = {
	prime = {
	  offload.enable = false;
	  sync.enable = true;

    	  # Make sure to use the correct Bus ID values for your system!
    	  intelBusId = "PCI:0:2:0";
    	  nvidiaBusId = "PCI:1:0:0";
	};
	open = false;
  };

  hardware.graphics.enable32Bit = true;

  virtualisation.docker = {
  	enable = true;
	storageDriver = "btrfs";
  };

  hardware.nvidia-container-toolkit.enable = true;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.11";
}
