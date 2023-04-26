#!/bin/bash

#cmake --build build && build/hello_test --gtest_filter=HelloTest.BasicAssertions
#cmake --build build && build/hello_test BasicAssertions
#mkdir -p build
#cd build

# Define variables
BUILD_DIR=build
TEST_BINARY=${BUILD_DIR}
TEST_SUITE=AllTests

# Help function

function help() {
	echo "Usage: $0 [options]"
	echo ""
	echo "Options:"
	#echo "  -b, --build            set the build directory (default: build)"
	echo "  -b, --build            build directory"
  	echo "  -t, --test             run tests"
  	echo "  -s, --suite <suite>    run tests from a specific suite"
  	echo "  -n, --name <name>      run a specific test"
  	echo "  -h, --help             display this help message and exit"
  	echo ""
  	echo "Example usage: ./build.sh -b -t -s HelloTest -n Adding"
  	echo "Command above build code and run specific test (Adding) from testsuite (HelloTest)"
  	echo ""
}

# Parse command line arguments
while [[ $# -gt 0 ]]; do
  case $1 in
  	-h|--help) 
  		help
  		exit 0;;
    -b|--build) BUILD=true;;
    -t|--test) TEST=true;;
    -s|--suite) TEST_SUITE=$2; shift;;
    -n|--name) TEST_NAME=$2; shift;;
    *) echo "Invalid argument: $1"; exit 1;;
  esac
  shift
done

# Build the test binary using CMake
if [ "${BUILD}" = true ]; then
  mkdir -p ${BUILD_DIR}
  cd ${BUILD_DIR}
  cmake ..
  make
  cd ..
fi

# Run all tests or a specific suite/test
if [ "${TEST}" = true ]; then
  if [ -z "${TEST_NAME}" ]; then
  	./build/hello_test
    #./${TEST_BINARY} --gtest_output=xml:${BUILD_DIR}/test_results.xml
  else
  	./build/hello_test --gtest_filter=${TEST_SUITE}.${TEST_NAME}
    #./${TEST_BINARY} --gtest_output=xml:${BUILD_DIR}/test_results.xml --gtest_filter=${TEST_SUITE}.${TEST_NAME}
  fi
fi
