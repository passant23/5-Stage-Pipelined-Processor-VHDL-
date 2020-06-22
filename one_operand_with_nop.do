vsim -gui work.main
# vsim -gui work.main 

mem load -filltype value -filldata 16'b0000010000000000 -fillradix symbolic /main/f0/inst_mem/ram(0)

mem load -filltype value -filldata 16'b0000000000000000 -fillradix symbolic /main/f0/inst_mem/ram(1)

mem load -filltype value -filldata 16'b0000100000000000 -fillradix symbolic /main/f0/inst_mem/ram(2)

mem load -filltype value -filldata 16'b0000110010000000 -fillradix symbolic /main/f0/inst_mem/ram(3)
mem load -filltype value -filldata 16'b0000000000000000 -fillradix symbolic /main/f0/inst_mem/ram(4)
mem load -filltype value -filldata 16'b0000000000000000 -fillradix symbolic /main/f0/inst_mem/ram(5)
mem load -filltype value -filldata 16'b0000000000000000 -fillradix symbolic /main/f0/inst_mem/ram(6)
mem load -filltype value -filldata 16'b0001000010000000 -fillradix symbolic /main/f0/inst_mem/ram(7)
mem load -filltype value -filldata 16'b0000000000000000 -fillradix symbolic /main/f0/inst_mem/ram(8)
mem load -filltype value -filldata 16'b0000000000000000 -fillradix symbolic /main/f0/inst_mem/ram(9)
mem load -filltype value -filldata 16'b0000000000000000 -fillradix symbolic /main/f0/inst_mem/ram(10)
mem load -filltype value -filldata 16'b0001100010000000 -fillradix symbolic /main/f0/inst_mem/ram(11)
mem load -filltype value -filldata 16'b0000000000000000 -fillradix symbolic /main/f0/inst_mem/ram(12)
mem load -filltype value -filldata 16'b0000000000000000 -fillradix symbolic /main/f0/inst_mem/ram(13)
mem load -filltype value -filldata 16'b0000000000000000 -fillradix symbolic /main/f0/inst_mem/ram(14)
mem load -filltype value -filldata 16'b0001100100000000 -fillradix symbolic /main/f0/inst_mem/ram(15)
mem load -filltype value -filldata 16'b0000000000000000 -fillradix symbolic /main/f0/inst_mem/ram(16)
mem load -filltype value -filldata 16'b0000000000000000 -fillradix symbolic /main/f0/inst_mem/ram(17)
mem load -filltype value -filldata 16'b0000000000000000 -fillradix symbolic /main/f0/inst_mem/ram(18)
mem load -filltype value -filldata 16'b0000110100000000 -fillradix symbolic /main/f0/inst_mem/ram(19)

mem load -filltype value -filldata 16'b0001000010000000 -fillradix symbolic /main/f0/inst_mem/ram(20)  
mem load -filltype value -filldata 16'b0000000000000000 -fillradix symbolic /main/f0/inst_mem/ram(21)
mem load -filltype value -filldata 16'b0000000000000000 -fillradix symbolic /main/f0/inst_mem/ram(22)
mem load -filltype value -filldata 16'b0001010100000000 -fillradix symbolic /main/f0/inst_mem/ram(23)

mem load -filltype value -filldata 16'b0001110010000000 -fillradix symbolic /main/f0/inst_mem/ram(24)
mem load -filltype value -filldata 16'b0000000000000000 -fillradix symbolic /main/f0/inst_mem/ram(25)
mem load -filltype value -filldata 16'b0000000000000000 -fillradix symbolic /main/f0/inst_mem/ram(26)
mem load -filltype value -filldata 16'b0001110100000000 -fillradix symbolic /main/f0/inst_mem/ram(27)

#mem load -filltype value -filldata 16'b0000010000000000 -fillradix symbolic /main/f0/inst_mem/ram(12)                                 
                                   
                                            
add wave -position insertpoint  \
sim:/main/clock \
sim:/main/memory_stage0/SP/d \
sim:/main/memory_stage0/SP/q \
sim:/main/f0/pc/d \
sim:/main/f0/pc/q \
sim:/main/inputPort \
sim:/main/outputPort_value\
sim:/main/rst \
sim:/main/int \
sim:/main/ex/CCRinsig \
sim:/main/fetchin \
sim:/main/fetchout \
sim:/main/fd_buffer_in \
sim:/main/fd_buffer_out \
sim:/main/decodein \
sim:/main/decodeout \
sim:/main/de_buffer_in \
sim:/main/de_buffer_out \
sim:/main/executein \
sim:/main/executeout \
sim:/main/em_buffer_in \
sim:/main/em_buffer_out \
sim:/main/memoryin \
sim:/main/memoryout \
sim:/main/mem_buffer_in \
sim:/main/mem_buffer_out \
sim:/main/input_data_wb \
sim:/main/wbsignals_1 \
sim:/main/d0/regFileObject/r0/output \
sim:/main/d0/regFileObject/r1/output \
sim:/main/d0/regFileObject/r2/output \
sim:/main/d0/regFileObject/r3/output \
sim:/main/d0/regFileObject/r4/output \
sim:/main/d0/regFileObject/r5/output \
sim:/main/d0/regFileObject/r6/output \
sim:/main/d0/regFileObject/r7/output \
sim:/main/d0/regFileObject/input1 \
sim:/main/d0/regFileObject/input2 \
sim:/main/d0/regFileObject/input3 \
sim:/main/d0/regFileObject/input4 \
sim:/main/d0/regFileObject/input5 \
sim:/main/d0/regFileObject/input6 \
sim:/main/d0/regFileObject/input7 \
sim:/main/d0/regFileObject/input8 \




force -freeze sim:/main/clock 1 0, 0 {50 ps} -r 100
force -freeze sim:/main/rst 1 0
run
force -freeze sim:/main/rst 0 0
force -freeze sim:/main/inputPort 32'h00000005 0
run
run
run
run
run
run
run
run
run
run
force -freeze sim:/main/inputPort 32'h0000000a 0
noforce sim:/main/inputPort
force -freeze sim:/main/inputPort 32'h00000010 0
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run