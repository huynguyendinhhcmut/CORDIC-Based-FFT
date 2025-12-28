module rom_stage_5 (
    input logic           i_clk,
    input logic [3:0]     i_addr,
    output logic [31:0]   o_data
);

logic [31:0] rom [0:15];

initial begin
    // Index 0: 0 deg
    rom[0]  = 32'h00000000; 

    // Index 1: -11.25 deg (-0.1963 rad) -> -12868
    rom[1]  = 32'hffffcdbc; 

    // Index 2: -22.50 deg (-0.3927 rad) -> -25736
    rom[2]  = 32'hffff9b78; 

    // Index 3: -33.75 deg (-0.5890 rad) -> -38604
    rom[3]  = 32'hffff6934; 

    // Index 4: -45.00 deg (-0.7854 rad) -> -51472
    rom[4]  = 32'hffff36f0; 

    // Index 5: -56.25 deg (-0.9817 rad) -> -64340
    rom[5]  = 32'hffff04ac; 

    // Index 6: -67.50 deg (-1.1781 rad) -> -77208
    rom[6]  = 32'hfffed268; 

    // Index 7: -78.75 deg (-1.3744 rad) -> -90076
    rom[7]  = 32'hfffea024; 

    // Index 8: -90.00 deg (-1.5708 rad) -> -102944
    rom[8]  = 32'hfffe6de0; 

    // Index 9: -101.25 deg (-1.7671 rad) -> -115812
    rom[9]  = 32'hfffe3b9c; 

    // Index 10: -112.50 deg (-1.9635 rad) -> -128680
    rom[10] = 32'hfffe0958; 

    // Index 11: -123.75 deg (-2.1598 rad) -> -141548
    rom[11] = 32'hfffdd714; 

    // Index 12: -135.00 deg (-2.3562 rad) -> -154416
    rom[12] = 32'hfffda4d0; 

    // Index 13: -146.25 deg (-2.5525 rad) -> -167284
    rom[13] = 32'hfffd728c; 

    // Index 14: -157.50 deg (-2.7489 rad) -> -180151
    rom[14] = 32'hfffd4049; 

    // Index 15: -168.75 deg (-2.9452 rad) -> -193019
    rom[15] = 32'hfffd0e05; 
end

always @(posedge i_clk) begin
    o_data <= rom[i_addr];
end

endmodule
