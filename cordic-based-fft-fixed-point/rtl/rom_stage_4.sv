module rom_stage_4 (
    input logic           i_clk,
    input logic [2:0]     i_addr,
    output logic [31:0]   o_data
);

logic [31:0] rom [0:7];

initial begin
    // Index 0: 0 rad
    rom[0] = 32'h00000000; 

    // Index 1: -pi/8 (-0.3927 rad)
    // 0.3927 * 65536 = 25736 (0x6488) -> Neg: 0xFFFF9B78
    rom[1] = 32'hffff9b78; 

    // Index 2: -pi/4 (-0.7854 rad)
    // 0.7854 * 65536 = 51472 (0xC910) -> Neg: 0xFFFF36F0
    rom[2] = 32'hffff36f0; 

    // Index 3: -3pi/8 (-1.1781 rad)
    // 1.1781 * 65536 = 77208 (0x12D98) -> Neg: 0xFFFED268
    rom[3] = 32'hfffed268; 

    // Index 4: -pi/2 (-1.5708 rad)
    // 1.5708 * 65536 = 102944 (0x19220) -> Neg: 0xFFFE6DE0
    rom[4] = 32'hfffe6de0; 

    // Index 5: -5pi/8 (-1.9635 rad)
    // 1.9635 * 65536 = 128680 (0x1F6A8) -> Neg: 0xFFFE0958
    rom[5] = 32'hfffe0958; 

    // Index 6: -3pi/4 (-2.3562 rad)
    // 2.3562 * 65536 = 154416 (0x25B30) -> Neg: 0xFFDA44D0
    rom[6] = 32'hffda44d0; 

    // Index 7: -7pi/8 (-2.7489 rad)
    // 2.7489 * 65536 = 180151 (0x2BFB7) -> Neg: 0xFFD40049
    rom[7] = 32'hffd40049; 
end

always @(posedge i_clk) begin
    o_data <= rom[i_addr];
end

endmodule
