vsim -gui work.main

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

mem load -filltype value -filldata {16'b1110000100000000} -fillradix symbolic /main/f0/inst_mem/ram(16)
mem load -filltype value -filldata {16'b0000010100000000} -fillradix symbolic /main/f0/inst_mem/ram(17)
#########################LDM R2,0A
######################LDM R0,0
mem load -filltype value -filldata {16'b1110000000000000} -fillradix symbolic /main/f0/inst_mem/ram(18)
mem load -filltype value -filldata {16'b0000000000000000} -fillradix symbolic /main/f0/inst_mem/ram(19)
######################LDM R1,50
mem load -filltype value -filldata {16'b1110000010000000} -fillradix symbolic /main/f0/inst_mem/ram(20)

mem load -filltype value -filldata {16'b0010100000000000} -fillradix symbolic /main/f0/inst_mem/ram(21)

##############################LDM R3,20
mem load -filltype value -filldata {16'b1110000110000000} -fillradix symbolic /main/f0/inst_mem/ram(22)
mem load -filltype value -filldata {16'b0001000000100000} -fillradix symbolic /main/f0/inst_mem/ram(23)
###############################LDM R4,2
mem load -filltype value -filldata {16'b1110001000000000} -fillradix symbolic /main/f0/inst_mem/ram(24)
mem load -filltype value -filldata {16'b0000000100000000} -fillradix symbolic /main/f0/inst_mem/ram(25)
#nop
mem load -filltype value -filldata {16'b0000000000000000} -fillradix symbolic /main/f0/inst_mem/ram(26)
mem load -filltype value -filldata {16'b0000000000000000} -fillradix symbolic /main/f0/inst_mem/ram(27)
#JMP   
mem load -filltype value -filldata {16'b0010110110000000} -fillradix symbolic /main/f0/inst_mem/ram(28)
###############################
#mem load -filltype value -filldata {16'b0000000000000000} -fillradix symbolic /main/f0/inst_mem/ram(13)
#mem load -filltype value -filldata {16'b0000000000000000} -fillradix symbolic /main/f0/inst_mem/ram(14)
#mem load -filltype value -filldata {16'b0000000000000000} -fillradix symbolic /main/f0/inst_mem/ram(15)
#mem load -filltype value -filldata {16'b0000000000000000} -fillradix symbolic /main/f0/inst_mem/ram(16)
###############################
#mem load -filltype value -filldata {16'b0010100010000000} -fillradix symbolic /main/f0/inst_mem/ram(17)
#mem load -filltype value -filldata {16'b0000000000000000} -fillradix symbolic /main/f0/inst_mem/ram(18)
#mem load -filltype value -filldata {16'b0000000000000000} -fillradix symbolic /main/f0/inst_mem/ram(19)
###############################sub,jz,add
mem load -filltype value -filldata {16'b0100100000101010} -fillradix symbolic /main/f0/inst_mem/ram(32)
mem load -filltype value -filldata {16'b0000000000000000} -fillradix symbolic /main/f0/inst_mem/ram(33)
mem load -filltype value -filldata {16'b0000000000000000} -fillradix symbolic /main/f0/inst_mem/ram(34)
mem load -filltype value -filldata {16'b0010000010000000} -fillradix symbolic /main/f0/inst_mem/ram(35)
mem load -filltype value -filldata {16'b0100011001001000} -fillradix symbolic /main/f0/inst_mem/ram(36)
mem load -filltype value -filldata {16'b0000000000000000} -fillradix symbolic /main/f0/inst_mem/ram(37)
mem load -filltype value -filldata {16'b0000000000000000} -fillradix symbolic /main/f0/inst_mem/ram(38)
mem load -filltype value -filldata {16'b0000000000000000} -fillradix symbolic /main/f0/inst_mem/ram(39)
#OUT R4
mem load -filltype value -filldata {16'b0001111000000000} -fillradix symbolic /main/f0/inst_mem/ram(40)
#inc r0
mem load -filltype value -filldata {16'b0001000000000000} -fillradix symbolic /main/f0/inst_mem/ram(41)
#jmp r3
mem load -filltype value -filldata {16'b0000000000000000} -fillradix symbolic /main/f0/inst_mem/ram(42)
mem load -filltype value -filldata {16'b0000000000000000} -fillradix symbolic /main/f0/inst_mem/ram(43)
mem load -filltype value -filldata {16'b0010110110000000} -fillradix symbolic /main/f0/inst_mem/ram(44)
mem load -filltype value -filldata {16'b0000000000000000} -fillradix symbolic /main/f0/inst_mem/ram(45)
mem load -filltype value -filldata {16'b1110000000000000} -fillradix symbolic /main/f0/inst_mem/ram(80)
mem load -filltype value -filldata {16'b0000000000000000} -fillradix symbolic /main/f0/inst_mem/ram(81)
#########################LDM R0,0
######################LDM R2,8

mem load -filltype value -filldata {16'b1110000100000000} -fillradix symbolic /main/f0/inst_mem/ram(82)
mem load -filltype value -filldata {16'b0000010000000000} -fillradix symbolic /main/f0/inst_mem/ram(83)
######################LDM R3,60

mem load -filltype value -filldata {16'b1110000110000000} -fillradix symbolic /main/f0/inst_mem/ram(84)

mem load -filltype value -filldata {16'b0011000000000000} -fillradix symbolic /main/f0/inst_mem/ram(85)

##############################LDM R4,3

mem load -filltype value -filldata {16'b1110001000000000} -fillradix symbolic /main/f0/inst_mem/ram(86)
mem load -filltype value -filldata {16'b0000000110000000} -fillradix symbolic /main/f0/inst_mem/ram(87)

###############################JMP R3
mem load -filltype value -filldata {16'b0000000000000000} -fillradix symbolic /main/f0/inst_mem/ram(88)
mem load -filltype value -filldata {16'b0010110110000000} -fillradix symbolic /main/f0/inst_mem/ram(89)




############add,out,inc,and,jz,inc,out
##add r4,r4,r4
mem load -filltype value -filldata {16'b0100011001001000} -fillradix symbolic /main/f0/inst_mem/ram(96)

mem load -filltype value -filldata {16'b0000000000000000} -fillradix symbolic /main/f0/inst_mem/ram(97)
mem load -filltype value -filldata {16'b0000000000000000} -fillradix symbolic /main/f0/inst_mem/ram(98)
mem load -filltype value -filldata {16'b0000000000000000} -fillradix symbolic /main/f0/inst_mem/ram(99)
#out r4
mem load -filltype value -filldata {16'b0001111000000000} -fillradix symbolic /main/f0/inst_mem/ram(100)
#inc r0
mem load -filltype value -filldata {16'b0001000000000000} -fillradix symbolic /main/f0/inst_mem/ram(101)

#mem load -filltype value -filldata {16'b0000000000000000} -fillradix symbolic /main/f0/inst_mem/ram(102)
#mem load -filltype value -filldata {16'b0000000000000000} -fillradix symbolic /main/f0/inst_mem/ram(103)
#and r0,r2,r5
mem load -filltype value -filldata {16'b0100110000101010} -fillradix symbolic /main/f0/inst_mem/ram(102)
mem load -filltype value -filldata {16'b0010000110000000} -fillradix symbolic /main/f0/inst_mem/ram(103)


##inc r4
mem load -filltype value -filldata {16'b0001001000000000} -fillradix symbolic /main/f0/inst_mem/ram(104)

mem load -filltype value -filldata {16'b0000000000000000} -fillradix symbolic /main/f0/inst_mem/ram(105)
mem load -filltype value -filldata {16'b0000000000000000} -fillradix symbolic /main/f0/inst_mem/ram(106)
mem load -filltype value -filldata {16'b0000000000000000} -fillradix symbolic /main/f0/inst_mem/ram(107)

##out r4
mem load -filltype value -filldata {16'b0001111000000000} -fillradix symbolic /main/f0/inst_mem/ram(108)


mem load -filltype value -filldata {16'b0000000000000000} -fillradix symbolic /main/f0/inst_mem/ram(109)
mem load -filltype value -filldata {16'b0000000000000000} -fillradix symbolic /main/f0/inst_mem/ram(110)
mem load -filltype value -filldata {16'b0000000000000000} -fillradix symbolic /main/f0/inst_mem/ram(111)





















force -freeze sim:/main/clock 1 0, 0 {50 ps} -r 100
force -freeze sim:/main/rst 1 0
run
force -freeze sim:/main/rst 0 0
run
run
run
run
run
