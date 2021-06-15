# IRB.conf[:VERBOSE] = true
# hairballs_path = Dir.glob("#{Gem.dir}/gems/hairballs-*/lib")
# $LOAD_PATH.unshift(hairballs_path.first) unless hairballs_path.empty?
require 'readline'
require 'hairballs'

if Hairballs.rails?
  require 'hairballs/themes/turboladen_rails'
  Hairballs.use_theme(:turboladen_rails)
  # require 'hairballs/themes/turboladen'
  # Hairballs.use_theme(:turboladen)
else
  require 'hairballs/themes/turboladen'
  Hairballs.use_theme(:turboladen)

  require 'hairballs/plugins/require_project_lib'
  Hairballs.load_plugin(:require_project_lib)
end

require 'hairballs/plugins/irb_history'
Hairballs.load_plugin(:irb_history, global_history_file: false)

require 'hairballs/plugins/interesting_methods'
Hairballs.load_plugin(:interesting_methods)

require 'hairballs/plugins/object_ri'
Hairballs.load_plugin(:object_ri)

# require 'hairballs/plugins/wirb'
# Hairballs.load_plugin(:wirb)

# require 'hairballs/plugins/colorize_json'
# Hairballs.load_plugin(:colorize_json)

require 'hairballs/plugins/quick_benchmark'
Hairballs.load_plugin(:quick_benchmark)

require 'hairballs/plugins/tab_completion_for_files'
Hairballs.load_plugin(:tab_completion_for_files)

# require 'hairballs/plugins/binding_dot_irb'
# Hairballs.load_plugin(:binding_dot_irb)

def pbcopy(input)
  str = input.to_s
  IO.popen('pbcopy', 'w') { |f| f << str }
  str
end

require 'irb/ext/save-history'
