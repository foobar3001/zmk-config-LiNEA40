CONFIG_DIR = config

SRCS_LEFT = $(shell find $(CONFIG_DIR) -type f ! -name "*_right*")
SRCS_RIGHT = $(shell find $(CONFIG_DIR) -type f ! -name "*_left*")

TARGET_LEFT = ../zmk/app/build/left/zephyr/zmk.uf2
TARGET_RIGHT = ../zmk/app/build/right/zephyr/zmk.uf2
TARGET_PAIR2_LEFT = ../zmk/app/build/pair2/left/zephyr/zmk.uf2
TARGET_PAIR2_RIGHT = ../zmk/app/build/pair2/right/zephyr/zmk.uf2

PAIR2_SRCS = $(shell find pair2 zephyr -type f)
# Local docker layout. The config repo must be on ZMK_EXTRA_MODULES so
# CONFIG_LINEA40_PAIR2 can redefine the split service UUID.
PAIR2_MODULES = /workspaces/zmk-config;/workspaces/zmk-modules/zmk-pmw3610-driver;/workspaces/zmk-modules/zmk-rgbled-widget

.PHONY: build build-pair2 clean

build: $(TARGET_LEFT) $(TARGET_RIGHT)

build-pair2: $(TARGET_PAIR2_LEFT) $(TARGET_PAIR2_RIGHT)

#build: $(TARGET_RIGHT)

$(TARGET_LEFT): $(SRCS_LEFT)
	docker exec -w /workspaces/zmk/app -it $(container_name) west build -d build/left -b seeeduino_xiao_ble -- -DSHIELD=LiNEA40_left -DZMK_CONFIG="/workspaces/zmk-config/config"
	docker exec -w /workspaces/zmk/app -it $(container_name) cp build/left/zephyr/zmk.uf2 build/LiNEA40_left.uf2

$(TARGET_RIGHT): $(SRCS_RIGHT)
	docker exec -w /workspaces/zmk/app -it $(container_name) west build -d build/right -b seeeduino_xiao_ble -S studio-rpc-usb-uart -S zmk-usb-logging -- -DSHIELD=LiNEA40_right -DZMK_CONFIG="/workspaces/zmk-config/config" -DZMK_EXTRA_MODULES="/workspaces/zmk-modules/zmk-pmw3610-driver;/workspaces/zmk-modules/zmk-rgbled-widget" -DCONFIG_ZMK_STUDIO=y -DCONFIG_ZMK_STUDIO_LOCKING=n
	docker exec -w /workspaces/zmk/app -it $(container_name) cp build/right/zephyr/zmk.uf2 build/LiNEA40_right.uf2

$(TARGET_PAIR2_LEFT): $(SRCS_LEFT) $(PAIR2_SRCS)
	docker exec -w /workspaces/zmk/app -it $(container_name) west build -d build/pair2/left -b seeeduino_xiao_ble -- -DSHIELD=LiNEA40_left -DZMK_CONFIG="/workspaces/zmk-config/config" -DZMK_EXTRA_MODULES="$(PAIR2_MODULES)" -DCONFIG_LINEA40_PAIR2=y
	docker exec -w /workspaces/zmk/app -it $(container_name) cp build/pair2/left/zephyr/zmk.uf2 build/LiNEA40_pair2_left.uf2

$(TARGET_PAIR2_RIGHT): $(SRCS_RIGHT) $(PAIR2_SRCS)
	docker exec -w /workspaces/zmk/app -it $(container_name) west build -d build/pair2/right -b seeeduino_xiao_ble -S studio-rpc-usb-uart -S zmk-usb-logging -- -DSHIELD=LiNEA40_right -DZMK_CONFIG="/workspaces/zmk-config/config" -DZMK_EXTRA_MODULES="$(PAIR2_MODULES)" -DCONFIG_ZMK_STUDIO=y -DCONFIG_ZMK_STUDIO_LOCKING=n -DCONFIG_LINEA40_PAIR2=y
	docker exec -w /workspaces/zmk/app -it $(container_name) cp build/pair2/right/zephyr/zmk.uf2 build/LiNEA40_pair2_right.uf2

clean:
	docker exec -it $(container_name) rm -rf /workspaces/zmk/app/build
