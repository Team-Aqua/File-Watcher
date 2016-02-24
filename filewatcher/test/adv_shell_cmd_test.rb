require "minitest/autorun"
require "filewatcher"
require "filewatcher/adv_cmds"
require "filewatcher/mcontracts"

class AdvShellCMDTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::FileWatcher::VERSION
  end

  def test_sysmgr
    assert_output(/#{FileWatcher::MContracts::ERROR_STRING_NO_ARGS}/) {FileWatcher::AdvCmds::sysmgr("")}
    assert_output(/#{FileWatcher::MContracts::req_arg_string("t")}/) {FileWatcher::AdvCmds::sysmgr("-m'test'")}
    assert_output(/#{FileWatcher::MContracts::req_arg_string("m")}/) {FileWatcher::AdvCmds::sysmgr("-m-t0")}
    assert_output(/#{FileWatcher::MContracts::ERROR_STRING_T_IS_INT}/) {FileWatcher::AdvCmds::sysmgr("-t-m'test'")}
    assert_output(/#{FileWatcher::MContracts::req_arg_string("m")}/) {FileWatcher::AdvCmds::sysmgr("-t'1'")}
    assert_output(/#{FileWatcher::MContracts::ERROR_STRING_T_IS_INT}/) {FileWatcher::AdvCmds::sysmgr("-m'test'-ta")}
    assert_output("") {FileWatcher::AdvCmds::sysmgr("-m'test'-t0")}
    assert_output("") {FileWatcher::AdvCmds::sysmgr("-m'test'-t2")}
    assert_output("") {FileWatcher::AdvCmds::sysmgr("-m'Te$t.'-t11")}
  end

  def test_sysmgr_single
    assert_output(/#{FileWatcher::MContracts::ERROR_STRING_NO_ARGS}/) {FileWatcher::AdvCmds::sysmgr("")}
    assert_output(/#{FileWatcher::MContracts::req_arg_string("t")}/) {FileWatcher::AdvCmds::sysmgr("-m'test'")}
    assert_output(/#{FileWatcher::MContracts::req_arg_string("m")}/) {FileWatcher::AdvCmds::sysmgr("-m-t0")}
    assert_output(/#{FileWatcher::MContracts::ERROR_STRING_T_IS_INT}/) {FileWatcher::AdvCmds::sysmgr("-t-m'test'")}
    assert_output(/#{FileWatcher::MContracts::req_arg_string("m")}/) {FileWatcher::AdvCmds::sysmgr("-t'1'")}
    assert_output(/#{FileWatcher::MContracts::ERROR_STRING_T_IS_INT}/) {FileWatcher::AdvCmds::sysmgr("-m'test'-ta")}
    assert_output("") {FileWatcher::AdvCmds::sysmgr("-m'test'-t0")}
    assert_output("") {FileWatcher::AdvCmds::sysmgr("-m'test'-t2")}
    assert_output("") {FileWatcher::AdvCmds::sysmgr("-m'Te$t.'-t11")}
  end

  def test_filewatch
    # assert_output(/#{FileWatcher::MContracts::ERROR_STRING_FILEWATCH_MODE_ARGS}/) {FileWatcher::AdvCmds::filewatch("-m")}
    assert_output(/#{FileWatcher::MContracts::ERROR_STRING_T_IS_INT}/) {FileWatcher::AdvCmds::filewatch("-mcreate-f'lal.txt'-ta")}
    # assert_output("") {FileWatcher::AdvCmds::filewatch("-mcreate-f\"newFile.txt\"-t20-a' delfile'")}
    # assert_output("") {FileWatcher::AdvCmds::filewatch("-mcreate-f\"newFile.txt\"-t20")}

    assert_output("") {FileWatcher::AdvCmds::filewatch("-mcreate-f'newFile.txt'-t0-a' help'")}
    assert_output("") {FileWatcher::AdvCmds::filewatch("-mcreate-f'newFile.txt'-t0-a' ls'")}
    assert_output("") {FileWatcher::AdvCmds::filewatch("-mcreate-f'newFile.txt'-t0-a' getdir'")}
    assert_output("") {FileWatcher::AdvCmds::filewatch("-mcreate-f'newFile.txt'-t0-a' sysmgr'")}
    assert_output("") {FileWatcher::AdvCmds::filewatch("-mcreate-f'newFile.txt'-t0-a' newfile'")}
    assert_output("") {FileWatcher::AdvCmds::filewatch("-mcreate-f'newFile.txt'-t0-a' delfile'")}
    assert_output("") {FileWatcher::AdvCmds::filewatch("-mcreate-f'newFile.txt'-t0-a' strprint'")}
    assert_output(/Sub command: histfn is not allowed./) {FileWatcher::AdvCmds::filewatch("-mcreate-f'newFile.txt'-t0-a'histfn 2'")}    

  end

  def test_getdir
    # assert_output(/No arguments provided/) {FileWatcher::AdvCmds::getdir("")}
  end
end




















