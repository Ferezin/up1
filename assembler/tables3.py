inst_table = {
    "ADD"   : "001",
    "SUB"   : "010",
    "LOAD"  : "011",
    "STORE" : "000",
    "JUMP"  : "1"
}

space_table = {       #   dec   |        bin        |  hex
    "code"   : 128,   #   0:127 | 00000000:01111111 | 00:7f
    "video"  :  0,   # 128:207 | 10000000:11001111 | 80:cf
    "unused" :  96,   # 208:239 | 11010000:11101111 | d0:ef
    "data"   :  32    # 240:255 | 11110000:11111111 | f0:ff
}

fields_table = {
    "opcode"  : 4,
    "address" : 4,
    "jump"    : 7
}
