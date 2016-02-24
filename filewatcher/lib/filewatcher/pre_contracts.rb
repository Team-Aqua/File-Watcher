module FileWatcher
  module PreContracts
    @commands_pre_contracts = { 
      :help =>  [],
      :ls => [], 
      :cd => [MContracts::NilArgs], 
      :quit => [],
      :filewatch => [MContracts::NilArgs, MContracts::Arg_watch_mode, MContracts::Arg_file, MContracts::Arg_t], 
      :histfn =>  [],
      :getdir =>  [],
      :sysmgr =>  [FileWatcher::MContracts::NilArgs, FileWatcher::MContracts::Arg_m, FileWatcher::MContracts::Arg_t],
      :newfile =>  [MContracts::NilArgs, MContracts::Arg_file],
      :delfile =>  [MContracts::NilArgs, MContracts::Arg_file],
      :strprint => [MContracts::NilArgs, MContracts::Arg_m]
    }

    def self.getContract(symbol)
      @commands_pre_contracts[symbol]
    end

  end
end