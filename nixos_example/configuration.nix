{ pkgs, ... }:

{
  # System hostname
  networking.hostName = "demo-vm";

  # Create a demo user
  users.users.demouser = {
    isNormalUser = true;
    initialPassword = "demo";
    description = "Demo User";
    extraGroups = [ "wheel" ];
  };

  # Basic system packages
  environment.systemPackages = with pkgs; [
    htop
    vim
  ];

  # Enable a basic service
  services.getty.autologinUser = "demouser";

  system.stateVersion = "24.05";
}
