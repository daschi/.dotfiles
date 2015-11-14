# rails_root = Dir.pwd
# history_file_path = File.join(rails_root, '.irb-save-history')
# app_name = File.basename(Dir.pwd)

# File.open(history_file_path, 'w'){ |f| f.write(' ') } unless File.exists? history_file_path

# if defined? IRB
#   IRB.conf[:PROMPT] ||= {}
#   IRB.conf[:PROMPT][:RAILS] = {
#     :PROMPT_I => "#{app_name} > ",
#     :PROMPT_S => "#{app_name} * ",
#     :PROMPT_C => "#{app_name} ? ",
#     :RETURN   => "=> %s\n"
#   }
#   IRB.conf[:PROMPT_MODE] = :RAILS
#   IRB.conf[:HISTORY_FILE] = history_file_path

#   # Called after the irb session is initialized and Rails has
#   # been loaded (props: Mike Clark).
#   IRB.conf[:IRB_RC] = Proc.new do
#     require 'logger'
#     stdout_logger = Logger.new(STDOUT)
#     RAILS_DEFAULT_LOGGER      = stdout_logger  if defined? RAILS_DEFAULT_LOGGER
#     Rails.logger              = stdout_logger  if defined?(Rails) && Rails.respond_to?(:logger=)
#     ActiveRecord::Base.logger = stdout_logger  if defined?(ActiveRecord)
#     Mongoid.logger            = stdout_logger  if defined?(Mongoid)
#     # MongoMapper.logger        = stdout_logger  if defined? MongoMapper # TODO

#     ActiveRecord::Base.instance_eval { alias :[] :find }  if defined? ActiveRecord

#     app.host = ENV['BASE_URL'] if defined?(app) && ENV['BASE_URL'].present?

#   end
# end

# # # Log to STDOUT if in Rails
# # unless Object.const_defined?('RAILS_DEFAULT_LOGGER')
# #   require 'logger'
# #   RAILS_DEFAULT_LOGGER = Logger.new(STDOUT)
# # end

# # def controller
# #   return @controller unless @controller.nil?
# #   @controller = ApplicationController.new
# #   @controller.instance_variable_set(:@_request, Debug::Request.new(url, params))
# #   @controller
# # end

# # def view
# #   return @view unless @view.nil?
# #   @view = ApplicationController.new.view_context
# #     @view = ActionView::Base.new.tap{ |view|
# #       view.view_paths = ActionController::Base.view_paths
# #       view.helpers.include *ApplicationController.master_helper_module.included_modules
# #       view.helpers.include Widgets
# #     }
# #   end
# #   @view
# # end
