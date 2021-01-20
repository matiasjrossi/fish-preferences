function __fish_preferences_run
  set --local preferences_path (__fish_preferences_absolute_path)
  __fish_preferences_apply_preferences_file $preferences_path && __fish_preferences_store_variables $preferences_path
end
