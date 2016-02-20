require "filewatcher/exceptions"
require "contracts"
require "filewatcher/mcontracts"
require "filewatcher/static_regex"

module FileWatcher
  module AdvCmds
    include Contracts::Core
    C = Contracts

    Contract.override_failure_callback do |data|
      # Stop Exception Failures
      # puts Contract.failure_msg(data)
    end

    Contract C::And[MContracts::NilArgs, MContracts::Arg_m, MContracts::Arg_t] => C::Any
    def self.sysmgr(args)
      args = args.gsub(StaticRegex::WHITESPACE_OMIT_BRACKET_WHITESPACE_CONTENT, "")
      message = StaticRegex::MESSAGE_ARG_QUOTES_CONTAIN_ANY.match(args)[1].gsub(StaticRegex::FIND_QUOTES, "")
      time = StaticRegex::TIME_ARG_INTEGER.match(args)[1]
      Mylib::sysmgr(message, time.to_i)
    end

    Contract MContracts::NilArgs => C::Any
    def self.getdir(args)
      Mylib::getdir()
    end

    Contract C::And[MContracts::NilArgs, MContracts::Arg_watch_mode, MContracts::Arg_file, MContracts::Arg_t] => C::Any
    def self.filewatch(args)
      # extract fn, name, dur from command
      args = args.gsub(StaticRegex::WHITESPACE_OMIT_BRACKET_WHITESPACE_CONTENT, "") 
      watch_mode = StaticRegex::WATCH_MODE_ARG.match(args)[1]

      file_name = StaticRegex::FILENAME_ARG_ANY.match(args)[1]
      file_name = StaticRegex::CONTENT_BETWEEN_QUOTES.match(file_name)[2]

      time = StaticRegex::TIME_ARG_INTEGER.match(args)[1]
      # extract each filename
      # right now we split by space - rework later
      # broken because of regex
      filenames = file_name.split(" ");
      for name in filenames
        Mylib::filewatch(watch_mode, name, time.to_i)
      end
    end
    
  end
end