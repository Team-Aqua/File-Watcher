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
      args = args.gsub(/\s+/, "")

      arg1 = (/-[m]([a-zA-Z]+)/).match(args)[1]
      arg2 = (/-[t](\d+)/).match(args)[1]

      if ! (arg2 =~ /\A[-+]?[0-9]+\z/)
        puts "-t argument not numeric"
        return false
      end

      Mylib::sysmgr(arg1, arg2.to_i)
    end

    def self.filewatch(args)
      # extract fn, name, dur from command



      Mylib::filewatch(fn, name, dur.to_i)
    end
    
  end
end