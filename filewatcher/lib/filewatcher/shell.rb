module FileWatcher
  class Shell
    # Can discuss threading this portion later
    def initialize
      @prompt = "> "
      @command_queue = []
      @reports_queue = []
      @valid_commands = { "ls" => true, "cd" => true, "filewatch" => true }
    end

    def receive_command
      print "#{@prompt}"
      command = gets.chomp
      if @valid_commands.has_key?(command)
        @command_queue.insert(0, command)
      else
        puts "Command not found: #{command}"
      end
    end

    def process_command
      if !@command_queue.empty?
        puts "Processing Command: #{@command_queue.pop}"
        @reports_queue.insert(0, "A Sample Report")
      end
    end

    def report
      if !@reports_queue.empty?
        puts "Report: #{@reports_queue.pop}"
      end
    end

    def run
      # get_command
      # create child/worker process
      # Parent : wait for worker (child) to finish
      # Child: change job
      # Parent: report results
      while true
        receive_command
        process_command
        report
        sleep(0.25)
      end
    end

  end
end