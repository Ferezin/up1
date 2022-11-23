module cpu(
  input clock, reset,
  inout [7:0] mbr,
  output logic we,
  output logic [7:0] mar, pc, ir);
  
  typedef enum logic [1:0] {FETCH, DECODE, EXECUTE} statetype;
  statetype state, nextstate;
  
  logic [7:0] acc;
  
  always @(posedge clock or posedge reset)
  begin
    if (reset) begin
      pc = 'b0;
      state <= FETCH;
    end
    else begin
      case(state)
      FETCH: begin
        we <= 0;
        pc <= pc + 1;
        mar <= pc;
      end
      DECODE: begin
        ir = mbr;
        mar <= {4'b1111, ir[3:0]};
      end
      EXECUTE: begin
        if (ir[7] == 1'b1)           // jump
          pc <= {1'b0, ir[6:0]};
        else if (ir[7:4] == 3'b011) // indirect load 
          acc <= mbr;
        else if (ir[7:4] == 3'b001) // add acc + data
          acc <= acc + mbr;
        else if (ir[7:4] == 3'b010) // sub acc + data
          acc <= acc - mbr;
        else if (ir[7:4] == 3'b000) // store
          we <= 1'b1;
      end
      endcase  
      state <= nextstate;                  
    end
  end
  
  always_comb
    casex(state)
      FETCH:   nextstate = DECODE;
      DECODE:  nextstate = EXECUTE;
      EXECUTE: nextstate = FETCH;
      default: nextstate = FETCH; 
    endcase
  
  assign mbr = we ? acc : 'bz;
endmodule

module mem #(parameter filename = "ram.hex")
          (input clock, we,
           input [7:0] address,
           inout [7:0] data);

  logic [7:0] RAM[255:0];

  initial
    $readmemb(filename, RAM);

  assign data = we ? 'bz : RAM[address]; 

  always @(posedge clock)
    if (we) RAM[address] <= data;
endmodule
