require 'filewatcher/mylib'
require "contracts"
require "filewatcher/mcontracts"

module FileWatcher
  module BasicCmds
    include Contracts::Core
    C = Contracts

    Contract.override_failure_callback do |data|
      # Stop Exception Failures
      # puts Contract.failure_msg(data)
    end

    def self.ls(args)
      Mylib::ls
    end 

    Contract MContracts::NilArgs => C::Any
    def self.cd(args)
      Mylib::cd(args)
    end

    Contract MContracts::Arg_m => C::Any
    def self.strprint(args)
      args = args.gsub(StaticRegex::WHITESPACE_OMIT_CONTENT, "")
      message = StaticRegex::MESSAGE_ARG_QUOTES_CONTAIN_ANY.match(args)[1].gsub(StaticRegex::FIND_QUOTES, "")
      Mylib::strprint(message)
    end

    Contract MContracts::Arg_file => C::Any
    def self.newfile(args)
      args = args.gsub(StaticRegex::WHITESPACE_OMIT_CONTENT, "") 
      file_name = StaticRegex::FILENAME_ARG_ANY.match(args)[1]
      file_name = StaticRegex::CONTENT_BETWEEN_QUOTES.match(file_name)[2]
      filenames = file_name.split(" ");
      for name in filenames
        Mylib::newfile(name)
        sleep 0.15
      end
    end

    Contract MContracts::Arg_file => C::Any
    def self.delfile(args)
      args = args.gsub(StaticRegex::WHITESPACE_OMIT_CONTENT, "") 
      file_name = StaticRegex::FILENAME_ARG_ANY.match(args)[1]
      file_name = StaticRegex::CONTENT_BETWEEN_QUOTES.match(file_name)[2]
      filenames = file_name.split(" ");
      for name in filenames
        Mylib::delfile(name)
        sleep 0.15
      end
    end

    def self.quit(args)
      # ANY OTHER TEARDOWN REQUIRE
      ## KILL ALL PROCESSES
      abort("+-------------------+\n Exiting FileWatcher\n+-------------------+")
    end

  end
end