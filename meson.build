project(
    'rust_test',
    ['c', 'rust'],
    version: '0.9.9',
    meson_version: '>=1.3.0',
    default_options: [
        'buildtype=debugoptimized',
        'c_std=c11',
        'rust_std=2021',
        'build.rust_std=2021',
    ],
)

lib_rs = static_library('lib_rs', 'lib.rs', rust_abi: 'c')
executable('rust_test', 'main.c', link_with: lib_rs)
