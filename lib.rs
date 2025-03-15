use std::ffi::c_int;

#[no_mangle]
pub unsafe extern "C" fn rust_main() -> c_int
{
    println!("Hello!");
    0
}
