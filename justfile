default:
	@just --list

current_host_name := `hostnamectl hostname`

switch_with machine_name:
	sudo nixos-rebuild switch --flake .#{{machine_name}}

switch: (switch_with current_host_name)

toggle-hide-waybar:
	@pkill -SIGUSR1 waybar

reload-waybar:
	@just switch
	@pkill waybar || true
	@hyprctl dispatch -- exec waybar
