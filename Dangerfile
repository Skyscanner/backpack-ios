list_of_files = (git.added_files + git.modified_files)
list_of_files_excluding_this_one = list_of_files - ['Dangerfile']
has_objective_c_changes = list_of_files.any? { |path| path.end_with?('h') || path.end_with?('m') }
uses_non_RTL_anchor = list_of_files_excluding_this_one.any? { |path| File.file?(path) && (File.read(path).include?('leftAnchor') || File.read(path).include?('rightAnchor')) }

# warning and errors

if uses_non_RTL_anchor
  warn("You have used `leftAnchor` or `rightAnchor`. These should generally be avoided to ensure that RTL is supported.")
end

