{ writeShellScriptBin, openvpn, update-resolv-conf }:
writeShellScriptBin "rb-vpn" ''
  sudo ${openvpn}/bin/openvpn  \
    --config ~/.bin/rb.hristo.deshev.ovpn \
    --up ${update-resolv-conf}/libexec/openvpn/update-resolv-conf \
    --down ${update-resolv-conf}/libexec/openvpn/update-resolv-conf \
    --script-security 2
  ''

