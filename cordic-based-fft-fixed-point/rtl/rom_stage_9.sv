module rom_stage_9 (
    input logic           i_clk,
    input logic [7:0]     i_addr,
    output logic [31:0]   o_data
);

logic [31:0] rom [0:255];

initial begin
    // Index 0: 0.00 deg
    rom[  0] = 32'h00000000;

    // Index 1: -0.70 deg (-0.0123 rad) -> -804
    rom[  1] = 32'hfffffcdc;

    // Index 2: -1.41 deg (-0.0245 rad) -> -1608
    rom[  2] = 32'hfffff9b8;

    // Index 3: -2.11 deg (-0.0368 rad) -> -2413
    rom[  3] = 32'hfffff693;

    // Index 4: -2.81 deg (-0.0491 rad) -> -3217
    rom[  4] = 32'hfffff36f;

    // Index 5: -3.52 deg (-0.0614 rad) -> -4021
    rom[  5] = 32'hffffe04b; 

    // Index 6: -4.22 deg (-0.0736 rad) -> -4825
    rom[  6] = 32'hffffed27;

    // Index 7: -4.92 deg (-0.0859 rad) -> -5630
    rom[  7] = 32'hffffea02;

    // Index 8: -5.62 deg (-0.0982 rad) -> -6434
    rom[  8] = 32'hffffe6de;

    // Index 9: -6.33 deg (-0.1104 rad) -> -7238
    rom[  9] = 32'hffffe3ba;

    // Index 10: -7.03 deg (-0.1227 rad) -> -8042
    rom[ 10] = 32'hffffe096;

    // Index 11: -7.73 deg (-0.1350 rad) -> -8847
    rom[ 11] = 32'hffffdd71;

    // Index 12: -8.44 deg (-0.1473 rad) -> -9651
    rom[ 12] = 32'hffffda4d;

    // Index 13: -9.14 deg (-0.1595 rad) -> -10455
    rom[ 13] = 32'hffffd729;

    // Index 14: -9.84 deg (-0.1718 rad) -> -11259
    rom[ 14] = 32'hffffd405;

    // Index 15: -10.55 deg (-0.1841 rad) -> -12064
    rom[ 15] = 32'hffffd0e0;

    // Index 16: -11.25 deg (-0.1963 rad) -> -12868
    rom[ 16] = 32'hffffcdbc;

    // Index 17: -11.95 deg (-0.2086 rad) -> -13672
    rom[ 17] = 32'hffffca98;

    // Index 18: -12.66 deg (-0.2209 rad) -> -14476
    rom[ 18] = 32'hffffc774;

    // Index 19: -13.36 deg (-0.2332 rad) -> -15281
    rom[ 19] = 32'hffffc44f;

    // Index 20: -14.06 deg (-0.2454 rad) -> -16085
    rom[ 20] = 32'hffffc12b;

    // Index 21: -14.77 deg (-0.2577 rad) -> -16889
    rom[ 21] = 32'hffffbe07;

    // Index 22: -15.47 deg (-0.2700 rad) -> -17693
    rom[ 22] = 32'hffffbae3;

    // Index 23: -16.17 deg (-0.2823 rad) -> -18498
    rom[ 23] = 32'hffffb7be;

    // Index 24: -16.88 deg (-0.2945 rad) -> -19302
    rom[ 24] = 32'hffffb49a;

    // Index 25: -17.58 deg (-0.3068 rad) -> -20106
    rom[ 25] = 32'hffffb176;

    // Index 26: -18.28 deg (-0.3191 rad) -> -20910
    rom[ 26] = 32'hffffae52;

    // Index 27: -18.98 deg (-0.3313 rad) -> -21715
    rom[ 27] = 32'hffffab2d;

    // Index 28: -19.69 deg (-0.3436 rad) -> -22519
    rom[ 28] = 32'hffffa809;

    // Index 29: -20.39 deg (-0.3559 rad) -> -23323
    rom[ 29] = 32'hffffa4e5;

    // Index 30: -21.09 deg (-0.3682 rad) -> -24127
    rom[ 30] = 32'hffffa1c1;

    // Index 31: -21.80 deg (-0.3805 rad) -> -24932
    rom[ 31] = 32'hffff9e9c;

    // Index 32: -22.50 deg (-0.3927 rad) -> -25736
    rom[ 32] = 32'hffff9b78;

    // Index 33: -23.20 deg (-0.4050 rad) -> -26540
    rom[ 33] = 32'hffff9854;

    // Index 34: -23.91 deg (-0.4172 rad) -> -27344
    rom[ 34] = 32'hffff9530;

    // Index 35: -24.61 deg (-0.4295 rad) -> -28149
    rom[ 35] = 32'hffff920b;

    // Index 36: -25.31 deg (-0.4418 rad) -> -28953
    rom[ 36] = 32'hffff8ee7;

    // Index 37: -26.02 deg (-0.4541 rad) -> -29757
    rom[ 37] = 32'hffff8bc3;

    // Index 38: -26.72 deg (-0.4663 rad) -> -30561
    rom[ 38] = 32'hffff889f;

    // Index 39: -27.42 deg (-0.4786 rad) -> -31366
    rom[ 39] = 32'hffff857a;

    // Index 40: -28.12 deg (-0.4909 rad) -> -32170
    rom[ 40] = 32'hffff8256;

    // Index 41: -28.83 deg (-0.5031 rad) -> -32974
    rom[ 41] = 32'hffff7f32;

    // Index 42: -29.53 deg (-0.5154 rad) -> -33778
    rom[ 42] = 32'hffff7c0e;

    // Index 43: -30.23 deg (-0.5277 rad) -> -34583
    rom[ 43] = 32'hffff78e9;

    // Index 44: -30.94 deg (-0.5400 rad) -> -35387
    rom[ 44] = 32'hffff75c5;

    // Index 45: -31.64 deg (-0.5522 rad) -> -36191
    rom[ 45] = 32'hffff72a1;

    // Index 46: -32.34 deg (-0.5645 rad) -> -36995
    rom[ 46] = 32'hffff6f7d;

    // Index 47: -33.05 deg (-0.5768 rad) -> -37800
    rom[ 47] = 32'hffff6c58;

    // Index 48: -33.75 deg (-0.5890 rad) -> -38604
    rom[ 48] = 32'hffff6934;

    // Index 49: -34.45 deg (-0.6013 rad) -> -39408
    rom[ 49] = 32'hffff6610;

    // Index 50: -35.16 deg (-0.6136 rad) -> -40212
    rom[ 50] = 32'hffff62ec;

    // Index 51: -35.86 deg (-0.6259 rad) -> -41017
    rom[ 51] = 32'hffff5fc7;

    // Index 52: -36.56 deg (-0.6381 rad) -> -41821
    rom[ 52] = 32'hffff5ca3;

    // Index 53: -37.27 deg (-0.6504 rad) -> -42625
    rom[ 53] = 32'hffff597f;

    // Index 54: -37.97 deg (-0.6627 rad) -> -43429
    rom[ 54] = 32'hffff565b;

    // Index 55: -38.67 deg (-0.6750 rad) -> -44234
    rom[ 55] = 32'hffff5336;

    // Index 56: -39.38 deg (-0.6872 rad) -> -45038
    rom[ 56] = 32'hffff5012;

    // Index 57: -40.08 deg (-0.6995 rad) -> -45842
    rom[ 57] = 32'hffff4cee;

    // Index 58: -40.78 deg (-0.7118 rad) -> -46646
    rom[ 58] = 32'hffff49ca;

    // Index 59: -41.48 deg (-0.7241 rad) -> -47451
    rom[ 59] = 32'hffff46a5;

    // Index 60: -42.19 deg (-0.7363 rad) -> -48255
    rom[ 60] = 32'hffff4381;

    // Index 61: -42.89 deg (-0.7486 rad) -> -49059
    rom[ 61] = 32'hffff405d;

    // Index 62: -43.59 deg (-0.7609 rad) -> -49863
    rom[ 62] = 32'hffff3d39;

    // Index 63: -44.30 deg (-0.7732 rad) -> -50668
    rom[ 63] = 32'hffff3a14;

    // Index 64: -45.00 deg (-0.7854 rad) -> -51472
    rom[ 64] = 32'hffff36f0;

    // Index 65: -45.70 deg (-0.7977 rad) -> -52276
    rom[ 65] = 32'hffff33cc;

    // Index 66: -46.41 deg (-0.8099 rad) -> -53080
    rom[ 66] = 32'hffff30a8;

    // Index 67: -47.11 deg (-0.8222 rad) -> -53885
    rom[ 67] = 32'hffff2d83;

    // Index 68: -47.81 deg (-0.8345 rad) -> -54689
    rom[ 68] = 32'hffff2a5f;

    // Index 69: -48.52 deg (-0.8468 rad) -> -55493
    rom[ 69] = 32'hffff273b;

    // Index 70: -49.22 deg (-0.8590 rad) -> -56297
    rom[ 70] = 32'hffff2417;

    // Index 71: -49.92 deg (-0.8713 rad) -> -57102
    rom[ 71] = 32'hffff20f2;

    // Index 72: -50.62 deg (-0.8836 rad) -> -57906
    rom[ 72] = 32'hffff1dce;

    // Index 73: -51.33 deg (-0.8959 rad) -> -58710
    rom[ 73] = 32'hffff1aaa;

    // Index 74: -52.03 deg (-0.9081 rad) -> -59514
    rom[ 74] = 32'hffff1786;

    // Index 75: -52.73 deg (-0.9204 rad) -> -60319
    rom[ 75] = 32'hffff1461;

    // Index 76: -53.44 deg (-0.9327 rad) -> -61123
    rom[ 76] = 32'hffff113d;

    // Index 77: -54.14 deg (-0.9449 rad) -> -61927
    rom[ 77] = 32'hffff0e19;

    // Index 78: -54.84 deg (-0.9572 rad) -> -62731
    rom[ 78] = 32'hffff0af5;

    // Index 79: -55.55 deg (-0.9695 rad) -> -63536
    rom[ 79] = 32'hffff07d0;

    // Index 80: -56.25 deg (-0.9817 rad) -> -64340
    rom[ 80] = 32'hffff04ac;

    // Index 81: -56.95 deg (-0.9940 rad) -> -65144
    rom[ 81] = 32'hfffef188;

    // Index 82: -57.66 deg (-1.0063 rad) -> -65948
    rom[ 82] = 32'hfffefe64;

    // Index 83: -58.36 deg (-1.0186 rad) -> -66753
    rom[ 83] = 32'hfffefb3f;

    // Index 84: -59.06 deg (-1.0308 rad) -> -67557
    rom[ 84] = 32'hfffef81b;

    // Index 85: -59.77 deg (-1.0431 rad) -> -68361
    rom[ 85] = 32'hfffef4f7;

    // Index 86: -60.47 deg (-1.0554 rad) -> -69165
    rom[ 86] = 32'hfffef1d3;

    // Index 87: -61.17 deg (-1.0677 rad) -> -69970
    rom[ 87] = 32'hfffeeeae;

    // Index 88: -61.87 deg (-1.0799 rad) -> -70774
    rom[ 88] = 32'hfffeeb8a;

    // Index 89: -62.58 deg (-1.0922 rad) -> -71578
    rom[ 89] = 32'hfffee866;

    // Index 90: -63.28 deg (-1.1045 rad) -> -72382
    rom[ 90] = 32'hfffee542;

    // Index 91: -63.98 deg (-1.1168 rad) -> -73187
    rom[ 91] = 32'hfffee21d;

    // Index 92: -64.69 deg (-1.1290 rad) -> -73991
    rom[ 92] = 32'hfffedef9;

    // Index 93: -65.39 deg (-1.1413 rad) -> -74795
    rom[ 93] = 32'hfffedbd5;

    // Index 94: -66.09 deg (-1.1536 rad) -> -75599
    rom[ 94] = 32'hfffed8b1;

    // Index 95: -66.80 deg (-1.1659 rad) -> -76404
    rom[ 95] = 32'hfffed58c;

    // Index 96: -67.50 deg (-1.1781 rad) -> -77208
    rom[ 96] = 32'hfffed268;

    // Index 97: -68.20 deg (-1.1904 rad) -> -78012
    rom[ 97] = 32'hfffece44;

    // Index 98: -68.91 deg (-1.2026 rad) -> -78816
    rom[ 98] = 32'hfffecc20;

    // Index 99: -69.61 deg (-1.2149 rad) -> -79621
    rom[ 99] = 32'hfffec8fb;

    // Index 100: -70.31 deg (-1.2272 rad) -> -80425
    rom[ 100] = 32'hfffec5d7;

    // Index 101: -71.02 deg (-1.2395 rad) -> -81229
    rom[ 101] = 32'hfffec2b3;

    // Index 102: -71.72 deg (-1.2517 rad) -> -82033
    rom[ 102] = 32'hfffebf8f;

    // Index 103: -72.42 deg (-1.2640 rad) -> -82838
    rom[ 103] = 32'hfffebc6a;

    // Index 104: -73.12 deg (-1.2763 rad) -> -83642
    rom[ 104] = 32'hfffeb946;

    // Index 105: -73.83 deg (-1.2886 rad) -> -84446
    rom[ 105] = 32'hfffeb622;

    // Index 106: -74.53 deg (-1.3008 rad) -> -85250
    rom[ 106] = 32'hfffeb2fe;

    // Index 107: -75.23 deg (-1.3131 rad) -> -86055
    rom[ 107] = 32'hfffeafd9;

    // Index 108: -75.94 deg (-1.3254 rad) -> -86859
    rom[ 108] = 32'hfffeacb5;

    // Index 109: -76.64 deg (-1.3377 rad) -> -87663
    rom[ 109] = 32'hfffea991;

    // Index 110: -77.34 deg (-1.3499 rad) -> -88467
    rom[ 110] = 32'hfffea66d;

    // Index 111: -78.05 deg (-1.3622 rad) -> -89272
    rom[ 111] = 32'hfffea348;

    // Index 112: -78.75 deg (-1.3744 rad) -> -90076
    rom[ 112] = 32'hfffea024;

    // Index 113: -79.45 deg (-1.3867 rad) -> -90880
    rom[ 113] = 32'hfffe9d00;

    // Index 114: -80.16 deg (-1.3990 rad) -> -91684
    rom[ 114] = 32'hfffe99dc;

    // Index 115: -80.86 deg (-1.4113 rad) -> -92489
    rom[ 115] = 32'hfffe96b7;

    // Index 116: -81.56 deg (-1.4235 rad) -> -93293
    rom[ 116] = 32'hfffe9393;

    // Index 117: -82.27 deg (-1.4358 rad) -> -94097
    rom[ 117] = 32'hfffe906f;

    // Index 118: -82.97 deg (-1.4481 rad) -> -94901
    rom[ 118] = 32'hfffe8d4b;

    // Index 119: -83.67 deg (-1.4604 rad) -> -95706
    rom[ 119] = 32'hfffe8a26;

    // Index 120: -84.38 deg (-1.4726 rad) -> -96510
    rom[ 120] = 32'hfffe8702;

    // Index 121: -85.08 deg (-1.4849 rad) -> -97314
    rom[ 121] = 32'hfffe83de;

    // Index 122: -85.78 deg (-1.4972 rad) -> -98118
    rom[ 122] = 32'hfffe80ba;

    // Index 123: -86.48 deg (-1.5095 rad) -> -98923
    rom[ 123] = 32'hfffe7d95;

    // Index 124: -87.19 deg (-1.5217 rad) -> -99727
    rom[ 124] = 32'hfffe7a71;

    // Index 125: -87.89 deg (-1.5340 rad) -> -100531
    rom[ 125] = 32'hfffe774d;

    // Index 126: -88.59 deg (-1.5463 rad) -> -101335
    rom[ 126] = 32'hfffe7429;

    // Index 127: -89.30 deg (-1.5586 rad) -> -102140
    rom[ 127] = 32'hfffe7104;

    // Index 128: -90.00 deg (-1.5708 rad) -> -102944
    rom[ 128] = 32'hfffe6de0;

    // Index 129: -90.70 deg (-1.5831 rad) -> -103748
    rom[ 129] = 32'hfffe6abc;

    // Index 130: -91.41 deg (-1.5953 rad) -> -104552
    rom[ 130] = 32'hfffe6798;

    // Index 131: -92.11 deg (-1.6076 rad) -> -105357
    rom[ 131] = 32'hfffe6473;

    // Index 132: -92.81 deg (-1.6199 rad) -> -106161
    rom[ 132] = 32'hfffe614f;

    // Index 133: -93.52 deg (-1.6322 rad) -> -106965
    rom[ 133] = 32'hfffe5e2b;

    // Index 134: -94.22 deg (-1.6444 rad) -> -107769
    rom[ 134] = 32'hfffe5b07;

    // Index 135: -94.92 deg (-1.6567 rad) -> -108574
    rom[ 135] = 32'hfffe57e2;

    // Index 136: -95.62 deg (-1.6690 rad) -> -109378
    rom[ 136] = 32'hfffe54be;

    // Index 137: -96.33 deg (-1.6812 rad) -> -110182
    rom[ 137] = 32'hfffe519a;

    // Index 138: -97.03 deg (-1.6935 rad) -> -110986
    rom[ 138] = 32'hfffe4e76;

    // Index 139: -97.73 deg (-1.7058 rad) -> -111791
    rom[ 139] = 32'hfffe4b51;

    // Index 140: -98.44 deg (-1.7181 rad) -> -112595
    rom[ 140] = 32'hfffe482d;

    // Index 141: -99.14 deg (-1.7303 rad) -> -113399
    rom[ 141] = 32'hfffe4509;

    // Index 142: -99.84 deg (-1.7426 rad) -> -114203
    rom[ 142] = 32'hfffe41e5;

    // Index 143: -100.55 deg (-1.7549 rad) -> -115008
    rom[ 143] = 32'hfffe3ec0;

    // Index 144: -101.25 deg (-1.7671 rad) -> -115812
    rom[ 144] = 32'hfffe3b9c;

    // Index 145: -101.95 deg (-1.7794 rad) -> -116616
    rom[ 145] = 32'hfffe3878;

    // Index 146: -102.66 deg (-1.7917 rad) -> -117420
    rom[ 146] = 32'hfffe3554;

    // Index 147: -103.36 deg (-1.8040 rad) -> -118225
    rom[ 147] = 32'hfffe322f;

    // Index 148: -104.06 deg (-1.8162 rad) -> -119029
    rom[ 148] = 32'hfffe2f0b;

    // Index 149: -104.77 deg (-1.8285 rad) -> -119833
    rom[ 149] = 32'hfffe2be7;

    // Index 150: -105.47 deg (-1.8408 rad) -> -120637
    rom[ 150] = 32'hfffe28c3;

    // Index 151: -106.17 deg (-1.8531 rad) -> -121442
    rom[ 151] = 32'hfffe259e;

    // Index 152: -106.88 deg (-1.8653 rad) -> -122246
    rom[ 152] = 32'hfffe227a;

    // Index 153: -107.58 deg (-1.8776 rad) -> -123050
    rom[ 153] = 32'hfffe1f56;

    // Index 154: -108.28 deg (-1.8899 rad) -> -123854
    rom[ 154] = 32'hfffe1c32;

    // Index 155: -108.98 deg (-1.9021 rad) -> -124659
    rom[ 155] = 32'hfffe190d;

    // Index 156: -109.69 deg (-1.9144 rad) -> -125463
    rom[ 156] = 32'hfffe15e9;

    // Index 157: -110.39 deg (-1.9267 rad) -> -126267
    rom[ 157] = 32'hfffe12c5;

    // Index 158: -111.09 deg (-1.9390 rad) -> -127071
    rom[ 158] = 32'hfffe0fa1;

    // Index 159: -111.80 deg (-1.9512 rad) -> -127876
    rom[ 159] = 32'hfffe0c7c;

    // Index 160: -112.50 deg (-1.9635 rad) -> -128680
    rom[ 160] = 32'hfffe0958;

    // Index 161: -113.20 deg (-1.9758 rad) -> -129484
    rom[ 161] = 32'hfffe0634;

    // Index 162: -113.91 deg (-1.9880 rad) -> -130288
    rom[ 162] = 32'hfffe0310;

    // Index 163: -114.61 deg (-2.0003 rad) -> -131093
    rom[ 163] = 32'hfffdffeb;

    // Index 164: -115.31 deg (-2.0126 rad) -> -131897
    rom[ 164] = 32'hfffdfcc7;

    // Index 165: -116.02 deg (-2.0249 rad) -> -132701
    rom[ 165] = 32'hfffdf9a3;

    // Index 166: -116.72 deg (-2.0371 rad) -> -133505
    rom[ 166] = 32'hfffdf67f;

    // Index 167: -117.42 deg (-2.0494 rad) -> -134310
    rom[ 167] = 32'hfffdf35a;

    // Index 168: -118.12 deg (-2.0617 rad) -> -135114
    rom[ 168] = 32'hfffdf036;

    // Index 169: -118.83 deg (-2.0739 rad) -> -135918
    rom[ 169] = 32'hfffdec12;

    // Index 170: -119.53 deg (-2.0862 rad) -> -136722
    rom[ 170] = 32'hfffde9ee;

    // Index 171: -120.23 deg (-2.0985 rad) -> -137527
    rom[ 171] = 32'hfffde6c9;

    // Index 172: -120.94 deg (-2.1108 rad) -> -138331
    rom[ 172] = 32'hfffde3a5;

    // Index 173: -121.64 deg (-2.1230 rad) -> -139135
    rom[ 173] = 32'hfffde081;

    // Index 174: -122.34 deg (-2.1353 rad) -> -139939
    rom[ 174] = 32'hfffddd5d;

    // Index 175: -123.05 deg (-2.1476 rad) -> -140744
    rom[ 175] = 32'hfffdda38;

    // Index 176: -123.75 deg (-2.1598 rad) -> -141548
    rom[ 176] = 32'hfffdd714;

    // Index 177: -124.45 deg (-2.1721 rad) -> -142352
    rom[ 177] = 32'hfffdd3f0;

    // Index 178: -125.16 deg (-2.1844 rad) -> -143156
    rom[ 178] = 32'hfffdd0cc;

    // Index 179: -125.86 deg (-2.1967 rad) -> -143961
    rom[ 179] = 32'hfffdcda7;

    // Index 180: -126.56 deg (-2.2089 rad) -> -144765
    rom[ 180] = 32'hfffdea83;

    // Index 181: -127.27 deg (-2.2212 rad) -> -145569
    rom[ 181] = 32'hfffde75f;

    // Index 182: -127.97 deg (-2.2335 rad) -> -146373
    rom[ 182] = 32'hfffde43b;

    // Index 183: -128.67 deg (-2.2458 rad) -> -147178
    rom[ 183] = 32'hfffde116;

    // Index 184: -129.38 deg (-2.2580 rad) -> -147982
    rom[ 184] = 32'hfffdbdf2;

    // Index 185: -130.08 deg (-2.2703 rad) -> -148786
    rom[ 185] = 32'hfffdbace;

    // Index 186: -130.78 deg (-2.2826 rad) -> -149590
    rom[ 186] = 32'hfffdb7aa;

    // Index 187: -131.48 deg (-2.2949 rad) -> -150395
    rom[ 187] = 32'hfffdb485;

    // Index 188: -132.19 deg (-2.3071 rad) -> -151199
    rom[ 188] = 32'hfffdb161;

    // Index 189: -132.89 deg (-2.3194 rad) -> -152003
    rom[ 189] = 32'hfffdae3d;

    // Index 190: -133.59 deg (-2.3317 rad) -> -152807
    rom[ 190] = 32'hfffdab19;

    // Index 191: -134.30 deg (-2.3440 rad) -> -153612
    rom[ 191] = 32'hfffda7f4;

    // Index 192: -135.00 deg (-2.3562 rad) -> -154416
    rom[ 192] = 32'hfffda4d0;

    // Index 193: -135.70 deg (-2.3685 rad) -> -155220
    rom[ 193] = 32'hfffda1ac;

    // Index 194: -136.41 deg (-2.3807 rad) -> -156024
    rom[ 194] = 32'hfffd9e88;

    // Index 195: -137.11 deg (-2.3930 rad) -> -156829
    rom[ 195] = 32'hfffd9b63;

    // Index 196: -137.81 deg (-2.4053 rad) -> -157633
    rom[ 196] = 32'hfffd983f;

    // Index 197: -138.52 deg (-2.4176 rad) -> -158437
    rom[ 197] = 32'hfffd951b;

    // Index 198: -139.22 deg (-2.4298 rad) -> -159241
    rom[ 198] = 32'hfffd91f7;

    // Index 199: -139.92 deg (-2.4421 rad) -> -160046
    rom[ 199] = 32'hfffd8ed2;

    // Index 200: -140.62 deg (-2.4544 rad) -> -160850
    rom[ 200] = 32'hfffd8bae;

    // Index 201: -141.33 deg (-2.4667 rad) -> -161654
    rom[ 201] = 32'hfffd888a;

    // Index 202: -142.03 deg (-2.4789 rad) -> -162458
    rom[ 202] = 32'hfffd8566;

    // Index 203: -142.73 deg (-2.4912 rad) -> -163263
    rom[ 203] = 32'hfffd8241;

    // Index 204: -143.44 deg (-2.5035 rad) -> -164067
    rom[ 204] = 32'hfffd7f1d;

    // Index 205: -144.14 deg (-2.5157 rad) -> -164871
    rom[ 205] = 32'hfffd7bf9;

    // Index 206: -144.84 deg (-2.5280 rad) -> -165675
    rom[ 206] = 32'hfffd78d5;

    // Index 207: -145.55 deg (-2.5403 rad) -> -166480
    rom[ 207] = 32'hfffd75b0;

    // Index 208: -146.25 deg (-2.5525 rad) -> -167284
    rom[ 208] = 32'hfffd728c;

    // Index 209: -146.95 deg (-2.5648 rad) -> -168088
    rom[ 209] = 32'hfffd6f68;

    // Index 210: -147.66 deg (-2.5771 rad) -> -168892
    rom[ 210] = 32'hfffd6c44;

    // Index 211: -148.36 deg (-2.5894 rad) -> -169697
    rom[ 211] = 32'hfffd691f;

    // Index 212: -149.06 deg (-2.6016 rad) -> -170501
    rom[ 212] = 32'hfffd65fb;

    // Index 213: -149.77 deg (-2.6139 rad) -> -171305
    rom[ 213] = 32'hfffd62d7;

    // Index 214: -150.47 deg (-2.6262 rad) -> -172109
    rom[ 214] = 32'hfffd5fb3;

    // Index 215: -151.17 deg (-2.6384 rad) -> -172914
    rom[ 215] = 32'hfffd5c8e;

    // Index 216: -151.88 deg (-2.6507 rad) -> -173718
    rom[ 216] = 32'hfffd596a;

    // Index 217: -152.58 deg (-2.6630 rad) -> -174522
    rom[ 217] = 32'hfffd5646;

    // Index 218: -153.28 deg (-2.6753 rad) -> -175326
    rom[ 218] = 32'hfffd5322;

    // Index 219: -153.98 deg (-2.6875 rad) -> -176131
    rom[ 219] = 32'hfffd4ffd;

    // Index 220: -154.69 deg (-2.6998 rad) -> -176935
    rom[ 220] = 32'hfffd4cd9;

    // Index 221: -155.39 deg (-2.7121 rad) -> -177739
    rom[ 221] = 32'hfffd49b5;

    // Index 222: -156.09 deg (-2.7243 rad) -> -178543
    rom[ 222] = 32'hfffd4691;

    // Index 223: -156.80 deg (-2.7366 rad) -> -179348
    rom[ 223] = 32'hfffd436c;

    // Index 224: -157.50 deg (-2.7489 rad) -> -180152
    rom[ 224] = 32'hfffd4048;

    // Index 225: -158.20 deg (-2.7612 rad) -> -180956
    rom[ 225] = 32'hfffd3d24;

    // Index 226: -158.91 deg (-2.7734 rad) -> -181760
    rom[ 226] = 32'hfffd3a00;

    // Index 227: -159.61 deg (-2.7857 rad) -> -182564
    rom[ 227] = 32'hfffd36dc;

    // Index 228: -160.31 deg (-2.7980 rad) -> -183368
    rom[ 228] = 32'hfffd33b8;

    // Index 229: -161.02 deg (-2.8102 rad) -> -184173
    rom[ 229] = 32'hfffd3093;

    // Index 230: -161.72 deg (-2.8225 rad) -> -184977
    rom[ 230] = 32'hfffd2d6f;

    // Index 231: -162.42 deg (-2.8348 rad) -> -185781
    rom[ 231] = 32'hfffd2a4b;

    // Index 232: -163.12 deg (-2.8471 rad) -> -186586
    rom[ 232] = 32'hfffd2726;

    // Index 233: -163.83 deg (-2.8593 rad) -> -187390
    rom[ 233] = 32'hfffd2402;

    // Index 234: -164.53 deg (-2.8716 rad) -> -188194
    rom[ 234] = 32'hfffd20de;

    // Index 235: -165.23 deg (-2.8839 rad) -> -188998
    rom[ 235] = 32'hfffd1dba;

    // Index 236: -165.94 deg (-2.8962 rad) -> -189802
    rom[ 236] = 32'hfffd1a96;

    // Index 237: -166.64 deg (-2.9084 rad) -> -190607
    rom[ 237] = 32'hfffd1771;

    // Index 238: -167.34 deg (-2.9207 rad) -> -191411
    rom[ 238] = 32'hfffd144d;

    // Index 239: -168.05 deg (-2.9330 rad) -> -192215
    rom[ 239] = 32'hfffd1129;

    // Index 240: -168.75 deg (-2.9452 rad) -> -193019
    rom[ 240] = 32'hfffd0e05;

    // Index 241: -169.45 deg (-2.9575 rad) -> -193823
    rom[ 241] = 32'hfffd0ae1;

    // Index 242: -170.16 deg (-2.9698 rad) -> -194628
    rom[ 242] = 32'hfffd07bc;

    // Index 243: -170.86 deg (-2.9821 rad) -> -195432
    rom[ 243] = 32'hfffd0498;

    // Index 244: -171.56 deg (-2.9943 rad) -> -196236
    rom[ 244] = 32'hfffd0174;

    // Index 245: -172.27 deg (-3.0066 rad) -> -197040
    rom[ 245] = 32'hfffcfe50;

    // Index 246: -172.97 deg (-3.0189 rad) -> -197845
    rom[ 246] = 32'hfffcfb2b;

    // Index 247: -173.67 deg (-3.0311 rad) -> -198649
    rom[ 247] = 32'hfffcf807;

    // Index 248: -174.38 deg (-3.0434 rad) -> -199453
    rom[ 248] = 32'hfffcf4e3;

    // Index 249: -175.08 deg (-3.0557 rad) -> -200257
    rom[ 249] = 32'hfffcf1bf;

    // Index 250: -175.78 deg (-3.0680 rad) -> -201062
    rom[ 250] = 32'hfffce89a;

    // Index 251: -176.48 deg (-3.0802 rad) -> -201866
    rom[ 251] = 32'hfffce576;

    // Index 252: -177.19 deg (-3.0925 rad) -> -202670
    rom[ 252] = 32'hfffce252;

    // Index 253: -177.89 deg (-3.1048 rad) -> -203474
    rom[ 253] = 32'hfffcdf2e;

    // Index 254: -178.59 deg (-3.1171 rad) -> -204279
    rom[ 254] = 32'hfffcdc09;

    // Index 255: -179.30 deg (-3.1293 rad) -> -205083
    rom[ 255] = 32'hfffcd8e5;
end

always @(posedge i_clk) begin
    o_data <= rom[i_addr];
end

endmodule
