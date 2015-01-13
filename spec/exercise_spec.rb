# exercise_spec.rb

require_relative 'spec_helper'

RSpec.describe Exercise do
  subject { described_class.new('test') }
  context 'responds to' do
    [:name, :sets].each do |attribute|
      it { should respond_to attribute }
    end
  end
end

RSpec.describe Exercise do
  context '#initialize' do
    it do
      expect(described_class.new('test'))
        .to be_a described_class
    end
  end
end

RSpec.describe Exercise, '#name' do
  context 'make an assignment' do
    subject { described_class.new('test') }
    it do
      expect do
        subject.name = 'Calf Raises'
      end.to_not raise_error
    end
  end

  context 'read an name= assignment' do
    subject { described_class.new('test') }
    it do
      subject.name = 'Seated Calf Raises'
      expect(subject.name).to eql('Seated Calf Raises')
    end
  end

  context 'read a #initialize assignment' do
    subject { described_class.new('Bench Press') }
    it do
      expect(subject.name).to eql('Bench Press')
    end
  end
end

RSpec.describe Exercise, '#add_set' do
  context 'single digit assignment' do
    subject { described_class.new('Curl') }
    it do
      subject.add_set(8)
      expect(subject.sets.first).to eql(8)
    end
  end

  context 'double digit assignment' do
    subject { described_class.new('Curl') }
    it do
      subject.add_set(12)
      expect(subject.sets.first).to eql(12)
    end
  end

  context 'float, string assignment' do
    subject { described_class.new('Curl') }

    [1.8, 'test'].each do |val|
      it do
        expect do
          subject.add_set(val)
        end.to raise_error 'reps must be an integer'
      end
    end
  end
end

RSpec.describe Exercise do
  subject { described_class.new('test') }
  context 'sets' do
    it do
      subject.sets << 5
      expect(subject.sets.first).to eql(5)
    end
  end
end

RSpec.describe Exercise, '#rep_string' do
  subject { described_class.new('test') }
  context '3 sets' do
    it do
      subject.sets << 12
      subject.sets << 10
      subject.sets << 8

      expect(subject.rep_string).to eql('12-10-8')
    end
  end

  context '2 sets' do
    it do
      subject.sets << 9
      subject.sets << 5

      expect(subject.rep_string).to eql('9-5')
    end
  end

  context '1 set' do
    it do
      subject.sets << 7
      expect(subject.rep_string).to eql('7')
    end
  end
end
