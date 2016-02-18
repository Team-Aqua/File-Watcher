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
      args = args.gsub(/\s+/, "")
      if !args.match(/-m('(.*?)'|"(.*?)")/)
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
      if !args.include? "-t"
        puts "Requires -t argument"
        return false
      end
      return true
    end
    def self.to_s
      "Requires -t argument"
    end
  end

end



