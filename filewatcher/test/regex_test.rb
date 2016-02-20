require "minitest/autorun"
require "filewatcher/static_regex"

class RegexTest < Minitest::Test

  def test_regex_time_arg_any 
    assert(true, StaticRegex::matcher(StaticRegex::TIME_ARG_ANY, "-t2") )
  end
end