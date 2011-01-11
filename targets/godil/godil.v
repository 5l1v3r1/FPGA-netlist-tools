// Top-level module for GODIL40_XC3S500E board

module godil40_xc3s500e(
  output [15:0] ab,
  inout [7:0] db,
  input res,
  output rw,
  output sync,
  input so,
  input clk0,
  output clk1out,
  output clk2out,
  input rdy,
  input nmi,
  input irq
);

// handle three-state data bus

  wire [7:0] db_i;
  wire [7:0] db_o;
  wire [7:0] db_t;  // not yet properly set by the 6502 model; instead use rw for the three-state enable for all db pins

  assign db_i = db;
  assign db = rw ? 8'bz : db_o;

// create an emulation clock from clk0

  wire eclk, ereset;

  clock_and_reset _clk(clk0, eclk, ereset);

// instantiate the 6502 model

  chip_6502 _chip_6502(eclk, ereset,
    ab[0], ab[1], ab[2], ab[3], ab[4], ab[5], ab[6], ab[7], ab[8], ab[9], ab[10], ab[11], ab[12], ab[13], ab[14], ab[15],
    db_i[0], db_o[0], db_t[0], db_i[1], db_o[1], db_t[1], db_i[2], db_o[2], db_t[2], db_i[3], db_o[3], db_t[3], 
    db_i[4], db_o[4], db_t[4], db_i[5], db_o[5], db_t[5], db_i[6], db_o[6], db_t[6], db_i[7], db_o[7], db_t[7], 
    res, rw, sync, so, clk0, clk1out, clk2out, rdy, nmi, irq);

endmodule
