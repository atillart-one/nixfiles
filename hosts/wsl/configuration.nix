# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL
{ config
, lib
, pkgs
, inputs
, ...
}: {
  imports = [
    # include NixOS-WSL modules
    inputs.wsl.nixosModules.default
    ../common.nix
  ];

  nix.settings = {
    substituters = [ "https://cuda-maintainers.cachix.org" ];
    trusted-public-keys = [
      "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
    ];
  };

  wsl.enable = true;
  networking.hostName = "mistletoe";
  wsl.defaultUser = "rs";
  users.users.rs.shell = pkgs.nushell;

  services.openssh.allowSFTP = true;

  programs = {
    fish.enable = true;
    nix-ld = {
      enable = true;
      package = inputs.nix-ld-rs.packages."${pkgs.system}".nix-ld-rs;
    };
  };
  # NixOS-WSL disables this by default
  security.sudo.wheelNeedsPassword = true;

  environment.systemPackages = with pkgs; [ wslu nushell sshfs ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
