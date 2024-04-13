# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL

{ config, lib, pkgs, wsl, nix-ld-rs, ... }:

{
  imports = [ 
    # include NixOS-WSL modules
    wsl.nixosModules.default 
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.auto-optimise-store = true;

  wsl.enable = true;
  networking.hostName = "snowpack";
  wsl.defaultUser = "rs";

  # xonsh issue 
  # wsl.interop.includePath = false; 
  
  programs.nix-ld = {
    enable = true;
    package = nix-ld-rs.packages."${pkgs.system}".nix-ld-rs;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
