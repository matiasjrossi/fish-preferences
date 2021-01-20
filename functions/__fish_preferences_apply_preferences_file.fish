function __fish_preferences_apply_preferences_file --argument-names preferences_path
  set --local input (command mktemp)
  __fish_preferences_debug "input=$input"
  cp $preferences_path $input > /dev/null 2>&1
  __fish_preferences_debug "cp input status=$status"
  set --local current_file_hash (command git hash-object $input)
  __fish_preferences_debug "__fish_preferences_last_hash=$__fish_preferences_last_hash, current_file_hash=$current_file_hash"
  if ! set -q __fish_preferences_last_hash || test $__fish_preferences_last_hash != $current_file_hash
    # delete
    for var in (set --names --universal)
      if __fish_preferences_matches $var $fish_preferences_blessed_prefixes
      or not __fish_preferences_matches $var $fish_preferences_ignored_prefixes
        if ! command grep -qE '^set --universal --(un)export '"$var"'( .*)$' (__fish_preferences_absolute_path)
          set --universal --erase $var
        end
      end
    end
    # upsert
    source (__fish_preferences_absolute_path)
    set --local result $status
    __fish_preferences_debug "source result=$result"
    if test $result -eq 0
      set --universal __fish_preferences_last_hash $current_file_hash
    else
      __fish_preferences_warn "Error while loading preferences from \"$preferences_path\""
    end
  end
  command rm -f $input 2>&1
  __fish_preferences_debug "rm input status=$status"
  return $result
end
