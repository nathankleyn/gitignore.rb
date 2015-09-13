#![feature(cstr_to_str)]
#![feature(cstr_memory)]

extern crate gitignore;
extern crate libc;

use std::ffi::CStr;
use std::ffi::CString;
use std::mem;
use std::path::Path;

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
    let path_cstr = unsafe { CStr::from_ptr(path_ptr) };
    let path_and_str = path_cstr.to_str().unwrap();
    let path = Path::new(path_and_str).to_path_buf();

    let gitignore_path = path.join(".gitignore");
    let file = gitignore::File::new(&gitignore_path).unwrap();

    RubyArray::from_vec(file.included_files().unwrap().iter().map(|f|
        CString::new(f.to_str().unwrap()).unwrap().into_raw()
    ).collect())
}
