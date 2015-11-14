file = File.symlink?(__FILE__) ? File.readlink(__FILE__) : __FILE__
load File.expand_path('../irbrc', file)

# ActiveRecord::Base.logger = Logger.new(STDOUT) if defined? ActiveRecord

if defined?(PryDebugger)
  Pry.commands.alias_command 'c', 'continue'
  Pry.commands.alias_command 's', 'step'
  Pry.commands.alias_command 'n', 'next'
  Pry.commands.alias_command 'f', 'finish'
end
