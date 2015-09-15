require 'gitignore_rb/rust'

# Struct used to describe a Ruby Array of Strings being passed from Rust.
class StringArray < FFI::ManagedStruct
  layout :len, :size_t, # dynamic array layout
         :data, :pointer

  def self.release(ptr)
    GitIgnoreRust.free_array
  end

  def to_a
    self[:data].get_array_of_string(0, self[:len]).clone
  end
end
