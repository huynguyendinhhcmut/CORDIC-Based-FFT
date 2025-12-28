module rom_stage_6 (
    input logic           i_clk,
    input logic [4:0]     i_addr,
    output logic [31:0]   o_data
);

logic [31:0] rom [0:31];

initial begin
    // Index 0: 0 deg
    rom[0]  = 32'h00000000; 

    // Index 1: -1 * pi/32 (-0.0982 rad) -> -6434
    rom[1]  = 32'hffffe6de; 

    // Index 2: -2 * pi/32 (-0.1963 rad) -> -12868
    rom[2]  = 32'hffffcdbc; 

    // Index 3: -3 * pi/32 (-0.2945 rad) -> -19302
    rom[3]  = 32'hffffb49a; 

    // Index 4: -4 * pi/32 (-0.3927 rad) -> -25736
    rom[4]  = 32'hffff9b78; 

    // Index 5: -5 * pi/32 (-0.4909 rad) -> -32170
    rom[5]  = 32'hffff8256; 

    // Index 6: -6 * pi/32 (-0.5890 rad) -> -38604
    rom[6]  = 32'hffff6934; 

    // Index 7: -7 * pi/32 (-0.6872 rad) -> -45038
    rom[7]  = 32'hffff5012; 

    // Index 8: -8 * pi/32 (-0.7854 rad) -> -51472
    rom[8]  = 32'hffff36f0; 

    // Index 9: -9 * pi/32 (-0.8836 rad) -> -57906
    rom[9]  = 32'hffff1dce; 

    // Index 10: -10 * pi/32 (-0.9817 rad) -> -64340
    rom[10] = 32'hffff04ac; 

    // Index 11: -11 * pi/32 (-1.0799 rad) -> -70774
    rom[11] = 32'hfffeeb8a; 

    // Index 12: -12 * pi/32 (-1.1781 rad) -> -77208
    rom[12] = 32'hfffed268; 

    // Index 13: -13 * pi/32 (-1.2763 rad) -> -83642
    rom[13] = 32'hfffeb946; 

    // Index 14: -14 * pi/32 (-1.3744 rad) -> -90076
    rom[14] = 32'hfffea024; 

    // Index 15: -15 * pi/32 (-1.4726 rad) -> -96510
    rom[15] = 32'hfffe8702; 

    // Index 16: -16 * pi/32 (-1.5708 rad) -> -102944
    rom[16] = 32'hfffe6de0; 

    // Index 17: -17 * pi/32 (-1.6690 rad) -> -109378
    rom[17] = 32'hfffe54be; 

    // Index 18: -18 * pi/32 (-1.7671 rad) -> -115812
    rom[18] = 32'hfffe3b9c; 

    // Index 19: -19 * pi/32 (-1.8653 rad) -> -122246
    rom[19] = 32'hfffe227a; 

    // Index 20: -20 * pi/32 (-1.9635 rad) -> -128680
    rom[20] = 32'hfffe0958; 

    // Index 21: -21 * pi/32 (-2.0617 rad) -> -135114
    rom[21] = 32'hfffdf036; 

    // Index 22: -22 * pi/32 (-2.1598 rad) -> -141548
    rom[22] = 32'hfffdd714; 

    // Index 23: -23 * pi/32 (-2.2580 rad) -> -147982
    rom[23] = 32'hfffdbdf2; 

    // Index 24: -24 * pi/32 (-2.3562 rad) -> -154416
    rom[24] = 32'hfffda4d0; 

    // Index 25: -25 * pi/32 (-2.4544 rad) -> -160850
    rom[25] = 32'hfffd8bae; 

    // Index 26: -26 * pi/32 (-2.5525 rad) -> -167284
    rom[26] = 32'hfffd728c; 

    // Index 27: -27 * pi/32 (-2.6507 rad) -> -173718
    rom[27] = 32'hfffd596a; 

    // Index 28: -28 * pi/32 (-2.7489 rad) -> -180152
    rom[28] = 32'hfffd4048; 

    // Index 29: -29 * pi/32 (-2.8471 rad) -> -186586
    rom[29] = 32'hfffd2726; 

    // Index 30: -30 * pi/32 (-2.9452 rad) -> -193020
    rom[30] = 32'hfffd0e04; 

    // Index 31: -31 * pi/32 (-3.0434 rad) -> -199454
    rom[31] = 32'hfffcf4e2; 
end

always @(posedge i_clk) begin
    o_data <= rom[i_addr];
end

endmodule
