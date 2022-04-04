require 'active_record'

class Todo < ActiveRecord::Base
  def due_today?
    due_date == Date.today
  end

  def to_displayable_string
    display_status = completed ? "[x]" : "[ ]"
    display_date = due_today? ? nil : due_date
    "#{id}. #{display_status} #{todo_text} #{display_date}"
  end

  def self.to_displayable_list
    all.map {|todo| todo.to_displayable_string }
  end

  def self.add_task args
    Todo.create(todo_text: args[:todo_text], due_date: Date.today + args[:due_in_days], completed: false)
  end

  def self.mark_as_complete todo_id
    todo = Todo.find(todo_id)
    todo.update(completed: true) if todo.present?
    return todo
  end

  def self.show_list
    overdue = Todo.where(["due_date < ?", Date.today])
    due_today = Todo.where(["due_date =?", Date.today])
    due_later = Todo.where(["due_date >?", Date.today])

    puts "My Todo-list\n\n"
  
    puts "Overdue"
    puts overdue.to_displayable_list
    puts "\n\n"
  
    puts "Due Today"
    puts due_today.to_displayable_list
    puts "\n\n"
  
    puts "Due Later"
    puts due_later.to_displayable_list
  end
end