{ pkgs, lib, nixpkgs, promox-nixos, ... }: {
	services.proxmox-ve.enable = true;
        nixpkgs.overlays = [
              proxmox-nixos.overlays.${system}
            ];
	networking.bridges.vmbr0.interfaces = [ "ens18" ];
	networking.interfaces.vmbr0.useDHCP = lib.mkDefault true;
}
