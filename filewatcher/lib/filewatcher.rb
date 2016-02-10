require "filewatcher/version"
require_relative 'filewatcher/mylib'

module FileWatcher

  # void method call
  Mylib::foo

  # method that takes arguments and returns integer
  sum = Mylib::add(30, 12)
  print sum

end
