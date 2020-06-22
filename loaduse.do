vsim -gui work.main
# vsim -gui work.main 
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
sim:/main/hzrd_out.Stall \
sim:/main/fetchsignals_1 \
sim:/main/decodesignals_1 \
sim:/main/executesignals_1 \
sim:/main/memorysignals_1 \
sim:/main/wbsignals_1 \
sim:/main/d0/regFileObject/r0/output \
sim:/main/d0/regFileObject/r1/output \
sim:/main/d0/regFileObject/r2/output \
sim:/main/d0/regFileObject/r3/output \
sim:/main/d0/regFileObject/r4/output \
sim:/main/d0/regFileObject/r5/output \
sim:/main/d0/regFileObject/r6/output \
sim:/main/d0/regFileObject/r7/output \



#LDM R1,f5
mem load -filltype value -filldata {16'b1110000010000000} -fillradix symbolic /main/f0/inst_mem/ram(0)
mem load -filltype value -filldata {16'b0111101010000000} -fillradix symbolic /main/f0/inst_mem/ram(1)
#STD R1,202
mem load -filltype value -filldata {16'b1111100010000000} -fillradix symbolic /main/f0/inst_mem/ram(2)
mem load -filltype value -filldata {16'b0001000000010000} -fillradix symbolic /main/f0/inst_mem/ram(3)
#LDD R3,202
mem load -filltype value -filldata {16'b1110010110000000} -fillradix symbolic /main/f0/inst_mem/ram(4)
mem load -filltype value -filldata {16'b0001000000010000} -fillradix symbolic /main/f0/inst_mem/ram(5)
#NOT R3
mem load -filltype value -filldata {16'b0000110110000000} -fillradix symbolic /main/f0/inst_mem/ram(6)


force -freeze sim:/main/clock 1 0, 0 {50 ps} -r 100
force -freeze sim:/main/rst 1 0
run
force -freeze sim:/main/rst 0 0
run
run
