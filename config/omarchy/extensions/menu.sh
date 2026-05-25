# Overwrite parts of the omarchy-menu with user-specific submenus.

show_install_development_menu() {
  case $(menu "Install" "  Docker\n󰫏  Ruby on Rails\n  Docker DB\n  JavaScript\n  Go\n  PHP\n  Python\n  Elixir\n  Zig\n  Rust\n  Java\n  .NET\n  OCaml\n  Clojure\n  Scala") in
  "  Docker") present_terminal omarchy-install-docker ;;
  "󰿩  .NET") present_terminal "omarchy-install-dev-env dotnet" ;;
  *Rails*) present_terminal "omarchy-install-dev-env ruby" ;;
  *Docker*) present_terminal omarchy-install-docker-dbs ;;
  *JavaScript*) show_install_javascript_menu ;;
  *Go*) present_terminal "omarchy-install-dev-env go" ;;
  *PHP*) show_install_php_menu ;;
  *Python*) present_terminal "omarchy-install-dev-env python" ;;
  *Elixir*) show_install_elixir_menu ;;
  *Zig*) present_terminal "omarchy-install-dev-env zig" ;;
  *Rust*) present_terminal "omarchy-install-dev-env rust" ;;
  *Java*) present_terminal "omarchy-install-dev-env java" ;;
  *NET*) present_terminal "omarchy-install-dev-env dotnet" ;;
  *OCaml*) present_terminal "omarchy-install-dev-env ocaml" ;;
  *Clojure*) present_terminal "omarchy-install-dev-env clojure" ;;
  *Scala*) present_terminal "omarchy-install-dev-env scala" ;;
  *) show_install_menu ;;
  esac
}
