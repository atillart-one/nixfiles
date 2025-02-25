{
  pkgs,
  inputs,
  ...
}: {
  home = {
    packages = with pkgs; [
      git
      gh
      alejandra
      nil
      fish
      gcc
      cargo
    ];

    file = {
      ".vscode-server/server-env-setup" = {
        text = ''PATH=$PATH:/run/current-system/sw/bin/'';
        executable = true;
      };
    };
  };

  nixpkgs.config = {
    allowUnfree = true;
  };

  #  xdg.configFile."fish/completions/nix.fish".source = "${pkgs.nix}/share/fish/vendor_completions.d/nix.fish";

  programs.helix.enable = true;

  home = {
    sessionVariables = {
      EDITOR = "hx";
      SHELL = "fish";
    };
    stateVersion = "23.11";
  };
}
