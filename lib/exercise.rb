# exercise.rb

# DTO for Exercise
class Exercise
  attr_accessor :name
  attr_reader :sets

  def initialize(name)
    @name = name
    @sets = []
  end

  def add_set(reps)
    fail 'reps must be an integer' unless reps.is_a? Integer
    @sets << reps
  end

  def rep_string
    @sets.join('-')
  end
end
