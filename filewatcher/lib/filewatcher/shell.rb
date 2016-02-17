require 'ffi' # possibly useful?
require 'shellwords'

module FileWatcher
  class Shell
    # Can discuss threading this portion later 
    def initialize
      @prompt = "\n> "
      @command_queue = []
      @valid_commands = { 
        :help => lambda { |args| Mylib::help },
        :ls => lambda { |args| BasicCmds::ls(args) }, 
        :cd => lambda { |args| BasicCmds::cd(args) }, 
        :quit =>  lambda { |args| BasicCmds::quit(args) },
        :filewatch => lambda { |args| AdvCmds::filewatch(args) }, 
        :sysmgr => lambda { |args| AdvCmds::sysmgr(args) }
      }
    end
      
    def receive_command
      print "#{@prompt}"
      command = gets.chomp
      
      if command == ""
        return false
      end

      if @valid_commands.has_key?(command.split(" ").first.to_sym)
        @command_queue.insert(0, command)
      else
        puts "Command not found: #{command}"
      end
    end

    def process_command
      if !@command_queue.empty?
        command, args = @command_queue.pop.split(" ", 2)
        # puts "Processing Command: #{command}"
        @valid_commands[command.to_sym].call(args)
      end
    end

    def run
      while true
        receive_command
        process_command
        sleep(0.25)
      end
    end

  end
end