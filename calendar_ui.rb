require 'bundler/setup'
Bundler.require :default


Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

database_configurations = YAML::load(File.open('./db/config.yml'))
development_configuration = database_configurations['development']
ActiveRecord::Base.establish_connection(development_configuration)

def welcome
  clear
  puts "Welcome to the Ruby Calendar!"
  main_menu
end

def main_menu

  choice = nil
  until choice == 'x'
    puts "\n==== MAIN MENU ===="
    print_options
    choice = prompt('Enter choice')
    case choice
    when 'a'
      add_event
    when 'd'
      delete_event
    when 'l'
      list_events
    when 'e'
      edit_events
    when 'x'
      exit
    else
      clear
      error
    end
  end
end

def print_options
  puts "Press 'A' to Add a New Event",
       "Press 'D' to Delete an Event",
       "Press 'L' to List your Events",
       "Press 'E' to Edit an Event"
end

##==== EVENT OPTIONS ====##
def add_event
  clear
  puts "\n===== DELETE EVENT OPTION ====="
  description = prompt("Enter new event description")
  location = prompt("Enter a location of your event")
  start = prompt("Enter start date and time in YYYY/MM/DD HH:MM")
  end_event = prompt("Enter end date and time in YYYY/MM/DD HH:MM")

  new_event = Event.create({description: description, location: location, start: start, :end => end_event })
    # if new_event.future_check.first == "End time must be before start time"
    #   puts "#{new_event.future_check.first}"
    #   sleep(2)
    #   add_event
    # else
      puts "'#{new_event.description}' at #{new_event.location} has been saved in your calendar"
      main_menu
    # end
end

def delete_event
  puts "\n===== ADD NEW EVENT OPTION ====="
  list_events
  description = prompt("Enter the name of the event to delete it")
  Event.where({ description: description }).first.destroy
  puts "#{description} has been deleted!"
end

def list_events
  Event.all.each do |event|
    puts "#{event.description}: #{event.location}: #{event.start}"
  end
end

def edit_events
  list_events
  description = prompt("Enter the name of the event that you would like to edit")
  current_event = Event.where({ description: description }).first
  puts "#{current_event.description}"
  new_description = prompt("Enter the new description, or press enter to leave unchanged")
  if new_description != ''
    current_event.update({:description => new_description})
  end
  new_location = prompt("Enter the new location, or press enter to leave unchanged")
  if new_location != ''
    current_event.update({:location => new_location})
  end
  new_start = prompt("Enter the new start, or press enter to leave unchanged")
  if new_start != ''
    current_event.update({:start => new_start})
  end
  new_end = prompt("Enter the new end, or press enter to leave unchanged")
  if new_end != ''
    current_event.update({:end => new_end})
  end
  puts "#{current_event.description} has been updated!"
  main_menu
end

##==== OTHERS ====##

def prompt(string)
  print string + " >> "
  gets.chomp.downcase
end

def clear
  system("clear")
end

def error
  puts "\e[5;31m(ಠ_ಠ) INVALID INVALID INVALID!!\e[0;0m"
end

welcome
