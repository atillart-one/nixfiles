{ inputs
, outputs
, lib
, config
, pkgs
, ...
}:
{
  services.jellyfin = {
  	enable = true;
	openFirewall = true;
  };
  services.sonarr = {
  	enable = true;
	openFirewall = true;
  };
  environment.systemPackages = [
    pkgs.jellyfin
    pkgs.jellyfin-web
    pkgs.jellyfin-ffmpeg
  ];
  nixpkgs.config.permittedInsecurePackages = [
          "aspnetcore-runtime-6.0.36"
          "aspnetcore-runtime-wrapped-6.0.36"
          "dotnet-sdk-6.0.428"
          "dotnet-sdk-wrapped-6.0.428"
  ];
}
