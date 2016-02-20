require "minitest/autorun"
require "filewatcher"
require "filewatcher/basic_cmds"


class BasicShellCMDTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::FileWatcher::VERSION
  end

  # test ls, cd, quit
  # there's got to be a better way...
  def test_ls
    assert_output("") {FileWatcher::BasicCmds::ls(nil)}
  end

  def test_cd
    assert_output("") {FileWatcher::BasicCmds::cd('..')}
    assert_output("") {FileWatcher::BasicCmds::ls(nil)}
  end

  def test_quit
    # assert_output("") {FileWatcher::BasicCmds::quit(nil)}
  end

end