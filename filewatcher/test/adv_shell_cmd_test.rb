require "minitest/autorun"
require "filewatcher"
require "filewatcher/adv_cmds"

class AdvShellCMDTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::FileWatcher::VERSION
  end

  def test_sysmgr_no_args
    assert_output(/No arguments provided/) {FileWatcher::AdvCmds::sysmgr("")}
  end
end