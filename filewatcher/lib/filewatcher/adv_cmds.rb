require "contracts"
require "filewatcher/mcontracts"
require "filewatcher/static_regex"
require "filewatcher/pre_contracts"

module FileWatcher
  module AdvCmds
    include Contracts::Core
    C = Contracts

    Contract.override_failure_callback do |data|
      # Stop Exception Failures
      # puts Contract.failure_msg(data)
    end

      def self.filewatcher_whitelist_commands(cmd)
        whitelist_commands = {
          :help => true,
          :ls => true,
          :cd => false,
          :quit =>  false,
          :filewatch => false,
          :histfn => false,
          :getdir => true,
          :sysmgr => true,
          :newfile => true,
          :delfile => true,
          :strprint => true
        }
        return whitelist_commands[cmd.to_sym]
      end


    # Contract C::And[MContracts::NilArgs, MContracts::Arg_m, MContracts::Arg_t] => C::Any
    def self.sysmgr(args)
      if !MContracts::argument_validation(args, PreContracts::getContract(:sysmgr)) then return end

      args = args.gsub(StaticRegex::WHITESPACE_OMIT_CONTENT, "")
      message = StaticRegex::MESSAGE_ARG_QUOTES_CONTAIN_ANY.match(args)[1].gsub(StaticRegex::FIND_QUOTES, "")
      time = StaticRegex::TIME_ARG_INTEGER.match(args)[1]
      Mylib::sysmgr(message, time.to_i)
    end

    # Contract MContracts::NilArgs => C::Any
    # design: getdir requests no arguments
    def self.getdir(args)
      Mylib::getdir()
    end

    Contract C::And[MContracts::NilArgs, MContracts::Arg_watch_mode, MContracts::Arg_file, MContracts::Arg_t, MContracts::Arg_action] => C::Any
    def self.filewatch(args)
      command, sub_args = ""

      # extract fn, name, dur from command
      args = args.gsub(StaticRegex::WHITESPACE_OMIT_CONTENT, "") 
      watch_mode = StaticRegex::WATCH_MODE_ARG.match(args)[1]

      file_names = StaticRegex::FILENAME_ARG_ANY.match(args)[1]
      # file_name = StaticRegex::CONTENT_BETWEEN_QUOTES.match(file_names)[2]

      time = StaticRegex::TIME_ARG_INTEGER.match(args)[1]
      if StaticRegex::ACTION_ARG_ANY.match(args)
        action = StaticRegex::ACTION_ARG_ANY.match(args)[1]
        command, sub_args = action.split("-", 2)
        if sub_args != nil
          sub_args.prepend("-")
        end
        if !filewatcher_whitelist_commands(command)
          puts "Sub command: #{command} is not allowed."
          return
        end
        # puts command
        # puts sub_args
        if !MContracts::argument_validation(sub_args,PreContracts::getContract(command.to_sym))
          puts "subcommand #{command} Arguments: #{sub_args} are not valid"
          return
        end
      end

      # extract each filename
      # right now we split by space - rework later
      # broken because of regex
      filenames = file_names.split(" ");
      for name in filenames
        Mylib::filewatch(watch_mode, name, time.to_i, command, sub_args)
        sleep 0.15
      end
    end
    
  end
end