SRC_DIR := src/
OBJ_DIR := obj/
RTL_DIR := schemas/

SRC_FILES := main.v \
						 mux/mux.v mux/mux4.v \
						 dmux/dmux.v \
						 and/and3.v and/and4.v and/and8.v and/and16.v \
						 or/or3.v or/or4.v or/or8.v or/or16.v

SRC := $(addprefix $(SRC_DIR), $(SRC_FILES))
OBJS := $(SRC_FILES:%.v=$(OBJ_DIR)%.vvp)
JSON_RTLS := $(SRC_FILES:%.v=$(RTL_DIR)%.json)
RTLS := $(JSON_RTLS:.json=.svg)

all: $(OBJS)

docs: $(RTLS)

$(RTL_DIR)%.json: $(SRC_DIR)%.v
	yosys -q -p "read_verilog $<; hierarchy -check; proc; opt; write_json $@"

$(RTL_DIR)%.svg: $(RTL_DIR)%.json
	netlistsvg $< -o $@

$(OBJ_DIR)%.vvp: $(SRC_DIR)%.v
	iverilog -o $@ $<

clean:
	rm -rf $(OBJ_DIR)**/*.vvp
	rm -rf $(RTL_DIR)**/*.svg

re: clean all
