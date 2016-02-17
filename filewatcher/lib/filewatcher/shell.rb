require 'filewatcher/mylib'
require 'ffi' # possibly useful?
require 'shellwords'

module FileWatcher
  class Shell
    include Mylib

    # Can discuss threading this portion later 
    def initialize
      @prompt = "\n> "
      @command_queue = []
      @valid_commands = { :help => lambda { |args| Mylib::help },
                          :ls => lambda { |args| self::ls(args) }, 
                          :cd => lambda { |args| self::cd(args) }, 
                          :filewatch => lambda { |args| self::filewatch(args) }, 
                          :sysmgr => lambda { |args| self::sysmgr(args) },
                          :quit =>  lambda { |args| self::quit(args) } }
    end

    def ls(args)
      Mylib::ls
    end

    def cd(args)
      if args == nil or args == ""
        puts "Requires arg"
        return false
      end

      puts args
      Mylib::cd(args)
    end

    def sysmgr(args)
      # extract arg1. arg2 from command
      if args == nil
        puts "sysmgr requires args: -m -t"
        return false
      end

      args = args.gsub(/\s+/, "")

      if !args.include? "-m"
        puts "sysmgr :: requires -m arg"
        return false
      end

      if !args.include? "-t"
        puts "sysmgr :: requires -t arg"
        return false
      end

      arg1 = (/-[m]([a-zA-Z]+)/).match(args)[1]
      arg2 = (/-[t](\d+)/).match(args)[1]

      if ! (arg2 =~ /\A[-+]?[0-9]+\z/)
        puts "-t argument not numeric"
        return false
      end

      Mylib::sysmgr(arg1, arg2.to_i)
    end

    def filewatch(args)
      # extract fn, name, dur from command
      Mylib::filewatch(fn, name, dur.to_i)
    end

      
    def quit(args)
      # ANY OTHER TEARDOWN REQUIRE
      ## KILL ALL PROCESSES
      abort("~~~~~~~~~~~~\nExiting FileWatcher\n~~~~~~~~~~~~")
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

        # shellset = command.shellsplit
        # case shellset[0]
        # when "cd"
        #   @valid_commands[shellset[0].to_sym].call(shellset[1])
        # when "sysmgr"
        #   @valid_commands[shellset[0].to_sym].call(shellset[1], shellset[2])
        # when "filewatch"
        #   @valid_commands[shellset[0].to_sym].call(shellset[1], shellset[2], shellset[3])
        # else 
        #   @valid_commands[shellset[0].to_sym].call()
        # end
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