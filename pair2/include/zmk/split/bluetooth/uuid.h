/*
 * Shadow of ZMK's split UUID header for the second LiNEA40.
 *
 * The include path for pair 2 builds lists this directory first. Files that
 * include <zmk/split/bluetooth/uuid.h> get this wrapper, then the original.
 *
 * 0x00000000 is the default service. 0x00000001 through 0x00000006 are ZMK
 * characteristic IDs. 0x00000040 stays clear of both. A third pair would use
 * another free value, such as 0x00000041.
 */

#pragma once

#define LINEA40_SPLIT_UUID_OVERRIDE 1

#include_next <zmk/split/bluetooth/uuid.h>

#undef ZMK_SPLIT_BT_SERVICE_UUID
#define ZMK_SPLIT_BT_SERVICE_UUID ZMK_BT_SPLIT_UUID(0x00000040)
