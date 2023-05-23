BUILD_DIR=build
SOURCE_DIR=SpaceCadetPinball
include $(N64_INST)/include/n64.mk
include libs/sdl_n64/SDL2/Makefile_sdl2.mk

N64_CXXFLAGS += -std=c++11 

all: pinball.z64

SOURCES		:=	SpaceCadetPinball
CPPFILES	:=	$(foreach dir,$(SOURCES),$(notdir $(wildcard $(dir)/*.cpp)))
CFILES  := $(C_SDL_FILES)
OBJS		:=	$(patsubst %.cpp,$(BUILD_DIR)/%.o,$(CPPFILES))	$(CFILES:%.c=%.o)

$(BUILD_DIR)/pinball.elf: $(OBJS)

$(BUILD_DIR)/pinball.dfs: $(wildcard filesystem/*)
	$(N64_MKDFS) $@ filesystem

pinball.z64: N64_ROM_TITLE="spacecadet"
pinball.z64: $(BUILD_DIR)/pinball.dfs

clean:
	rm -rf $(BUILD_DIR) pinball.z64

-include $(wildcard $(BUILD_DIR)/*.d)

.PHONY: all clean