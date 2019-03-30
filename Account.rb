class Account
  
  def initialize(username,password, email)
    @username = username
    @password = password
    @email = email
    @task_list = Hash.new
    @completed_list = Hash.new
    @data = [@username, @password, @email, @task_list, @completed_list]
  end

  #call to create a new user, or to re-write/update as a string
  def write_user
    File.open("#{@username}.txt", "w") do |user_file|     
      user_file.write(@data.inspect)  
    end
  end

  #reads the account file and returns it as a ruby obj
  def read_user(user_parm)
    File.open("#{user_parm}.txt","r") do |acc_file|
      acc_file.each_line(){ |line| return @data = eval(line)}
    end
  end


  
  def login(user_parm, password_parm)
    successful_log = false
    account_name = user_parm
    #check if file exsits
    if File.exists?("#{user_parm}.txt")
    #get account info 
      account = read_user(user_parm)
      #pasword
      while successful_log == false
        if password_parm == @data[1]
          print "| Login Successful\n"
          successful_log = true
          return @data
        else
          print "\n| Password: "
          password_parm = gets.chomp!
          successful_log = false
        end
      end
    else
      print "#{user_parm} does not exist!"
      exit  
    end
  end

  def create
    #if the username file already exists, just don't write it. 4 now
    if File.exists?("#{@data[0]}.txt") == true
      puts "Username Already taken"
      print "Exiting"
      exit
    else
      write_user
      puts "Account Created!"
      puts "Hello #{@data[0]}"
    end
  end


  #account task list methods
  #
  #
  #
  #
  def add_task(val)
    #task number is the key 
    #prepare to write a for each loop that increments for each task and re-writes the keys on delete,add, move methods. Probably just create its own function
   

    task_num = @data[3].count + 1

    @data[3].store(task_num,val)
    write_user


  end

  def del_task(key)

    @data[3].delete(key)
    write_user
    read_user(@data[0])
    #re-writing keys for task list
    count = 1
    @data[3] = @data[3].transform_keys!.with_index{|k, i| k = (i + 1)}
     
    write_user

  end
  
  #moves a task to the completed list
  def move_task(key)
    key_int = key.to_i # no need to call to_i multiple times
    
    #input checking
    if key_int > @data[3].count
      print "doesnt exist\n"
      return "Error"
    end
    
    task_hash = @data[3]
    completed_hash = @data[4]
    completed_num = completed_hash.count + 1

    completed_hash.store(completed_num, task_hash[key_int])

    del_task(key_int)
    write_user
  end

  #accessor methods
  def get_data
    @data
  end

  def get_task
    @data[3]
  end

  def get_completed
    @data[4]
  end

end
