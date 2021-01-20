function __fish_preferences_matches
  set --local target $argv[1]
  set --local prefixes $argv[2..-1]
  for prefix in $prefixes
    if string match -q $prefix'*' $target
      return 0
    end
  end
  return 1
end
