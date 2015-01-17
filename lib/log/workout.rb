# workout.rb

require 'open-uri'

class Workout
  attr_accessor :user_name, :workout_name, :exercises

  def initialize
    @exercises = []

    @alterations = {}
    @allowed_keys = [:mood,:weight, :cardio, :location,
                     :length, :comments, :instruct]
  end

  def num_exercises
    @exercises.size
  end

  def set_alteration(key, value)
    fail 'value must be boolean' unless !!value == value
    @alterations[key.to_sym] = value
  end

  def alteration(key)
    fail 'invalid key' unless @allowed_keys.include? key
    @alterations[key]
  end

  def pdf_url
    params = []

    params << "firstname=#{user_name}"
    params << "name=#{workout_name}"
    params << "num_exercises=#{num_exercises}"

    pdf_url_exercises(params)
    pdf_url_alterations(params)
    pdf_url_encode(params)

    "http://www.bodybuilding.com/fun/printlog2.php?#{params.join('&')}"
  end

  def pdf_url_alterations(params)
    @alterations.each do |key, value|
      str = value ? 'yes' : 'no'
      params << "#{key}=#{str}"
    end
  end

  def pdf_url_exercises(params)
    @exercises.each do |exercise|
      params << "Exercise[]=#{exercise.name}"
      params << "Sets[]=#{exercise.sets.size}"
    end
  end

  def pdf_url_encode(params)
    params.map! do |param|
      URI.encode(param)
    end
  end

  def max_sets
    @exercises.max do |exercise|
      exercise.sets.size
    end.sets.size
  end

  def exercises_len
    @exercises.max do |exercise|
      exercise.name.length
    end.name.length
  end

  def ascii
    puts "Name: #{@workout_name}"

    sets_len = 20

    line = format("%-#{exercises_len}s", 'Exercise')
    max_sets.times do |i|
      line += format("%-#{sets_len}s", "| Set #{i+1}")
    end

    puts line

    line_br = ''

    ((exercises_len + 1) + (sets_len * max_sets)).times do
      line_br += '='
    end

    puts line_br

    @exercises.each do |exercise|
      line = sprintf("%-#{exercises_len}s", exercise.name)
      exercise.sets.size.times do
        line += sprintf("%-#{sets_len}s", '|')
      end

      puts line
    end
  end
end
