require "minitest/autorun"
require "filewatcher"

class FileWatcherTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::FileWatcher::VERSION
  end

  def test_it_does_something_useful
    assert false
  end

  def test_sysmgr_no_args
    assert_output(/No arguments provided/) {AdvCmds::sysmgr("")}
  end
end