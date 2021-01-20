status is-interactive || exit

function __fish_preferences_event_handler --on-event fish_prompt --on-event fish_exit
  fish --private --command '__fish_preferences_run' &
  __fish_preferences_debug "started job pid="(jobs --last --pid)
end

set --query fish_preferences_path || set --universal fish_preferences_path fish_preferences
set --query fish_preferences_blessed_prefixes || set --universal fish_preferences_blessed_prefixes _fish_abbr __fish_git_prompt
set --query fish_preferences_ignored_prefixes || set --universal fish_preferences_ignored_prefixes _

function __fish_preferences_uninstall --on-event __fish_preferences_uninstall
  functions --erase (functions --all | string match '__fish_preferences*')
  set --query fish_preferences_path && set --universal --erase fish_preferences_path
  set --query fish_preferences_blessed_prefixes && set --universal --erase fish_preferences_blessed_prefixes
  set --query fish_preferences_ignored_prefixes && set --universal --erase fish_preferences_ignored_prefixes
end
