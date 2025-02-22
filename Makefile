SRC_DIR := src/
OBJ_DIR := obj/
RTL_DIR := schemas/
TESTBENCH_DIR := testbench/

VFLAGS := -g2012

SRC_FILES := multiplexing/mux.v multiplexing/dmux.v \
						 boolean/p_and.v boolean/p_or.v boolean/p_nand.v boolean/p_xor.v \
						 alu.v

TESTBENCH_FILES := $(SRC_FILES:.v=.tb.v)

SRC := $(addprefix $(SRC_DIR), $(SRC_FILES))
TESTBENCH := $(addprefix $(SRC_DIR), $(TESTBENCH_FILES))
OBJS := $(SRC_FILES:%.v=$(OBJ_DIR)%.vvp)
TESTBENCH_OBJS := $(TESTBENCH_FILES:%.v=$(TESTBENCH_DIR)%.vvp)
VCDS = $(TESTBENCH_FILES:%.v=$(TESTBENCH_DIR)%.vcd)
JSON_RTLS := $(SRC_FILES:%.v=$(RTL_DIR)%.json)
RTLS := $(JSON_RTLS:.json=.svg)

all: $(OBJS)

docs: $(RTLS)

run_testbench: $(VCDS)

$(VCDS): $(TESTBENCH_DIR)%.vcd : $(TESTBENCH_DIR)%.vvp
	@mkdir -p testbench_results
	(cd testbench_results && vvp ../$<)

testbench: $(TESTBENCH_OBJS)

$(RTL_DIR)%.json: $(SRC_DIR)%.v
	yosys -q -p "read_verilog $<; hierarchy -check; proc; opt; write_json $@"
	yosys -q -p "read_verilog $<; synth; write_json $@"

$(RTL_DIR)%.svg: $(RTL_DIR)%.json
	netlistsvg $< -o $@

$(OBJ_DIR)%.vvp: $(SRC_DIR)%.v
	iverilog $(VFLAGS) -o $@ $<

$(TESTBENCH_DIR)%.tb.vvp: $(SRC_DIR)%.tb.v
	iverilog $(VFLAGS) -o $@ $<

clean:
	rm -rf $(OBJ_DIR)**/*.vvp
	rm -rf $(TESTBENCH_DIR)**/*.vvp
	rm -rf $(TESTBENCH_DIR)*.vvp
	rm -rf $(RTL_DIR)**/*.svg
	rm -rf $(TESTBENCH_DIR)**/*.vcd
	rm -rf testbench_results/**/*.vcd
	rm -rf testbench_results/*.vcd

re: clean all

.PHONY: all docs testbench clean re
