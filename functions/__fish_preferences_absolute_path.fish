function __fish_preferences_absolute_path
  set --local absolute_path $fish_preferences_path
  string match -q '/*' $absolute_path || set absolute_path $fish_function_path[1]/../$absolute_path
  echo $absolute_path
end
