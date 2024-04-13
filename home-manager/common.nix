{ pkgs, ... }: {
  home.packages = with pkgs; [
    xonsh
  ];

  home.stateVersion = "23.11";
}
