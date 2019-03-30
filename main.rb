require_relative 'Account.rb'

def print_title
  print " _____________________________\n"
  print "|                             |\n"
  print "|                             |\n"
  print "|                             |\n"
  print "|                             |\n"
  print "|                             |\n"
  print "|    Ruby Console Task List   |\n"
  print "|                             |\n"
  print "|                             |\n"
  print "|                             |\n"
  print "|                             |\n"
  print "|                             |\n"
  print "|                             |\n"
  print "|                             |\n"
  print "|                             |\n"
  print "|      _____       ______     |\n"
  print "|     |Login|     |Create|    |\n"
  print "|      ‾‾‾‾‾       ‾‾‾‾‾‾     |\n" 
  print "|                             |\n"
  print " ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\n"
  print "| Input: "
  gets.chomp.downcase
end


def get_username
  print "| Username: "
  gets.chomp.downcase
end

def get_password
  print "| Password: "
  gets.chomp
end

def get_email
  print "| Email: "
  gets.chomp.downcase
end

def print_tasks(obj_parm)
  tasks = obj_parm.get_task
  print " _______________________________\n"
  print "|     Ruby Console Task List    |\n"
  print "|                               |\n"
  print "|                               |\n"
  print "|_______                        |\n"
  print "| TASKS |                       |\n"
  print "|‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾|\n"
  tasks.each do |k, v|
    print "| #{k}. #{v}\n"
  end

end

def print_completed(obj_parm)
  completed = obj_parm.get_completed
  print "|___________                    |\n"
  print "| COMPLETED |                   |\n"
  print "|‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾|\n"
  completed.each do |k, v|
    print "| #{k}. #{v}\n"
  end
  print "|_______________________________|\n"
end

def print_actions
  print "| Add |    |Delete|    |Complete|\n"
  print " ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\n"
  print "| Input(add/del/comp/exit): " 
  input = gets.chomp.downcase
end

def create_interface(obj_parm)
  print_tasks(obj_parm)
  print_completed(obj_parm)
  user_action = print_actions
end


def print_add_task(obj_parm)
  print "| Enter Task: "
  val_to_add = gets.chomp
  obj_parm.add_task(val_to_add)

  puts "added" 
end

def print_del_task(obj_parm)
  print "| <Type the task # to delete>\n"
  print "| Delete Task: "
  val_to_del = gets.chomp
  obj_parm.del_task(val_to_del.to_i)
  puts "deleted"
end

def print_comp_task(obj_parm)
  print "| <type the task # that was completed>\n"
  print "| Completed: "
  val_to_move = gets.chomp
  puts obj_parm.move_task(val_to_move)
  puts "moved"
end

def main(args)
  if args == "prod"
    choice = print_title
    if choice == "login"
      #get input
      username = get_username
      password = get_password
      #get acc info
      user_obj = Account.new(username, password, "default")
      user_obj.login(username, password)
      #show tasks & completed list
      #print_tasks(user_obj)
      #print_completed(user_obj)
      #show actions
      @logoff = false
      while @logoff == false
        task_action = create_interface(user_obj) #returns add, delete, complete
        case task_action
          when "add"
            print_add_task(user_obj)
          when "del"
            print_del_task(user_obj)
          when "comp"
            print_comp_task(user_obj)
          when "exit"
            print "C u l8r\n"
            @logoff = true
          else 
            puts "\n#{task_action} is not an option, try again!\n"
        end
      
      if @logoff == true
        exit
      end

      end

    elsif choice == "create"
      #get input
      username = get_username
      password = get_password
      email = get_email
      #create account
      user_obj = Account.new(username, password, email)
      user_obj.create
      
       @logoff = false
      while @logoff == false
        task_action = create_interface(user_obj) #returns add, delete, complete
        case task_action
          when "add"
            print_add_task(user_obj)
          when "del"
            print_del_task(user_obj)
          when "comp"
            print_comp_task(user_obj)
          when "exit"
            print "C u l8r\n"
            @logoff = true
          else 
            puts "\n#{task_action} is not an option, try again!\n"
        end
      
        if @logoff == true
          exit
        end
      end


    end

  elsif args == "dev"
    #create an acc object
    user = Account.new("test","test123","test@gmail.com")

    #write account file, will overwrite account if not commented out
    user.write_user

    #add a task
    user.add_task("Go shopping") #this is added a a blank list due to 
    user.add_task("delete this") #this is deleted 
    user.add_task("Move me") #this is moved to the completed list

    #deletes the 2nd key/val pair inside the task_list
    user.del_task(2)

    #'moves' a specified task from task_list to completed_list
    user.move_task("Move me")
    user.add_task("newly added baby!")
    #print tasks 
 
    

   

    
  end
end
#mode = "dev"
mode = "prod"
main(mode)

