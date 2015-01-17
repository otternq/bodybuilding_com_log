#!ruby

# example.rb

require_relative '../lib/log'

workout = Workout.new
workout.workout_name = 'Monday'

bp = Exercise.new('Bench Press')
bp.sets << 7
bp.sets << 8

ibp = Exercise.new('Incline Bench Press')
ibp.sets << 7
ibp.sets << 8
ibp.sets << 9

workout.exercises << bp
workout.exercises << ibp

workout.set_alteration(:mood, true)

workout.ascii
