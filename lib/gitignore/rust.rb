require 'ffi'

module GitIgnoreRust
  extend FFI::Library

  ffi_lib File.expand_path(File.join(__dir__, '../../ext/gitignore_binding/target/release/libgitignore_binding.dylib'))

  class GitIgnoreBindingArray < FFI::Struct
    layout :len, :size_t, # dynamic array layout
           :data, :pointer

    def to_a
      self[:data].get_array_of_string(0, self[:len]).compact
    end
  end

  attach_function :included_files, [:string], GitIgnoreBindingArray.by_value
end
