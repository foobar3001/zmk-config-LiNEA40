if(CONFIG_LINEA40_PAIR2)
  if(NOT TARGET app)
    message(FATAL_ERROR "LiNEA40 pair 2 split UUID override requires the ZMK app target")
  endif()

  # Ahead of zmk/app/include, so <zmk/split/bluetooth/uuid.h> hits the wrapper.
  target_include_directories(app BEFORE PRIVATE ${CMAKE_CURRENT_LIST_DIR}/include)
  target_sources(app PRIVATE ${CMAKE_CURRENT_LIST_DIR}/split_uuid_check.c)
endif()
