# workout.rb

require 'open-uri'

class Workout
  attr_accessor :user_name, :workout_name, :exercises

  def initialize
    @exercises = []

    @alterations = Hash.new(true)
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
      str = 'yes' if value
      str = 'no' unless value
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
end
