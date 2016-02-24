require "minitest/autorun"
require "filewatcher"
require "filewatcher/mcontracts"

class MContractsTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::FileWatcher::VERSION
  end

  def test_argument_validation
    assert FileWatcher::MContracts::argument_validation("-m\"lala\"",[FileWatcher::MContracts::Arg_m])
    assert FileWatcher::MContracts::argument_validation("-m\"lala\"-t2",[FileWatcher::MContracts::Arg_m, FileWatcher::MContracts::Arg_t])
    assert !FileWatcher::MContracts::argument_validation("-m\"lala\"-ta",[FileWatcher::MContracts::Arg_m, FileWatcher::MContracts::Arg_t])
  end
end




















