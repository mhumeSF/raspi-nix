{ lib, ... }: {
  imports = [
    <nixpkgs/nixos/modules/installer/sd-card/sd-image.nix>
    <nixpkgs/nixos/modules/installer/sd-card/sd-image-aarch64.nix>
  ];
  disabledModules = [
    "profiles/all-hardware.nix"
    "profiles/base.nix"
  ];
  security.sudo.wheelNeedsPassword = false;
  users.users = {
    nixie = {
      isNormalUser = true;
      home = "/home/nixie";
      description = "Nixie Admin";
      extraGroups = [ "wheel" "networkmanager" ];

      openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFLpijNKLQTJJXToZRGjRWb2f1EgPG9IzzO85mvbjbaY nixie@router" ];
    };
  };
  programs.zsh.enable = true;
  # bzip2 compression takes loads of time with emulation, skip it.
  sdImage.compressImage = false;
  services.openssh.enable = true;
  system.stateVersion = "23.05"; # Did you read the comment?
}
