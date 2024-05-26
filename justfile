default:
	@just --list

current_host_name := `hostnamectl hostname`

switch_with machine_name:
	sudo nixos-rebuild switch --flake .#{{machine_name}}

# switch_with machine_name:
# 	sudo nixos-rebuild switch --flake .#{{machine_name}} ^| nix run nixpkgs#nix-output-monitor

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
