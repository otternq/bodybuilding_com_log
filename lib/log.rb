# log.rb

# include local dependencies
%w(
  exercise
  routine
).each do |file|
  require_relative "./#{file}"
end

# The module used for reference
module Log
  VERSION = '1.0'
end
