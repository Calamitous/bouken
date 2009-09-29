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

def quit_game
  puts 'Bye!  Thanks for playing!'
  exit(0)
end

node = @story
node_data = node[node.keys.first]

until node_data == :end
  # puts node_data.inspect, "!!!!!!"
  puts "#{node.keys.first.wrapped}\n\n* Options: #{node_data.keys.join(', ').wrapped}\n"
  new_key = prompted_get
  unless node_data[new_key]
    quit_game if new_key == 'quit'
    puts "#{new_key} is not a valid option!\n"
  else
    node = node_data[new_key]
    node_data = node[node.keys.first]
  end
end

puts node.keys.first.wrapped
puts "The End."

