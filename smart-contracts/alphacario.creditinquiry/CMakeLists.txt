cmake_minimum_required(VERSION 3.13.1)

### Generate the wasm and abi
add_contract(creditinquiry creditinquiry src/creditinquiry.cpp )

target_include_directories(creditinquiry.wasm
   PUBLIC
   ${CMAKE_CURRENT_SOURCE_DIR}/include)

### add the path to where the ricardian contracts/clauses are found

target_compile_options(creditinquiry.wasm PUBLIC --std=c++17 -fcolor-diagnostics -R${CMAKE_CURRENT_SOURCE_DIR} )
