module FileWatcher
  module PreContracts
    @commands_pre_contracts = { 
      :help =>  [],
      :ls => [], 
      :cd => [], 
      :quit => [],
      :filewatch => [], 
      :histfn =>  [],
      :getdir =>  [],
      :sysmgr =>  [FileWatcher::MContracts::NilArgs, FileWatcher::MContracts::Arg_m, FileWatcher::MContracts::Arg_t],
      :newfile =>  [],
      :delfile =>  []
    }

    def self.getContract(symbol)
      @commands_pre_contracts[symbol]
    end

  end
end