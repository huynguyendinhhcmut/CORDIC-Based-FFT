module rom_stage_3 (
    input logic           i_clk,
    input logic [1:0]     i_addr,
    output logic [31:0]   o_data
);

logic [31:0] rom [0:3];

initial begin
    // Q16.16 Format: Value * 65536
    
    // Index 0: 0.0 -> 0
    rom[0] = 32'h00000000; 
    
    // Index 1: -pi/4 (-0.785398) 
    // 0.785398 * 65536 = 51472 (0xC910) -> Negative: 0xFFFF36F0
    rom[1] = 32'hffff36f0; 
    
    // Index 2: -pi/2 (-1.570796)
    // 1.570796 * 65536 = 102944 (0x19220) -> Negative: 0xFFFE6DE0
    rom[2] = 32'hfffe6de0; 
    
    // Index 3: -3pi/4 (-2.356194)
    // 2.356194 * 65536 = 154416 (0x25B30) -> Negative: 0xFFDA44D0
    rom[3] = 32'hffda44d0; 
end

always @(posedge i_clk) begin
    o_data <= rom[i_addr];
end

endmodule
