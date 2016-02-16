require "filewatcher/version"
require "filewatcher/shell"
require 'filewatcher/mylib'

module FileWatcher
  # # void method call
  Mylib::foo
  
  shell = Shell.new
  shell.run


end
