# IRB.conf[:VERBOSE] = true
require 'readline'

def pbcopy(input)
  str = input.to_s
  IO.popen('pbcopy', 'w') { |f| f << str }
  str
end

# require 'irb/ext/save-history'
