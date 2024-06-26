default:
	@just --list

current_host_name := `hostnamectl hostname`

switch_with machine_name:
	sudo nom build --profile /nix/var/nix/profiles/system \
		.#nixosConfigurations.{{machine_name}}.config.system.build.toplevel
	sudo ./result/bin/switch-to-configuration switch

switch: (switch_with current_host_name)

repl_with machine_name:
	nixos-rebuild repl --flake .#{{machine_name}}

repl: (repl_with current_host_name)

toggle-hide-waybar:
	@pkill -SIGUSR1 waybar

reload-waybar:
	@just switch
	@pkill waybar || true
	@hyprctl dispatch -- exec waybar
