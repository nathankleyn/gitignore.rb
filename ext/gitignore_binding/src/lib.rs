extern crate gitignore;
extern crate libc;

use std::ffi::CStr;
use std::ffi::CString;
use std::mem;
use std::path::{Path, PathBuf};
use std::string::FromUtf8Error;

#[repr(C)]
pub struct RubyArray {
      len: libc::size_t,
      data: *const libc::c_void,
}

impl RubyArray {
    fn from_vec<T>(vec: Vec<T>) -> RubyArray {
        let array = RubyArray {
            data: vec.as_ptr() as *const libc::c_void,
            len: vec.len() as libc::size_t
        };
        mem::forget(vec);
        array
    }
}

#[no_mangle]
pub extern "C" fn included_files(path_ptr: *const libc::c_char) -> RubyArray {
    let path_string = ptr_to_string(path_ptr).unwrap();
    let path = Path::new(&*path_string).to_path_buf();

    let gitignore_path = path.join(".gitignore");
    let file = gitignore::File::new(&gitignore_path).unwrap();

    let files = file.included_files().unwrap();
    println!("{:?}", files);
    RubyArray::from_vec(paths_to_ptrs(files))
}

fn ptr_to_string(ptr: *const libc::c_char) -> Result<String, FromUtf8Error> {
    let cstr = unsafe { CStr::from_ptr(ptr) };
    let mut bytes = Vec::new();
    bytes.extend(cstr.to_bytes());

    String::from_utf8(bytes)
}

fn paths_to_ptrs(paths: Vec<PathBuf>) -> Vec<*const libc::c_char> {
    paths.iter().flat_map(|p| p.to_str())
                .flat_map(|s| CString::new(s))
                .map(|cs| cs.as_ptr())
                .collect()
}
