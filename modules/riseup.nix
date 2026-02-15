{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    riseup-vpn
  ];
}
