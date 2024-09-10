{ pkgs
, inputs
, ...
}: {
  home.packages = with pkgs; [
    git
    gh
    alejandra
    nil
    fish
    gcc
    cargo
  ];

  nixpkgs.config = {
    allowUnfree = true;
  };

  programs = {

  xdg.configFile."fish/completions/nix.fish".source = "${pkgs.nix}/share/fish/vendor_completions.d/nix.fish";

  home = {
    sessionVariables = {
      EDITOR = "nvim";
      SHELL = "nu";
    };
    stateVersion = "23.11";
  };
}
