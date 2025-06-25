# Additional clean files
cmake_minimum_required(VERSION 3.16)

if("${CONFIG}" STREQUAL "" OR "${CONFIG}" STREQUAL "Debug")
  file(REMOVE_RECURSE
  "CMakeFiles\\appHexaCircles_autogen.dir\\AutogenUsed.txt"
  "CMakeFiles\\appHexaCircles_autogen.dir\\ParseCache.txt"
  "appHexaCircles_autogen"
  )
endif()
