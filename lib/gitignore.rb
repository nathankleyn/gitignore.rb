require 'gitignore/rust'

class GitIgnore
  def initialize(path)
    @path = path
  end

  def included_files
    GitIgnoreRust::included_files(@path).to_a
  end
end
