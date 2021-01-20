function __fish_preferences_store_variables --argument-names preferences_path
  set --local output (command mktemp)
  __fish_preferences_debug "output=$output"
  for mode in --export --unexport
    for var in (set --long --universal $mode)
      if __fish_preferences_matches $var $fish_preferences_blessed_prefixes
      or not __fish_preferences_matches $var $fish_preferences_ignored_prefixes
        __fish_preferences_debug "matched: $var"
        echo "set --universal $mode $var"
      end
    end
  end | env LC_ALL=C sort > $output
  command mv $output $preferences_path > /dev/null 2>&1
  set --local result $status
  __fish_preferences_debug "mv output result=$result"
  if ! test $result -eq 0
    __fish_preferences_warn "Cannot store preferences in \"$preferences_path\""
  end
  command rm -f $output 2>&1
  __fish_preferences_debug "rm output status=$status"
  return $result
end
