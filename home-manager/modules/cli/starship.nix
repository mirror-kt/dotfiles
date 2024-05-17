{ config, lib, theme, ... }:
with lib; let
  cfg = config.myHomeSettings.starship;
in
{
  options = {
    myHomeSettings.starship = {
      enable = mkOption {
        type = types.bool;
        default = true;
        description = mdDoc ''
          Enable starship
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    programs.starship = {
      enable = true;
      settings = {
        palette = "${theme}";
        palettes.${theme} = with config.scheme.withHashtag; {
          dark = base00;
          light = base05;

          username = base0E;
          directory = base08;
          vcs = base0A;
          languages = base0B;
          credentials = base0C;
          cmd_info = base0E;
        };

        format = concatStrings [
          "[](username)"
          "$container"
          "$os"
          "$username"
          "[](fg:username bg:directory)"
          "$directory"
          "[](fg:directory bg:vcs)"
          "$git_branch"
          "$git_state"
          "$git_status"
          "$git_commit"
          "[](fg:vcs bg:languages)"
          "$c"
          "$cmake"
          "$cobol"
          "$daml"
          "$dart"
          "$deno"
          "$dotnet"
          "$elixir"
          "$elm"
          "$erlang"
          "$fennel"
          "$gleam"
          "$golang"
          "$guix_shell"
          "$haskell"
          "$haxe"
          "$helm"
          "$java"
          "$julia"
          "$kotlin"
          "$gradle"
          "$lua"
          "$nim"
          "$nodejs"
          "$ocaml"
          "$opa"
          "$perl"
          "$php"
          "$pulumi"
          "$purescript"
          "$python"
          "$quarto"
          "$raku"
          "$rlang"
          "$red"
          "$ruby"
          "$rust"
          "$scala"
          "$solidity"
          "$swift"
          "$terraform"
          "$typst"
          "$vlang"
          "$vagrant"
          "$zig"
          "$buf"
          "[](fg:languages bg:credentials)"
          "$docker_context"
          "$gcloud"
          "[](fg:credentials bg:cmd_info)"
          "$cmd_duration"
          "[](fg:cmd_info)"
          "$line_break"
          "$status"
          "$character"
        ];

        # Disable the blank line at the start of the prompt
        add_newline = true;

        # You can also replace your username with a neat symbol like   or disable this
        # and use the os module below
        username = {
          style_user = "bg:username";
          style_root = "bg:username";
          format = "[$user]($style)";
          disabled = false;
        };

        # An alternative to the username module which displays a symbol that
        # represents the current operating system
        os = {
          style = "bg:username fg:light";
          disabled = false;
          symbols = {
            NixOS = " ";
          };
        };

        directory = {
          style = "bg:directory fg:light";
          format = "[ $path ]($style)";
          truncation_length = 3;
          truncation_symbol = "…/";
        };

        buf = {
          style = "bg:languages fg:light";
          format = "[$symbol ($version)]($style)";
        };

        bun = {
          style = "bg:languages fg:light";
          format = "[$symbol ($version)]($style)";
        };

        c = {
          symbol = " ";
          style = "bg:languages fg:light";
          format = "[$symbol ($version)]($style)";
        };

        character = {
          success_symbol = "[❯](bold green)";
          error_symbol = "[ ❯](bold red)";
        };

        cmake = {
          style = "bg:languages fg:light";
          format = "[$symbol ($version)]($style)";
        };

        cobol = {
          style = "bg:languages fg:light";
          format = "[$symbol ($version)]($style)";
        };

        conda = {
          style = "bg:languages fg:light";
          format = "[$symbol$environment]($style)";
        };

        container = {
          style = "bg:languages fg:light";
          format = "[$symbol $name]($style)";
        };

        crystal = {
          symbol = "󰬯";
          style = "bg:languages fg:light";
          format = "[$symbol $name]($style)";
        };

        daml = {
          style = "bg:languages fg:light";
          format = "[$symbol ($version)]($style)";
        };

        dart = {
          symbol = "";
          style = "bg:languages fg:light";
          format = "[$symbol ($version)]($style)";
        };

        deno = {
          style = "bg:languages fg:light";
          format = "[$symbol ($version)]($style)";
        };

        docker_context = {
          symbol = "";
          style = "bg:credentials";
          format = "[$symbol $context]($style)";
        };

        dotnet = {
          symbol = "";
          style = "bg:languages fg:light";
          format = "[$symbol ($version)(🎯 $tfm)]($style)";
        };

        elixir = {
          symbol = "";
          style = "bg:languages fg:light";
          format = "[$symbol ($version)(OTP $otp_version)]($style)";
        };

        elm = {
          symbol = "";
          style = "bg:languages fg:light";
          format = "[$symbol ($version)]($style)";
        };

        erlang = {
          style = "bg:languages fg:light";
          format = "[$symbol ($version)]($style)";
        };

        fennel = {
          style = "bg:languages fg:light";
          format = "[$symbol ($version)]($style)";
        };

        gcloud = {
          symbol = "🇬️";
          format = "[$symbol$account(@domain)]($style)";
        };

        git_branch = {
          symbol = "";
          style = "bg:vcs fg:light";
          format = "[$symbol $branch]($style)";
        };

        git_commit = {
          tag_symbol = "🏷";
          style = "bg:vcs fg:light";
          format = "[\($hash$tag\)]($style)";
          tag_disabled = false;
        };

        git_state = {
          style = "bg:vcs fg:light";
          format = "[\($state ($progress_current/$progress_total)\)]($style)";
          rebase = "[🔃](bold red)";
          revert = "[⏪️](bold red)";
          bisect = "[ℹ](bold red)";
          cherry_pick = "[🍒](bold red)";
        };

        git_status = {
          style = "bg:vcs fg:light";
          format = "[$all_status$ahead_behind]($style)";
        };

        # gleam = {
        #   style = "bg:languages fg:light";
        #   format = "[$symbol($version)]($style)";
        # };

        golang = {
          symbol = "";
          style = "bg:languages fg:light";
          format = "[$symbol ($version)]($style)";
        };

        guix_shell = {
          style = "bg:languages fg:light";
          format = "[$symbol ($version)]($style)";
        };

        gradle = {
          symbol = "";
          style = "bg:languages fg:light";
          format = "[$symbol ($version)]($style)";
        };

        haskell = {
          symbol = "";
          style = "bg:languages fg:light";
          format = "[$symbol ($version)]($style)";
        };

        haxe = {
          symbol = "";
          style = "bg:languages fg:light";
          format = "[$symbol ($version)]($style)";
        };

        helm = {
          style = "bg:languages fg:light";
          format = "[$symbol ($version)]($style)";
        };

        java = {
          symbol = "";
          style = "bg:languages fg:light";
          format = "[$symbol ($version)]($style)";
        };

        julia = {
          symbol = "";
          style = "bg:languages fg:light";
          format = "[$symbol ($version)]($style)";
        };

        kotlin = {
          symbol = "󱈙";
          style = "bg:languages fg:light";
          format = "[$symbol ($version)]($style)";
        };

        lua = {
          symbol = "";
          style = "bg:languages fg:light";
          format = "[$symbol ($version)]($style)";
        };

        meson = {
          style = "bg:languages fg:light";
          format = "[$symbol$project]($style)";
        };

        nim = {
          symbol = "";
          style = "bg:languages fg:light";
          format = "[$symbol ($version)]($style)";
        };

        nix_shell = {
          symbol = "";
          style = "bg:languages fg:light";
          format = "[$symbol $state ($name)]($style)";
        };

        nodejs = {
          symbol = "";
          style = "bg:languages fg:light";
          format = "[$symbol ($version)]($style)";
        };

        ocaml = {
          symbol = "";
          style = "bg:languages fg:light";
          format = "[$symbol ($version)($switch_indicator$switch_name)]($style)";
        };

        odin = {
          style = "bg:languages fg:light";
          format = "[$symbol ($version)]($style)";
        };

        opa = {
          style = "bg:languages fg:light";
          format = "[$symbol ($version)]($style)";
        };

        openstack = {
          style = "bg:languages fg:light";
          format = "[$symbol $cloud($project)]($style)";
        };

        perl = {
          symbol = "";
          style = "bg:languages fg:light";
          format = "[$symbol ($version)]($style)";
        };

        php = {
          symbol = "";
          style = "bg:languages fg:light";
          format = "[$symbol ($version)]($style)";
        };

        pijul_channel = {
          style = "bg:vcs fg:light";
          format = "[$symbol$channel]($style)";
        };

        rust = {
          symbol = "";
          style = "bg:languages fg:light";
          format = "[$symbol ($version)]($style)";
        };

        scala = {
          symbol = "";
          style = "bg:languages fg:light";
          format = "[$symbol ($version)]($style)";
        };

        cmd_duration = {
          style = "bg:cmd_info";
          format = "[󱦟 $duration]($style)";
        };
      };
    };
  };
}
