module rom_stage_8 (
    input logic           i_clk,
    input logic [6:0]     i_addr,   // 7 bit cho 128 góc
    output logic [31:0]   o_data
);

logic [31:0] rom [0:127];

initial begin
    // Index 0: 0.0000 deg
    rom[  0] = 32'h00000000;

    // Index 1: -1.4062 deg (-0.0245 rad) -> -1608
    rom[  1] = 32'hfffff9b8;

    // Index 2: -2.8125 deg (-0.0491 rad) -> -3217
    rom[  2] = 32'hfffff36f;

    // Index 3: -4.2188 deg (-0.0736 rad) -> -4825
    rom[  3] = 32'hffffed27;

    // Index 4: -5.6250 deg (-0.0982 rad) -> -6434
    rom[  4] = 32'hffffe6de;

    // Index 5: -7.0312 deg (-0.1227 rad) -> -8042
    rom[  5] = 32'hffffe096;

    // Index 6: -8.4375 deg (-0.1473 rad) -> -9651
    rom[  6] = 32'hffffda4d;

    // Index 7: -9.8438 deg (-0.1718 rad) -> -11259
    rom[  7] = 32'hffffd405;

    // Index 8: -11.2500 deg (-0.1963 rad) -> -12868
    rom[  8] = 32'hffffcdbc;

    // Index 9: -12.6562 deg (-0.2209 rad) -> -14476
    rom[  9] = 32'hffffc774;

    // Index 10: -14.0625 deg (-0.2454 rad) -> -16085
    rom[ 10] = 32'hffffc12b;

    // Index 11: -15.4687 deg (-0.2700 rad) -> -17693
    rom[ 11] = 32'hffffbae3;

    // Index 12: -16.8750 deg (-0.2945 rad) -> -19302
    rom[ 12] = 32'hffffb49a;

    // Index 13: -18.2812 deg (-0.3191 rad) -> -20910
    rom[ 13] = 32'hffffae52;

    // Index 14: -19.6875 deg (-0.3436 rad) -> -22519
    rom[ 14] = 32'hffffa809;

    // Index 15: -21.0938 deg (-0.3682 rad) -> -24127
    rom[ 15] = 32'hffffa1c1;

    // Index 16: -22.5000 deg (-0.3927 rad) -> -25736
    rom[ 16] = 32'hffff9b78;

    // Index 17: -23.9062 deg (-0.4172 rad) -> -27344
    rom[ 17] = 32'hffff9530;

    // Index 18: -25.3125 deg (-0.4418 rad) -> -28953
    rom[ 18] = 32'hffff8ee7;

    // Index 19: -26.7188 deg (-0.4663 rad) -> -30561
    rom[ 19] = 32'hffff889f;

    // Index 20: -28.1250 deg (-0.4909 rad) -> -32170
    rom[ 20] = 32'hffff8256;

    // Index 21: -29.5312 deg (-0.5154 rad) -> -33778
    rom[ 21] = 32'hffff7c0e;

    // Index 22: -30.9375 deg (-0.5400 rad) -> -35387
    rom[ 22] = 32'hffff75c5;

    // Index 23: -32.3438 deg (-0.5645 rad) -> -36995
    rom[ 23] = 32'hffff6f7d;

    // Index 24: -33.7500 deg (-0.5890 rad) -> -38604
    rom[ 24] = 32'hffff6934;

    // Index 25: -35.1562 deg (-0.6136 rad) -> -40212
    rom[ 25] = 32'hffff62ec;

    // Index 26: -36.5625 deg (-0.6381 rad) -> -41821
    rom[ 26] = 32'hffff5ca3;

    // Index 27: -37.9688 deg (-0.6627 rad) -> -43429
    rom[ 27] = 32'hffff565b;

    // Index 28: -39.3750 deg (-0.6872 rad) -> -45038
    rom[ 28] = 32'hffff5012;

    // Index 29: -40.7812 deg (-0.7118 rad) -> -46646
    rom[ 29] = 32'hffff49ca;

    // Index 30: -42.1875 deg (-0.7363 rad) -> -48255
    rom[ 30] = 32'hffff4381;

    // Index 31: -43.5938 deg (-0.7609 rad) -> -49863
    rom[ 31] = 32'hffff3d39;

    // Index 32: -45.0000 deg (-0.7854 rad) -> -51472
    rom[ 32] = 32'hffff36f0;

    // Index 33: -46.4062 deg (-0.8099 rad) -> -53080
    rom[ 33] = 32'hffff30a8;

    // Index 34: -47.8125 deg (-0.8345 rad) -> -54689
    rom[ 34] = 32'hffff2a5f;

    // Index 35: -49.2188 deg (-0.8590 rad) -> -56297
    rom[ 35] = 32'hffff2417;

    // Index 36: -50.6250 deg (-0.8836 rad) -> -57906
    rom[ 36] = 32'hffff1dce;

    // Index 37: -52.0312 deg (-0.9081 rad) -> -59514
    rom[ 37] = 32'hffff1786;

    // Index 38: -53.4375 deg (-0.9327 rad) -> -61123
    rom[ 38] = 32'hffff113d;

    // Index 39: -54.8438 deg (-0.9572 rad) -> -62731
    rom[ 39] = 32'hffff0af5;

    // Index 40: -56.2500 deg (-0.9817 rad) -> -64340
    rom[ 40] = 32'hffff04ac;

    // Index 41: -57.6562 deg (-1.0063 rad) -> -65948
    rom[ 41] = 32'hfffefe64;

    // Index 42: -59.0625 deg (-1.0308 rad) -> -67557
    rom[ 42] = 32'hfffef81b;

    // Index 43: -60.4688 deg (-1.0554 rad) -> -69165
    rom[ 43] = 32'hfffef1d3;

    // Index 44: -61.8750 deg (-1.0799 rad) -> -70774
    rom[ 44] = 32'hfffeeb8a;

    // Index 45: -63.2812 deg (-1.1045 rad) -> -72382
    rom[ 45] = 32'hfffee542;

    // Index 46: -64.6875 deg (-1.1290 rad) -> -73991
    rom[ 46] = 32'hfffedef9;

    // Index 47: -66.0938 deg (-1.1536 rad) -> -75599
    rom[ 47] = 32'hfffed8b1;

    // Index 48: -67.5000 deg (-1.1781 rad) -> -77208
    rom[ 48] = 32'hfffed268;

    // Index 49: -68.9062 deg (-1.2026 rad) -> -78816
    rom[ 49] = 32'hfffecc20;

    // Index 50: -70.3125 deg (-1.2272 rad) -> -80425
    rom[ 50] = 32'hfffec5d7;

    // Index 51: -71.7188 deg (-1.2517 rad) -> -82033
    rom[ 51] = 32'hfffebf8f;

    // Index 52: -73.1250 deg (-1.2763 rad) -> -83642
    rom[ 52] = 32'hfffeb946;

    // Index 53: -74.5312 deg (-1.3008 rad) -> -85250
    rom[ 53] = 32'hfffeb2fe;

    // Index 54: -75.9375 deg (-1.3254 rad) -> -86859
    rom[ 54] = 32'hfffeacb5;

    // Index 55: -77.3438 deg (-1.3499 rad) -> -88467
    rom[ 55] = 32'hfffea66d;

    // Index 56: -78.7500 deg (-1.3744 rad) -> -90076
    rom[ 56] = 32'hfffea024;

    // Index 57: -80.1562 deg (-1.3990 rad) -> -91684
    rom[ 57] = 32'hfffe99dc;

    // Index 58: -81.5625 deg (-1.4235 rad) -> -93293
    rom[ 58] = 32'hfffe9393;

    // Index 59: -82.9688 deg (-1.4481 rad) -> -94901
    rom[ 59] = 32'hfffe8d4b;

    // Index 60: -84.3750 deg (-1.4726 rad) -> -96510
    rom[ 60] = 32'hfffe8702;

    // Index 61: -85.7812 deg (-1.4972 rad) -> -98118
    rom[ 61] = 32'hfffe80ba;

    // Index 62: -87.1875 deg (-1.5217 rad) -> -99727
    rom[ 62] = 32'hfffe7a71;

    // Index 63: -88.5938 deg (-1.5463 rad) -> -101335
    rom[ 63] = 32'hfffe7429;

    // Index 64: -90.0000 deg (-1.5708 rad) -> -102944
    rom[ 64] = 32'hfffe6de0;

    // Index 65: -91.4062 deg (-1.5953 rad) -> -104552
    rom[ 65] = 32'hfffe6798;

    // Index 66: -92.8125 deg (-1.6199 rad) -> -106161
    rom[ 66] = 32'hfffe614f;

    // Index 67: -94.2188 deg (-1.6444 rad) -> -107769
    rom[ 67] = 32'hfffe5b07;

    // Index 68: -95.6250 deg (-1.6690 rad) -> -109378
    rom[ 68] = 32'hfffe54be;

    // Index 69: -97.0312 deg (-1.6935 rad) -> -110986
    rom[ 69] = 32'hfffe4e76;

    // Index 70: -98.4375 deg (-1.7181 rad) -> -112595
    rom[ 70] = 32'hfffe482d;

    // Index 71: -99.8438 deg (-1.7426 rad) -> -114203
    rom[ 71] = 32'hfffe41e5;

    // Index 72: -101.2500 deg (-1.7671 rad) -> -115812
    rom[ 72] = 32'hfffe3b9c;

    // Index 73: -102.6562 deg (-1.7917 rad) -> -117420
    rom[ 73] = 32'hfffe3554;

    // Index 74: -104.0625 deg (-1.8162 rad) -> -119029
    rom[ 74] = 32'hfffe2f0b;

    // Index 75: -105.4688 deg (-1.8408 rad) -> -120637
    rom[ 75] = 32'hfffe28c3;

    // Index 76: -106.8750 deg (-1.8653 rad) -> -122246
    rom[ 76] = 32'hfffe227a;

    // Index 77: -108.2812 deg (-1.8899 rad) -> -123854
    rom[ 77] = 32'hfffe1c32;

    // Index 78: -109.6875 deg (-1.9144 rad) -> -125463
    rom[ 78] = 32'hfffe15e9;

    // Index 79: -111.0938 deg (-1.9390 rad) -> -127071
    rom[ 79] = 32'hfffe0fa1;

    // Index 80: -112.5000 deg (-1.9635 rad) -> -128680
    rom[ 80] = 32'hfffe0958;

    // Index 81: -113.9062 deg (-1.9880 rad) -> -130288
    rom[ 81] = 32'hfffe0310;

    // Index 82: -115.3125 deg (-2.0126 rad) -> -131897
    rom[ 82] = 32'hfffdfcc7;

    // Index 83: -116.7188 deg (-2.0371 rad) -> -133505
    rom[ 83] = 32'hfffdf67f;

    // Index 84: -118.1250 deg (-2.0617 rad) -> -135114
    rom[ 84] = 32'hfffdf036;

    // Index 85: -119.5312 deg (-2.0862 rad) -> -136722
    rom[ 85] = 32'hfffde9ee;

    // Index 86: -120.9375 deg (-2.1108 rad) -> -138331
    rom[ 86] = 32'hfffde3a5;

    // Index 87: -122.3437 deg (-2.1353 rad) -> -139939
    rom[ 87] = 32'hfffddd5d;

    // Index 88: -123.7500 deg (-2.1598 rad) -> -141548
    rom[ 88] = 32'hfffdd714;

    // Index 89: -125.1563 deg (-2.1844 rad) -> -143156
    rom[ 89] = 32'hfffdd0cc;

    // Index 90: -126.5625 deg (-2.2089 rad) -> -144765
    rom[ 90] = 32'hfffdea83;

    // Index 91: -127.9688 deg (-2.2335 rad) -> -146373
    rom[ 91] = 32'hfffde43b;

    // Index 92: -129.3750 deg (-2.2580 rad) -> -147982
    rom[ 92] = 32'hfffdbdf2;

    // Index 93: -130.7812 deg (-2.2826 rad) -> -149590
    rom[ 93] = 32'hfffdb7aa;

    // Index 94: -132.1875 deg (-2.3071 rad) -> -151199
    rom[ 94] = 32'hfffdb161;

    // Index 95: -133.5938 deg (-2.3317 rad) -> -152807
    rom[ 95] = 32'hfffdab19;

    // Index 96: -135.0000 deg (-2.3562 rad) -> -154416
    rom[ 96] = 32'hfffda4d0;

    // Index 97: -136.4062 deg (-2.3807 rad) -> -156024
    rom[ 97] = 32'hfffd9e88;

    // Index 98: -137.8125 deg (-2.4053 rad) -> -157633
    rom[ 98] = 32'hfffd983f;

    // Index 99: -139.2188 deg (-2.4298 rad) -> -159241
    rom[ 99] = 32'hfffd91f7;

    // Index 100: -140.6250 deg (-2.4544 rad) -> -160850
    rom[ 100] = 32'hfffd8bae;

    // Index 101: -142.0312 deg (-2.4789 rad) -> -162458
    rom[ 101] = 32'hfffd8566;

    // Index 102: -143.4375 deg (-2.5035 rad) -> -164067
    rom[ 102] = 32'hfffd7f1d;

    // Index 103: -144.8438 deg (-2.5280 rad) -> -165675
    rom[ 103] = 32'hfffd78d5;

    // Index 104: -146.2500 deg (-2.5525 rad) -> -167284
    rom[ 104] = 32'hfffd728c;

    // Index 105: -147.6562 deg (-2.5771 rad) -> -168892
    rom[ 105] = 32'hfffd6c44;

    // Index 106: -149.0625 deg (-2.6016 rad) -> -170501
    rom[ 106] = 32'hfffd65fb;

    // Index 107: -150.4688 deg (-2.6262 rad) -> -172109
    rom[ 107] = 32'hfffd5fb3;

    // Index 108: -151.8750 deg (-2.6507 rad) -> -173718
    rom[ 108] = 32'hfffd596a;

    // Index 109: -153.2812 deg (-2.6753 rad) -> -175326
    rom[ 109] = 32'hfffd5322;

    // Index 110: -154.6875 deg (-2.6998 rad) -> -176935
    rom[ 110] = 32'hfffd4cd9;

    // Index 111: -156.0938 deg (-2.7243 rad) -> -178543
    rom[ 111] = 32'hfffd4691;

    // Index 112: -157.5000 deg (-2.7489 rad) -> -180151
    rom[ 112] = 32'hfffd4049;

    // Index 113: -158.9062 deg (-2.7734 rad) -> -181760
    rom[ 113] = 32'hfffd3a00;

    // Index 114: -160.3125 deg (-2.7980 rad) -> -183368
    rom[ 114] = 32'hfffd33b8;

    // Index 115: -161.7188 deg (-2.8225 rad) -> -184977
    rom[ 115] = 32'hfffd2d6f;

    // Index 116: -163.1250 deg (-2.8471 rad) -> -186585
    rom[ 116] = 32'hfffd2727;

    // Index 117: -164.5312 deg (-2.8716 rad) -> -188194
    rom[ 117] = 32'hfffd20de;

    // Index 118: -165.9375 deg (-2.8962 rad) -> -189802
    rom[ 118] = 32'hfffd1a96;

    // Index 119: -167.3438 deg (-2.9207 rad) -> -191411
    rom[ 119] = 32'hfffd144d;

    // Index 120: -168.7500 deg (-2.9452 rad) -> -193019
    rom[ 120] = 32'hfffd0e05;

    // Index 121: -170.1562 deg (-2.9698 rad) -> -194628
    rom[ 121] = 32'hfffd07bc;

    // Index 122: -171.5625 deg (-2.9943 rad) -> -196236
    rom[ 122] = 32'hfffd0174;

    // Index 123: -172.9688 deg (-3.0189 rad) -> -197845
    rom[ 123] = 32'hfffcfb2b;

    // Index 124: -174.3750 deg (-3.0434 rad) -> -199453
    rom[ 124] = 32'hfffcf4e3;

    // Index 125: -175.7812 deg (-3.0680 rad) -> -201062
    rom[ 125] = 32'hfffce89a;

    // Index 126: -177.1875 deg (-3.0925 rad) -> -202670
    rom[ 126] = 32'hfffce852; // Có thể sai số nhỏ, nhưng giữ nhất quán

    // Index 127: -178.5938 deg (-3.1171 rad) -> -204279
    rom[ 127] = 32'hfffce209;
end

always @(posedge i_clk) begin
    o_data <= rom[i_addr];
end

endmodule
