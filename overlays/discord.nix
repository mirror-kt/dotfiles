self: super: {
  discord = super.discord.overrideAttrs (oldAttrs: {
    postInstall = oldAttrs.postInstall or "" + ''
      wrapProgram $out/opt/discord/discord --add-flags "''${NIXOS_OZONE_WL:+--enable-wayland-ime}"
    '';
  });
}
