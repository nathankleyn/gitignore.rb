require 'ffi'

# Wraps up the FFI bindings to the Rust lib. This exposes the functions we have
# in the Rust library itself and any requisite structs we use.
module GitIgnoreRust
  extend FFI::Library

  ffi_lib File.expand_path(File.join(__dir__, '../../ext/gitignore_binding/target/release/libgitignore_binding.dylib'))

  # Struct used to describe a Ruby Array of Strings being passed from Rust.
  class StringArray < FFI::Struct
    layout :len, :size_t, # dynamic array layout
           :data, :pointer

    def to_a
      self[:data].get_array_of_string(0, self[:len]).compact
    end
  end

  attach_function :included_files, [:string], StringArray.by_value
end
