module rom_stage_7 (
    input logic           i_clk,
    input logic [5:0]     i_addr,
    output logic [31:0]   o_data
);

logic [31:0] rom [0:63];

initial begin
    // Index 0: 0
    rom[ 0] = 32'h00000000;
    
    // Index 1: -1 * pi/64 -> -3217
    rom[ 1] = 32'hfffff36f;
    
    // Index 2: -2 * pi/64 -> -6434
    rom[ 2] = 32'hffffe6de;
    
    // Index 3: -3 * pi/64 -> -9651
    rom[ 3] = 32'hffffd24d;
    
    // Index 4: -4 * pi/64 -> -12868
    rom[ 4] = 32'hffffcdbc;
    
    // Index 5: -5 * pi/64 -> -16085
    rom[ 5] = 32'hffffc12b;
    
    // Index 6: -6 * pi/64 -> -19302
    rom[ 6] = 32'hffffb49a;
    
    // Index 7: -7 * pi/64 -> -22519
    rom[ 7] = 32'hffffa809;
    
    // Index 8: -8 * pi/64 (-pi/8) -> -25736
    rom[ 8] = 32'hffff9b78;
    
    // Index 9: -9 * pi/64 -> -28953
    rom[ 9] = 32'hffff8ee7;
    
    // Index 10: -10 * pi/64 -> -32170
    rom[10] = 32'hffff8256;
    
    // Index 11: -11 * pi/64 -> -35387
    rom[11] = 32'hffff75c5;
    
    // Index 12: -12 * pi/64 -> -38604
    rom[12] = 32'hffff6934;
    
    // Index 13: -13 * pi/64 -> -41821
    rom[13] = 32'hffff5ca3;
    
    // Index 14: -14 * pi/64 -> -45038
    rom[14] = 32'hffff5012;
    
    // Index 15: -15 * pi/64 -> -48255
    rom[15] = 32'hffff4381;
    
    // Index 16: -16 * pi/64 (-pi/4) -> -51472
    rom[16] = 32'hffff36f0;
    
    // Index 17: -17 * pi/64 -> -54689
    rom[17] = 32'hffff2a5f;
    
    // Index 18: -18 * pi/64 -> -57906
    rom[18] = 32'hffff1dce;
    
    // Index 19: -19 * pi/64 -> -61123
    rom[19] = 32'hffff113d;
    
    // Index 20: -20 * pi/64 -> -64340
    rom[20] = 32'hffff04ac;
    
    // Index 21: -21 * pi/64 -> -67557
    rom[21] = 32'hfffef81b;
    
    // Index 22: -22 * pi/64 -> -70774
    rom[22] = 32'hfffeeb8a;
    
    // Index 23: -23 * pi/64 -> -73991
    rom[23] = 32'hfffedef9;
    
    // Index 24: -24 * pi/64 -> -77208
    rom[24] = 32'hfffed268;
    
    // Index 25: -25 * pi/64 -> -80425
    rom[25] = 32'hfffec5d7;
    
    // Index 26: -26 * pi/64 -> -83642
    rom[26] = 32'hfffeb946;
    
    // Index 27: -27 * pi/64 -> -86859
    rom[27] = 32'hfffecab5; // (Lưu ý: Do tràn số 16 bit thấp nên có thể nhảy số, giá trị này là -86859)
                             // -86859 = FFFEACB5.
    // Wait, để đảm bảo chính xác nhất, tôi sẽ ghi đè giá trị chuẩn cho index 27
    rom[27] = 32'hfffeacb5; 
    
    // Index 28: -28 * pi/64 -> -90076
    rom[28] = 32'hfffea024;
    
    // Index 29: -29 * pi/64 -> -93293
    rom[29] = 32'hfffe9393;
    
    // Index 30: -30 * pi/64 -> -96510
    rom[30] = 32'hfffe8702;
    
    // Index 31: -31 * pi/64 -> -99727
    rom[31] = 32'hfffe7a71;
    
    // Index 32: -32 * pi/64 (-pi/2) -> -102944
    rom[32] = 32'hfffe6de0;
    
    // Index 33: -33 * pi/64 -> -106161
    rom[33] = 32'hfffe614f;
    
    // Index 34: -34 * pi/64 -> -109378
    rom[34] = 32'hfffe54be;
    
    // Index 35: -35 * pi/64 -> -112595
    rom[35] = 32'hfffe482d;
    
    // Index 36: -36 * pi/64 -> -115812
    rom[36] = 32'hfffe3b9c;
    
    // Index 37: -37 * pi/64 -> -119029
    rom[37] = 32'hfffe2f0b;
    
    // Index 38: -38 * pi/64 -> -122246
    rom[38] = 32'hfffe227a;
    
    // Index 39: -39 * pi/64 -> -125463
    rom[39] = 32'hfffe15e9;
    
    // Index 40: -40 * pi/64 -> -128680
    rom[40] = 32'hfffe0958;
    
    // Index 41: -41 * pi/64 -> -131897
    rom[41] = 32'hfffdfcc7;
    
    // Index 42: -42 * pi/64 -> -135114
    rom[42] = 32'hfffdf036;
    
    // Index 43: -43 * pi/64 -> -138331
    rom[43] = 32'hfffde3a5;
    
    // Index 44: -44 * pi/64 -> -141548
    rom[44] = 32'hfffdd714;
    
    // Index 45: -45 * pi/64 -> -144765
    rom[45] = 32'hfffdea83;
    
    // Index 46: -46 * pi/64 -> -147982
    rom[46] = 32'hfffdbdf2;
    
    // Index 47: -47 * pi/64 -> -151199
    rom[47] = 32'hfffdb161;
    
    // Index 48: -48 * pi/64 (-3pi/4) -> -154416
    rom[48] = 32'hfffda4d0;
    
    // Index 49: -49 * pi/64 -> -157633
    rom[49] = 32'hfffd983f;
    
    // Index 50: -50 * pi/64 -> -160850
    rom[50] = 32'hfffd8bae;
    
    // Index 51: -51 * pi/64 -> -164067
    rom[51] = 32'hfffd7f1d;
    
    // Index 52: -52 * pi/64 -> -167284
    rom[52] = 32'hfffd728c;
    
    // Index 53: -53 * pi/64 -> -170501
    rom[53] = 32'hfffd65fb;
    
    // Index 54: -54 * pi/64 -> -173718
    rom[54] = 32'hfffd596a;
    
    // Index 55: -55 * pi/64 -> -176935
    rom[55] = 32'hfffd4cd9;
    
    // Index 56: -56 * pi/64 -> -180151
    rom[56] = 32'hfffd4049;
    
    // Index 57: -57 * pi/64 -> -183368
    rom[57] = 32'hfffd33b8;
    
    // Index 58: -58 * pi/64 -> -186585
    rom[58] = 32'hfffd2727;
    
    // Index 59: -59 * pi/64 -> -189802
    rom[59] = 32'hfffd1a96;
    
    // Index 60: -60 * pi/64 -> -193019
    rom[60] = 32'hfffd0e05;
    
    // Index 61: -61 * pi/64 -> -196236
    rom[61] = 32'hfffd0174;
    
    // Index 62: -62 * pi/64 -> -199453
    rom[62] = 32'hfffcf4e3;
    
    // Index 63: -63 * pi/64 -> -202670
    rom[63] = 32'hfffce852;
end

always @(posedge i_clk) begin
    o_data <= rom[i_addr];
end

endmodule
