class FileWatcherTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::FileWatcher::VERSION
  end

  def system_test
    ls
    cd ..
    ls
    getdir
    quit
  end

end
