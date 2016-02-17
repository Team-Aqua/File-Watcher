module MContracts
  class NilArgs
    def self.valid? args
      if args == nil or args == ""
        puts "sysmgr :: Requires Args: -m -t"
        return false
      end
      return true
    end
    def self.to_s
      "No arguments provided"
    end
  end
end



