{
  imports = [./common.nix];
  home.file = {
    ".vscode-server/server-env-setup" = {
      text = ''PATH=$PATH:/run/current-system/sw/bin/'';
      executable = true;
    };
  };
  xdg.configFile."awesome" = { 
	source = ./awe;
	recursive = true;
  };
}
