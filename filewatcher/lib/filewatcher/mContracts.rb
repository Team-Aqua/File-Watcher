require "filewatcher/static_regex"

module MContracts
  class NilArgs
    def self.valid? args
      if args == nil or args == ""
        puts "No arguments provided"
        return false
      end
      return true
    end
    def self.to_s
      "No arguments provided"
    end
  end

  class Arg_m
    def self.valid? args
      args = args.gsub(StaticRegex::ALL_WHITESPACE, "")
      if !args.match(StaticRegex::MESSAGE_ARG_QUOTES_CONTAIN_ANY)
        puts "Requires -m argument"
        return false
      end
      return true
    end
    def self.to_s
      "Requires -m argument"
    end
  end

  class Arg_t
    def self.valid? args
      args = args.gsub(StaticRegex::ALL_WHITESPACE, "") 
      if !args.match(StaticRegex::TIME_ARG_ANY) 
        puts "Requires -t argument"
        return false
      end
      if !args.match(/-t(\d+)($|-)/) # Verify Positive integer with no trailing characters
        puts "-t Argument must be a positive integer"
        return false
      end

      return true
    end
    def self.to_s
      "Requires -t argument"
    end
  end

  class Arg_file
    def self.valid? args
      args = args.gsub(StaticRegex::ALL_WHITESPACE, "") 
      if !args.match(StaticRegex::FILENAME_ARG_ANY)
        puts "Requires -f 'filename.xx' argument"
        return false
      end
      if !args.match(StaticRegex::FILENAME_ARG_VALID) # Ensure
        puts "Invalid filename: example 'filename.xx' "
        return false
      end
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
        puts "Requires mode argument: -m [create, alter, destroy] "
        return false
      end
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



