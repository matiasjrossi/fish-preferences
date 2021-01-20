function __fish_preferences_debug
  if set --query __fish_preferences_debug
    __fish_preferences_warn %self [debug] $argv
  end
end
