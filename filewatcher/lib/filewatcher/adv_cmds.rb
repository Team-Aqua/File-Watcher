require "filewatcher/exceptions"
require "contracts"
require "filewatcher/mcontracts"

module FileWatcher
  module AdvCmds
    include Contracts::Core
    C = Contracts

    Contract.override_failure_callback do |data|
      # Stop Exception Failures
      # print "Command error: "
      # puts Contract.failure_msg(data)
    end

    Contract C::And[MContracts::NilArgs, MContracts::Arg_m, MContracts::Arg_t] => C::Any
    def self.sysmgr(args)
      args = args.gsub(/\s+(?=([^"]*"[^"]*")*[^"]*$)/, "") # removes whitespace...? # eg. statement sysmgr -t i love pie -t 2 should return [i love pie]
      message = (/-m('(.*?)'|"(.*?)")/).match(args)[1].gsub(/(')|(")/, "") #returns -m arg quotes removed.
      time = (/-[t](\d+)/).match(args)[1]
      Mylib::sysmgr(message, time.to_i)
    end

    Contract MContracts::NilArgs => C::Any
    def self.getdir(args)
      Mylib::getdir()
    end

    Contract C::And[MContracts::NilArgs, MContracts::Arg_watch_mode, MContracts::Arg_file, MContracts::Arg_t] => C::Any
    def self.filewatch(args)
      # extract fn, name, dur from command
      args = args.gsub(/\s+(?=([^"]*"[^"]*")*[^"]*$)/, "") # eg. statement sysmgr -t i love pie -t 2 should return [i love pie]
      watch_mode = (/-m(alter|create|destroy)($|-)/).match(args)[1]
      file_name = (/-f('|")(.*?\.[a-z0-9]+)('|")/).match(args)[2].gsub(/(')|(")/, "")
      time = (/-[t](\d+)/).match(args)[1]

      Mylib::filewatch(watch_mode, file_name, time.to_i)
    end
    
  end
end