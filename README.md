# bodybuilding_com_log

Uses http://www.bodybuilding.com/fun/printlog.php to build a workout sheet with JSON

## Development

### Installation

```bash
$ git clone https://github.com/otternq/bodybuilding_com_log.git ~/src/bodybuilding_com_log
$ cd ~/src/bodybuilding_com_log
$ bundle install
```

## Usage Example

Make an example file: `$ vim bin/example.rb`

Here is some example code (included in repo)
```ruby
require_relative '../lib/log'

workout = Workout.new

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

puts workout.pdf_url
```

Sample Run with Output
```bash
$ ruby bin/example.rb
http://www.bodybuilding.com/fun/printlog2.php?firstname=&name=&num_exercises=2&Exercise[]=Bench%20Press&Sets[]=2&Exercise[]=Incline%20Bench%20Press&Sets[]=3&mood=yes
```
