require 'filewatcher/mylib'

module FileWatcher
  module BasicCmds

    def self.ls(args)
      Mylib::ls
    end 

    def self.cd(args)
      if args == nil or args == ""
        puts "Requires arg"
        return false
      end
      Mylib::cd(args)
    end

    def self.quit(args)
      # ANY OTHER TEARDOWN REQUIRE
      ## KILL ALL PROCESSES
      abort("+-------------------+\n Exiting FileWatcher\n+-------------------+")
    end

  end
end