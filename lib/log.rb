# log.rb

# include local dependencies
%w(
  exercise
  routine
  workout
).each do |file|
  require_relative "./log/#{file}"
end

# The module used for reference
module Log
  VERSION = '1.0'
end
