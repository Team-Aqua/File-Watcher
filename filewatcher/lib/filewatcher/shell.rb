require 'filewatcher/mylib'
require 'ffi' # possibly useful?

module FileWatcher
  class Shell
    include Mylib

    # Can discuss threading this portion later 
    def initialize
      @prompt = "\n> "
      @command_queue = []
      @valid_commands = { :help => lambda { Mylib::help },
                          :ls => lambda { Mylib::ls }, 
                          :cd => lambda { |arg| self::cd(arg) }, 
                          :filewatch => lambda { |fn, name, dur| self::filewatch(fn, name, dur) }, 
                          :sysmgr => lambda { |arg1, arg2| self::sysmgr(arg1, arg2) },
                          :quit =>  lambda { self.quit } }
    end

    def cd(arg)
      puts arg
      Mylib::cd(arg)
    end

    def sysmgr(arg1, arg2)
      Mylib::sysmgr(arg1, arg2.to_i)
    end

    def filewatch(fn, name, dur)
      Mylib::filewatch(fn, name, dur.to_i)
    end

      
    def quit
      # ANY OTHER TEARDOWN REQUIRE
      ## KILL ALL PROCESSES
      abort("~~~~~~~~~~~~\nExiting FileWatcher\n~~~~~~~~~~~~")
    end

    def receive_command
      print "#{@prompt}"
      command = gets.chomp #.split(" ");
      # grab the first variable

      if @valid_commands.has_key?(command.split(" ").first.to_sym)
        @command_queue.insert(0, command)
      else
        puts "Command not found: #{command}"
      end
    end

    def process_command
      if !@command_queue.empty?
        command = @command_queue.pop
        puts "Processing Command: #{command}"
        case command.split(" ").first
        when "cd"
          @valid_commands[command.split(" ").first.to_sym].call(command.split(" ").last)
        when "sysmgr"
          @valid_commands[command.split(" ").first.to_sym].call(command.split(" ")[1], command.split(" ")[2])
        when "filewatch"
          @valid_commands[command.split(" ").first.to_sym].call(command.split(" ")[1], command.split(" ")[2], command.split(" ")[3])
        else 
          @valid_commands[command.split(" ").first.to_sym].call()
        end
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