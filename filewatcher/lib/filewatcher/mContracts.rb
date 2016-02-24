require "filewatcher/static_regex"
module FileWatcher
  module MContracts
    ERROR_STRING_NO_ARGS = "No arguments provided"
    ERROR_STRING_T_IS_INT = "-t Argument must be a positive integer"
    ERROR_STRING_FILEWATCH_MODE_ARGS =  "Requires mode argument: -m [create, alter, destroy]"
    ERROR_STRING_HELP_DETAILS = "Type 'help' for commands"


    # Contract C::Any,C::ArrayOf[] => C::Bool
    def self.argument_validation(args, contracts)
      contracts.each do | contract |
        if !contract.valid? args
          return false
        end
      end
      return true
    end


    def self.req_arg_string(arg)
      return "Requires -#{arg} argument. #{ERROR_STRING_HELP_DETAILS}"
    end

    class IsContract
      def self.valid? args
        args.method_defined? :valid?
      end
    end

    class NilArgs
      def self.valid? args
        if args == nil or args == ""
          puts MContracts::ERROR_STRING_NO_ARGS
          return false
        end
        return true
      end
      def self.to_s
        MContracts::ERROR_STRING_NO_ARGS
      end
    end

    class Arg_m
      def self.valid? args
        args = args.gsub(StaticRegex::ALL_WHITESPACE, "")
        if !args.match(StaticRegex::MESSAGE_ARG_QUOTES_CONTAIN_ANY)
          puts MContracts::req_arg_string("m")
          return false
        end
        return true
      end
      def self.to_s
        MContracts::req_arg_string("m")
      end
    end

    class Arg_t
      def self.valid? args
        args = args.gsub(StaticRegex::ALL_WHITESPACE, "") 
        if !args.match(StaticRegex::TIME_ARG_ANY) 
          puts MContracts::req_arg_string("t")
          return false
        end
        if !args.match(/-t(\d+)($|-)/) # Verify Positive integer with no trailing characters
          puts MContracts::ERROR_STRING_T_IS_INT
          return false
        end

        return true
      end
      def self.to_s
        MContracts::req_arg_string("m")
      end
    end

    class Arg_file
      def self.valid? args
        args = args.gsub(StaticRegex::WHITESPACE_OMIT_BRACKET_WHITESPACE_CONTENT, "") 

        if !args.match(StaticRegex::FILENAME_ARG_ANY)
          puts MContracts::req_arg_string("f")
          return false
        end
        f_arg = StaticRegex::FILENAME_ARG_ANY.match(args)[1]
        # f_arg = StaticRegex::CONTENT_BETWEEN_QUOTES.match(f_arg)[1]
        
        f_args = f_arg.split(" ")
        f_args.each do | filename | 
          if !filename.match(StaticRegex::VALID_FILENAME)
            puts "#{filename} invalid filename. #{ERROR_STRING_HELP_DETAILS}"
            return false
          end
        end
        
        # if !args.match(StaticRegex::FILENAME_ARG_VALID) # Ensure
        #   puts "Invalid filename: example 'filename.xx' "
        #   return false
        # end
        return true
      end
      def self.to_s
        "TODO"
      end
    end

    class Arg_watch_mode
      def self.valid? args
        args = args.gsub(StaticRegex::ALL_WHITESPACE, "") 
        if !args.match(StaticRegex::WATCH_MODE_ARG)
          puts MContracts::ERROR_STRING_FILEWATCH_MODE_ARGS
          return false
        end
        return true
      end
      def self.to_s
        "TODO"
      end
    end

    class Arg_action
      def self.valid? args
        return true
      end
      def self.to_s
        "TODO"
      end
    end

    ## TEMPLATE
    # class CLASS
    #   def self.valid? args
    #     args = args.gsub(StaticRegex::ALL_WHITESPACE, "") 
    #     if CONDITION
    #       puts ""
    #       return false
    #     end
    #     return true
    #   end
    #   def self.to_s
    #     "TODO"
    #   end
    # end


  end
end