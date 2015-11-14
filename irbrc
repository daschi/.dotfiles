require 'rubygems'


def try_to_require(lib)
  begin
    if defined?(::Bundler)
      $LOAD_PATH.concat Dir.glob("#{ENV['rvm_ruby_global_gems_path']}/gems/#{lib}/lib")
    end
    require lib
    yield if block_given?
  rescue LoadError
    $stderr.puts "Failed to load gem \"#{lib}\" required by .irbrc"
  end
end

# try_to_require 'wirble' do
#   Wirble.init
#   Wirble.colorize
# end
#
# try_to_require 'hirb' do
# Hirb.enable
# end


if defined? IRB
  IRB.conf[:SAVE_HISTORY] = 1000
end

class String
  def clip
    `echo #{inspect} | pbcopy` && puts("copied")
    self
  end
end


# Clear the screen
def self.clear
  system 'clear'
end

class Object
  ANSI_BOLD     = "\033[1m"
  ANSI_RESET    = "\033[0m"
  ANSI_LGRAY    = "\033[0;37m"
  ANSI_BLUE     = "\033[0;34m"

  # Print object's methods
  def pm(*options)
    methods = self.methods
    methods -= Object.methods unless options.include? :more
    filter = options.select {|opt| opt.kind_of? Regexp}.first
    methods = methods.select {|name| name =~ filter} if filter

    data = methods.sort.collect do |name|
      method = self.__method__(name) rescue self.method(name)
      if method.arity == 0
        args = "()"
      elsif method.arity > 0
        n = method.arity
        args = "(#{(1..n).collect {|i| "arg#{i}"}.join(", ")})"
      elsif method.arity < 0
        n = -method.arity
        args = "(#{(1..n).collect {|i| "arg#{i}"}.join(", ")}, ...)"
      end
      klass = $1 if method.inspect =~ /Method: (.*?)#/
      [name, args, klass]
    end
    max_name = data.collect {|item| item[0].size}.max
    max_args = data.collect {|item| item[1].size}.max
    data.each do |item|
      print " #{ANSI_BOLD}#{item[0].to_s.rjust(max_name)}#{ANSI_RESET}"
      print "#{ANSI_BLUE}#{item[1].ljust(max_args)}#{ANSI_RESET}"
      print "   #{ANSI_LGRAY}#{item[2]}#{ANSI_RESET}\n"
    end
    data.size
  end

end

def edit_method object, method
  ::Object.instance_method(:method).bind(object).call(method).edit
end

module Method::Editable
  def edit
    if !respond_to?(:source_location)
      puts "#{self} has no source location"
    else
      path, line_number = source_location
      system(%[$EDITOR "#{path}:#{line_number}"])
    end
  end
end
UnboundMethod.send(:include, Method::Editable)
Method.send(:include, Method::Editable)

class BasicObject
  def wrap_method method_name, &wrapping_block
    original_method_proc = method(method_name).to_proc
    (class << self; self; end).send(:define_method, method_name) do |*args, &block|
      wrapping_block.call(original_method_proc, *args, &block)
    end
  end
end

if defined?(Rails)
  load("#{ENV['HOME']}/.rails.irbrc")
end

class Binding
  def locals
    eval '{'+eval('local_variables').map{|v| "#{v.inspect} => #{v}" }.join(', ')+'}'
  end
  def variable_name value
    var = locals.find{|k, v| v == value}
    var.first if var
  end
end


# require 'irb/completion'=D
# require 'irb/ext/save-history'
#
# IRB.conf[:SAVE_HISTORY] = 1000
# IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb-save-history"
# IRB.conf[:PROMPT_MODE]  = :SIMPLE
# IRB.conf[:AUTO_INDENT]  = true
# IRB.conf[:USE_READLINE] = true
#
#

#
#
#
# # Easily print methods local to an object's class
# class Object
#   def local_methods
#     (methods - Object.instance_methods).sort
#   end
# end
#
#
# # taken from @jsmestad's gist - http://gist.github.com/406963
# require 'pp'
# # Make gems available
# require 'rubygems'
#
# # # http://drnicutilities.rubyforge.org/map_by_method/
# # require 'map_by_method'
# #
# # # Dr Nic's gem inspired by
# # # http://redhanded.hobix.com/inspect/stickItInYourIrbrcMethodfinder.html
# # require 'what_methods'
# #
# # require 'ap'
# #
# # # Print information about any HTTP requests being made
# # require 'net-http-spy'
# #
# # # Draw ASCII tables
# # require 'hirb'
# # require 'hirb/import_object'
# # Hirb.enable
# # extend Hirb::Console
# #
# # # 'lp' to show method lookup path
# # require 'looksee/shortcuts'
# #
# # # Wirble is a set of enhancements for irb
# # # http://pablotron.org/software/wirble/README
# # # Implies require 'pp', 'irb/completion', and 'rubygems'
# # require 'wirble'
# # Wirble.init
# #
# # # Enable colored output
# # Wirble.colorize
#
#
# # # Load / reload files faster
# # # http://www.themomorohoax.com/2009/03/27/irb-tip-load-files-faster
# # def fl(file_name)
# #    file_name += '.rb' unless file_name =~ /\.rb/
# #    @@recent = file_name
# #    load "#{file_name}"
# # end
# #
# # def rl
# #   fl(@@recent)
# # end
# #
# # # Reload the file and try the last command again
# # # http://www.themomorohoax.com/2009/04/07/ruby-irb-tip-try-again-faster
# # def rt
# #   rl
# #   eval(choose_last_command)
# # end
# #
# # # prevent 'rt' itself from recursing.
# # def choose_last_command
# #   real_last = Readline::HISTORY.to_a[-2]
# #   real_last == 'rt' ? @@saved_last :  (@@saved_last = real_last)
# # end
#
# # Method to pretty-print object methods
# # Coded by sebastian delmont
# # http://snippets.dzone.com/posts/show/2916
