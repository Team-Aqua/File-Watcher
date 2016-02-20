require "minitest/autorun"
require "filewatcher/static_regex"

class RegexTest < Minitest::Test

  # TIME_ARG_ANY = /-t(.*?)/
  def test_regex_time_arg_any 
    assert(StaticRegex::matcher(StaticRegex::TIME_ARG_ANY, "-t2") )
    assert(StaticRegex::matcher(StaticRegex::TIME_ARG_ANY, "-t22") )
    assert(StaticRegex::matcher(StaticRegex::TIME_ARG_ANY, "-t0") )
    assert(StaticRegex::matcher(StaticRegex::TIME_ARG_ANY, "-t2123") )
    assert(StaticRegex::matcher(StaticRegex::TIME_ARG_ANY, "-ta2") )
    assert(StaticRegex::matcher(StaticRegex::TIME_ARG_ANY, "-t2a") )
    assert(StaticRegex::matcher(StaticRegex::TIME_ARG_ANY, "-ta") )
    assert(StaticRegex::matcher(StaticRegex::TIME_ARG_ANY, "-t$") )
  end

  # TIME_ARG_INTEGER = /-[t](\d+)$/
  def test_regex_time_arg_integer
    assert(StaticRegex::matcher(StaticRegex::TIME_ARG_INTEGER, "-t2") )
    assert(StaticRegex::matcher(StaticRegex::TIME_ARG_INTEGER, "-t22") )
    assert(StaticRegex::matcher(StaticRegex::TIME_ARG_INTEGER, "-t0") )
    assert(StaticRegex::matcher(StaticRegex::TIME_ARG_INTEGER, "-t2123") )
    assert(!StaticRegex::matcher(StaticRegex::TIME_ARG_INTEGER, "-ta2") )
    assert(!StaticRegex::matcher(StaticRegex::TIME_ARG_INTEGER, "-t2a") )
    assert(!StaticRegex::matcher(StaticRegex::TIME_ARG_INTEGER, "-ta") )
    assert(!StaticRegex::matcher(StaticRegex::TIME_ARG_INTEGER, "-t$") )
  end

  # FILENAME_ARG_ANY = /-f('(.*?)'|"(.*?)")/
  def test_regex_filename_arg_any
    assert(StaticRegex::matcher(StaticRegex::FILENAME_ARG_ANY, "-f\"file1.txt\"") )
    assert(StaticRegex::matcher(StaticRegex::FILENAME_ARG_ANY, "-f'file1.txt'") )
    assert(StaticRegex::matcher(StaticRegex::FILENAME_ARG_ANY, "-f\"file1.txt file2.txt file3.txt\"") )
    assert(StaticRegex::matcher(StaticRegex::FILENAME_ARG_ANY, "-f'file1.txt file2.txt file3.txt'") )
    assert(!StaticRegex::matcher(StaticRegex::FILENAME_ARG_ANY, "-ffile1.txt") )
  end

  # FILENAME_ARG_VALID = /-f('|")([a-zA-Z0-9_-]+\.[a-z0-9]+)('|")/
  def test_regex_filename_arg_valid
    assert(StaticRegex::matcher(StaticRegex::FILENAME_ARG_VALID, "-f\"file1.txt\"") )
    assert(StaticRegex::matcher(StaticRegex::FILENAME_ARG_VALID, "-f\"filename.txt\"") )
    assert(StaticRegex::matcher(StaticRegex::FILENAME_ARG_VALID, "-f\"filename.a\"") )
    assert(StaticRegex::matcher(StaticRegex::FILENAME_ARG_VALID, "-f\"filename.ah\"") )
    assert(StaticRegex::matcher(StaticRegex::FILENAME_ARG_VALID, "-f\"filename.a\"") )
    assert(StaticRegex::matcher(StaticRegex::FILENAME_ARG_VALID, "-f\"filename.7a\"") )
    assert(StaticRegex::matcher(StaticRegex::FILENAME_ARG_VALID, "-f\"filename.a7\"") )
    assert(StaticRegex::matcher(StaticRegex::FILENAME_ARG_VALID, "-f\"file_name.txt\"") )
    assert(StaticRegex::matcher(StaticRegex::FILENAME_ARG_VALID, "-f\"file-name.txt\"") )
    assert(StaticRegex::matcher(StaticRegex::FILENAME_ARG_VALID, "-f\"File-nAme.txt\"") )
    assert(StaticRegex::matcher(StaticRegex::FILENAME_ARG_VALID, "-f\"f23ile-02name01.txt\"") )
    assert(!StaticRegex::matcher(StaticRegex::FILENAME_ARG_VALID, "-f\"filen$ame.a7\"") )
    assert(!StaticRegex::matcher(StaticRegex::FILENAME_ARG_VALID, "-f\"f23ile-02nam'e01.txt\"") )
    assert(!StaticRegex::matcher(StaticRegex::FILENAME_ARG_VALID, "-f\"filename\"") )
    assert(!StaticRegex::matcher(StaticRegex::FILENAME_ARG_VALID, "-f\"filename.\"") )
    assert(!StaticRegex::matcher(StaticRegex::FILENAME_ARG_VALID, "-f\"file#2.txt\"") )

    assert(StaticRegex::matcher(StaticRegex::FILENAME_ARG_VALID, "-f'file1.txt'") )
    assert(StaticRegex::matcher(StaticRegex::FILENAME_ARG_VALID, "-f'filename.txt'") )
    assert(StaticRegex::matcher(StaticRegex::FILENAME_ARG_VALID, "-f'filename.a'") )
    assert(StaticRegex::matcher(StaticRegex::FILENAME_ARG_VALID, "-f'filename.ah'") )
    assert(StaticRegex::matcher(StaticRegex::FILENAME_ARG_VALID, "-f'filename.a'") )
    assert(StaticRegex::matcher(StaticRegex::FILENAME_ARG_VALID, "-f'filename.7a'") )
    assert(StaticRegex::matcher(StaticRegex::FILENAME_ARG_VALID, "-f'filename.a7'") )
    assert(StaticRegex::matcher(StaticRegex::FILENAME_ARG_VALID, "-f'file_name.txt'") )
    assert(StaticRegex::matcher(StaticRegex::FILENAME_ARG_VALID, "-f'file-name.txt'") )
    assert(StaticRegex::matcher(StaticRegex::FILENAME_ARG_VALID, "-f'File-nAme.txt'") )
    assert(StaticRegex::matcher(StaticRegex::FILENAME_ARG_VALID, "-f'f23ile-02name01.txt'") )
    assert(!StaticRegex::matcher(StaticRegex::FILENAME_ARG_VALID, "-f'filen$ame.a7'") )
    assert(!StaticRegex::matcher(StaticRegex::FILENAME_ARG_VALID, "-f'f23ile-02nam'e01.txt'") )
    assert(!StaticRegex::matcher(StaticRegex::FILENAME_ARG_VALID, "-f'filename'") )
    assert(!StaticRegex::matcher(StaticRegex::FILENAME_ARG_VALID, "-f'filename.'") )
    assert(!StaticRegex::matcher(StaticRegex::FILENAME_ARG_VALID, "-f'file#2.txt'") )
  end

  # VALID_FILENAME = /^([a-zA-Z0-9_-]+\.[a-z0-9]+)$/
  def test_regex_valid_filename
    assert(StaticRegex::matcher(StaticRegex::VALID_FILENAME, "file1.txt") )
    assert(StaticRegex::matcher(StaticRegex::VALID_FILENAME, "filename.txt") )
    assert(StaticRegex::matcher(StaticRegex::VALID_FILENAME, "filename.a") )
    assert(StaticRegex::matcher(StaticRegex::VALID_FILENAME, "filename.ah") )
    assert(StaticRegex::matcher(StaticRegex::VALID_FILENAME, "filename.a") )
    assert(StaticRegex::matcher(StaticRegex::VALID_FILENAME, "filename.7a") )
    assert(StaticRegex::matcher(StaticRegex::VALID_FILENAME, "filename.a7") )
    assert(StaticRegex::matcher(StaticRegex::VALID_FILENAME, "file_name.txt") )
    assert(StaticRegex::matcher(StaticRegex::VALID_FILENAME, "file-name.txt") )
    assert(StaticRegex::matcher(StaticRegex::VALID_FILENAME, "File-nAme.txt") )
    assert(StaticRegex::matcher(StaticRegex::VALID_FILENAME, "f23ile-02name01.txt") )
    assert(!StaticRegex::matcher(StaticRegex::VALID_FILENAME, "filen$ame.a7") )
    assert(!StaticRegex::matcher(StaticRegex::VALID_FILENAME, "f23ile-02nam'e01.txt") )
    assert(!StaticRegex::matcher(StaticRegex::VALID_FILENAME, "filename") )
    assert(!StaticRegex::matcher(StaticRegex::VALID_FILENAME, "filename.") )
    assert(!StaticRegex::matcher(StaticRegex::VALID_FILENAME, "file#2.txt") )
  end

  # MESSAGE_ARG_QUOTES_CONTAIN_ANY = /-m('(.*?)'|"(.*?)")/
  def test_regex_message_arg_quotes_contain_any
    assert(StaticRegex::matcher(StaticRegex::MESSAGE_ARG_QUOTES_CONTAIN_ANY, "-m\"file1.txt\"") )
    assert(StaticRegex::matcher(StaticRegex::MESSAGE_ARG_QUOTES_CONTAIN_ANY, "-m\"filename.txt\"") )
    assert(StaticRegex::matcher(StaticRegex::MESSAGE_ARG_QUOTES_CONTAIN_ANY, "-m\"filename.a\"") )
    assert(StaticRegex::matcher(StaticRegex::MESSAGE_ARG_QUOTES_CONTAIN_ANY, "-m\"filename.ah\"") )
    assert(StaticRegex::matcher(StaticRegex::MESSAGE_ARG_QUOTES_CONTAIN_ANY, "-m\"filename.a\"") )
    assert(StaticRegex::matcher(StaticRegex::MESSAGE_ARG_QUOTES_CONTAIN_ANY, "-m\"filename.7a\"") )
    assert(StaticRegex::matcher(StaticRegex::MESSAGE_ARG_QUOTES_CONTAIN_ANY, "-m\"filename.a7\"") )
    assert(StaticRegex::matcher(StaticRegex::MESSAGE_ARG_QUOTES_CONTAIN_ANY, "-m\"file_name.txt\"") )
    assert(StaticRegex::matcher(StaticRegex::MESSAGE_ARG_QUOTES_CONTAIN_ANY, "-m\"file-name.txt\"") )
    assert(StaticRegex::matcher(StaticRegex::MESSAGE_ARG_QUOTES_CONTAIN_ANY, "-m\"File-nAme.txt\"") )
    assert(StaticRegex::matcher(StaticRegex::MESSAGE_ARG_QUOTES_CONTAIN_ANY, "-m\"f23ile-02name01.txt\"") )

    assert(StaticRegex::matcher(StaticRegex::MESSAGE_ARG_QUOTES_CONTAIN_ANY, "-m'file1.txt'") )
    assert(StaticRegex::matcher(StaticRegex::MESSAGE_ARG_QUOTES_CONTAIN_ANY, "-m'filename.txt'") )
    assert(StaticRegex::matcher(StaticRegex::MESSAGE_ARG_QUOTES_CONTAIN_ANY, "-m'filename.a'") )
    assert(StaticRegex::matcher(StaticRegex::MESSAGE_ARG_QUOTES_CONTAIN_ANY, "-m'filename.ah'") )
    assert(StaticRegex::matcher(StaticRegex::MESSAGE_ARG_QUOTES_CONTAIN_ANY, "-m'filename.a'") )
    assert(StaticRegex::matcher(StaticRegex::MESSAGE_ARG_QUOTES_CONTAIN_ANY, "-m'filename.7a'") )
    assert(StaticRegex::matcher(StaticRegex::MESSAGE_ARG_QUOTES_CONTAIN_ANY, "-m'filename.a7'") )
    assert(StaticRegex::matcher(StaticRegex::MESSAGE_ARG_QUOTES_CONTAIN_ANY, "-m'file_name.txt'") )
    assert(StaticRegex::matcher(StaticRegex::MESSAGE_ARG_QUOTES_CONTAIN_ANY, "-m'file-name.txt'") )
    assert(StaticRegex::matcher(StaticRegex::MESSAGE_ARG_QUOTES_CONTAIN_ANY, "-m'File-nAme.txt'") )
    assert(StaticRegex::matcher(StaticRegex::MESSAGE_ARG_QUOTES_CONTAIN_ANY, "-m'f23ile-02name01.txt'") )

    assert(!StaticRegex::matcher(StaticRegex::MESSAGE_ARG_QUOTES_CONTAIN_ANY, "-mfilen$ame.a7") )
  end

  # FIND_QUOTES = /(')|(")/
  def test_regex_find_quotes
    assert(StaticRegex::matcher(StaticRegex::FIND_QUOTES, "'") )
    assert(StaticRegex::matcher(StaticRegex::FIND_QUOTES, "\"") )
    assert(!StaticRegex::matcher(StaticRegex::FIND_QUOTES, "-") )
  end

  # CONTENT_BETWEEN_QUOTES = /('|")(.*?)('|")/
  def test_regex_content_between_quotes
    assert(StaticRegex::matcher(StaticRegex::CONTENT_BETWEEN_QUOTES, "\"-\"") )
    assert(StaticRegex::matcher(StaticRegex::CONTENT_BETWEEN_QUOTES, "'-'") )
    assert(!StaticRegex::matcher(StaticRegex::CONTENT_BETWEEN_QUOTES, "a\"") )
    assert(!StaticRegex::matcher(StaticRegex::CONTENT_BETWEEN_QUOTES, "'a") )
  end

  # WATCH_MODE_ARG = /-m(alter|create|destroy)($|-)/
  def test_regex_content_between_quotes
    assert(StaticRegex::matcher(StaticRegex::WATCH_MODE_ARG, "-mcreate") )
    assert(StaticRegex::matcher(StaticRegex::WATCH_MODE_ARG, "-mdestroy") )
    assert(StaticRegex::matcher(StaticRegex::WATCH_MODE_ARG, "-malter") )
    assert(!StaticRegex::matcher(StaticRegex::WATCH_MODE_ARG, "-mCreate") )
    assert(!StaticRegex::matcher(StaticRegex::WATCH_MODE_ARG, "-mAasd") )
    assert(!StaticRegex::matcher(StaticRegex::WATCH_MODE_ARG, "-masC") )
    assert(!StaticRegex::matcher(StaticRegex::WATCH_MODE_ARG, "-malte") )
    assert(!StaticRegex::matcher(StaticRegex::WATCH_MODE_ARG, "-smalter") )
  end

  # ALL_WHITESPACE = /\s+/
  def test_regex_all_whitespace
    assert(StaticRegex::matcher(StaticRegex::ALL_WHITESPACE, " ") )
    assert(!StaticRegex::matcher(StaticRegex::ALL_WHITESPACE, "-") )
  end

  # WHITESPACE_OMIT_BRACKET_WHITESPACE_CONTENT = /\s+(?=([^']*'[^']*')*[^']*$)/
  def test_regex_omit_single_brackets
    assert(StaticRegex::matcher(StaticRegex::WHITESPACE_OMIT_BRACKET_WHITESPACE_CONTENT, " 'test.txt' ") )
    assert(StaticRegex::matcher(StaticRegex::WHITESPACE_OMIT_BRACKET_WHITESPACE_CONTENT, "-f 'test.txt'") )
    assert(StaticRegex::matcher(StaticRegex::WHITESPACE_OMIT_BRACKET_WHITESPACE_CONTENT, " ") )
    assert(!StaticRegex::matcher(StaticRegex::WHITESPACE_OMIT_BRACKET_WHITESPACE_CONTENT, "-f'test.txt'") )
  end

  # WHITESPACE_OMIT_DOUBLE_BRACKET_WHITESPACE_CONTENT = /\s+(?=([^"]*"[^"]*")*[^"]*$)/
  def test_regex_omit_single_brackets
    assert(StaticRegex::matcher(StaticRegex::WHITESPACE_OMIT_BRACKET_WHITESPACE_CONTENT, " \"test.txt\" ") )
    assert(StaticRegex::matcher(StaticRegex::WHITESPACE_OMIT_BRACKET_WHITESPACE_CONTENT, "-f \"test.txt\"") )
    assert(StaticRegex::matcher(StaticRegex::WHITESPACE_OMIT_BRACKET_WHITESPACE_CONTENT, " ") )
    assert(!StaticRegex::matcher(StaticRegex::WHITESPACE_OMIT_BRACKET_WHITESPACE_CONTENT, "-f\"test.txt\"") )
  end
end