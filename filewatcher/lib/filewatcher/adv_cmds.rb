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
      args = args.gsub(/\s+(?=([^"]*"[^"]*")*[^"]*$)/, "") 
      arg1 = (/-[m]([a-zA-Z0-9 "]+)/).match(args)[1]
      arg2 = (/-[t](\d+)/).match(args)[1]

      if ! (arg2 =~ /\A[-+]?[0-9]+\z/)
        puts "-t argument not numeric"
        return false
      end

      Mylib::sysmgr(arg1, arg2.to_i)
    end

    def self.filewatch(args)
      # extract fn, name, dur from command
      args = args.gsub(/\s+(?=([^"]*"[^"]*")*[^"]*$)/, "") # eg. statement sysmgr -t i love pie -t 2 should return [i love pie]
      puts args

      if !args.include? "-f"
        puts "sysmgr :: requires -m arg"
        return false
      end

      if !args.include? "-n"
        puts "sysmgr :: requires -n arg"
        return false
      end

      if !args.include? "-t"
        puts "sysmgr :: requires -t arg"
        return false
      end

      fn = (/-[f]([a-zA-Z0-9" ]+)/).match(args)[1]
      name = (/-[n]([a-zA-Z0-9" ]+)/).match(args)[1]
      time = (/-[t](\d+)/).match(args)[1]

      if ! (time =~ /\A[-+]?[0-9]+\z/)
        puts "-t argument not numeric"
        return false
      end
      Mylib::filewatch(fn, name, time.to_i)
    end
    
  end
end