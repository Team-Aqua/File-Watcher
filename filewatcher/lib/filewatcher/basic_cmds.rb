require 'filewatcher/mylib'
require "contracts"
require "filewatcher/mcontracts"

module FileWatcher
  module BasicCmds
    include Contracts::Core
    C = Contracts

    def self.ls(args)
      Mylib::ls
    end 

    Contract MContracts::NilArgs => C::Any
    def self.cd(args)
      Mylib::cd(args)
    end

    def self.quit(args)
      # ANY OTHER TEARDOWN REQUIRE
      ## KILL ALL PROCESSES
      abort("+-------------------+\n Exiting FileWatcher\n+-------------------+")
    end

  end
end