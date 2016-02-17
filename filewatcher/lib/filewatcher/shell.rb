require 'filewatcher/mylib'

module FileWatcher
  class Shell
    include Mylib
    # Can discuss threading this portion later
    def initialize
      @prompt = "\n> "
      @command_queue = []
      # @reports_queue = []
      @valid_commands = { :help => lambda { Mylib::help },
                          :ls => lambda { Mylib::ls }, 
                          :cd => lambda { Mylib.cd }, 
                          :filewatch => lambda { Mylib::filewatch }, 
                          :sysmgr => lambda { Mylib::sysmgr },
                          :quit =>  lambda { self.quit } }

      # Initialize Low Level Parental C process
    end

    def cd
      puts "EXECUTING CD"
    end

    def quit
      # ANY OTHER TEARDOWN REQUIRE
      ## KILL ALL PROCESSES
      abort("Closing Shell")
    end

    def receive_command
      print "#{@prompt}"
      command = gets.chomp

      if @valid_commands.has_key?(command.to_sym)
        @command_queue.insert(0, command)
      else
        puts "Command not found: #{command}"
      end
    end

    def process_command
      if !@command_queue.empty?
        command = @command_queue.pop
        puts "Processing Command: #{command}"

        @valid_commands[command.to_sym].call()

        # @reports_queue.insert(0, "A Sample Report")
      end
    end

    # def report
    #   if !@reports_queue.empty?
    #     puts "Report: #{@reports_queue.pop}"
    #   end
    # end

    def run
      while true
        receive_command
        process_command
        # report
        sleep(0.25)
      end
    end

  end
end