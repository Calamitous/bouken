require 'story_data.rb'

TEXT_WIDTH = 80

def prompted_get
  prompt(":> ")
  gets.chomp
end

def prompt(slug = '')
  slug.each_byte{ |c| putc c }
end

class String
  def wrapped(width = TEXT_WIDTH)
    self.gsub(/.{1,#{width}}(?:\s|\Z|\-)/){($& + 5.chr).gsub(/\n\005/,"\n").gsub(/\005/,"\n")}
  end
end

class Hash
  def description
    self.keys.first
  end

  def options
    self[self.description]
  end
end

def quit_game
  puts 'Bye!  Thanks for playing!'
  exit(0)
end

scene = @story
options = scene.options

until options == :end
  puts "#{scene.description.wrapped}\n\n* Options: #{options.keys.join(', ').wrapped}\n"
  selected_option = prompted_get
  unless options[selected_option]
    quit_game if selected_option == 'quit'
    puts "#{selected_option} is not a valid option!\n"
  else
    scene = options[selected_option]
    options = scene.options
  end
end

puts scene.description.wrapped
puts "The End."
