require 'ffi'

# Wraps up the FFI bindings to the Rust lib. This exposes the functions we have
# in the Rust library itself and any requisite structs we use.
module GitIgnoreRust
  extend FFI::Library

  ffi_lib File.expand_path(File.join(__dir__, '../../ext/gitignore_binding/target/release/libgitignore_binding.dylib'))

  attach_function :included_files, [:string], :pointer
  attach_function :free_array, [:pointer], :void
end
