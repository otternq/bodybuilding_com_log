# workout_spec.rb

require_relative 'spec_helper'

RSpec.describe Workout do
  context 'responds to' do
    [:user_name, :workout_name, :exercises, :num_exercises,
     :set_alteration, :alteration, :pdf_url, :pdf_url_alterations,
     :pdf_url_exercises, :pdf_url_encode].each do |attribute|
      it { should respond_to attribute }
    end
  end
end

RSpec.describe Workout, '#num_exercises' do
  subject do
    w = Workout.new
    w.exercises << 5
    w.exercises << 6
    w
  end

  it do
    expect(subject.num_exercises).to eql(2)
  end
end

RSpec.describe Workout, '#pdf_url_exercises(params)' do
  let(:e1) do
    e = Exercise.new('curl')
    e.sets << 7
    e
  end

  let(:e2) do
    e = Exercise.new('pull up')
    e.sets << 5
    e.sets << 3
    e
  end

  let(:expected) do
    e = []
    e << 'Exercise[]=curl'
    e << 'Sets[]=1'
    e << 'Exercise[]=pull up'
    e << 'Sets[]=2'
  end

  subject do
    w = Workout.new
    w.exercises << e1
    w.exercises << e2
    w
  end

  it do
    params = []
    subject.pdf_url_exercises(params)
    expect(params).to match(expected)
  end
end

RSpec.describe Workout, '#pdf_url_alterations(params)' do
  let(:expected) do
    e = []
    e << 'mood=no'
    e << 'weight=yes'
  end

  subject do
    w = Workout.new
    w.set_alteration('mood', false)
    w.set_alteration(:weight, true)
    w
  end

  it do
    params = []
    subject.pdf_url_alterations(params)
    expect(params).to match(expected)
  end
end
