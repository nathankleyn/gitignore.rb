require 'gitignore_rb/rust'

# Represents a `.gitignore` file and the operations one can perform on or with
# them.
#
# This class will take the `.gitignore` file given, parse the rules contained
# within it, and provides a set of functions to apply these rules in various
# useful ways.
class GitIgnoreRb
  def initialize(path)
    @path = path
  end

  def included_files
    GitIgnoreRust.included_files(@path).to_a
  end
end
