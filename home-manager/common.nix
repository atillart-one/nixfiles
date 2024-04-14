{pkgs, ...}: {
  home.packages = with pkgs; [
    xonsh
    git
    gh
    helix
    alejandra
  ];

  home.stateVersion = "23.11";
}
