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
      puts Contract.failure_msg(data)
    end

    Contract MContracts::NilArgs => C::Any
    def self.sysmgr(args)
      # extract arg1. arg2 from command
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

    def self.filewatch(args)
      # extract fn, name, dur from command



      Mylib::filewatch(fn, name, dur.to_i)
    end
    
  end
end