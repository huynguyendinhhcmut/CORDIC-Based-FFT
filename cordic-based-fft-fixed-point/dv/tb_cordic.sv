`timescale 1ns/1ps

module tb_cordic;

    //==== 1. Khai báo tín hiệu ====
    logic i_clk = 0;
    logic i_reset = 0;

    // Inputs
    logic [31:0] i_x;
    logic [31:0] i_y;
    logic [31:0] i_z;

    // Outputs
    logic [31:0] o_x;
    logic [31:0] o_y;

    //==== 2. Kết nối DUT ====
    cordic dut (
        .i_clk(i_clk),
        .i_reset(i_reset),
        .i_x(i_x),
        .i_y(i_y),
        .i_z(i_z),
        .o_x(o_x),
        .o_y(o_y)
    );

    //==== 3. Tạo xung Clock ====
    initial begin
        i_clk = 0;
        forever #1 i_clk = ~i_clk;
    end

    //==== 4. Kịch bản kiểm tra ====
    initial begin
        $dumpfile("cordic_wave.vcd");
        $dumpvars(0, tb_cordic);

        // Reset hệ thống
        i_reset = 0;
        i_x = 32'h0; i_y = 32'h0; i_z = 32'h0;

        #4 i_reset = 1;

        // Chạy test pipeline
        run_pipelined_test();

        #20;
        $finish;
    end

    //==== 5. Task chạy test Pipeline ====
    task run_pipelined_test;
        integer k; // Biến chạy cho Driver
        integer m; // Biến chạy cho Monitor
        reg [31:0] test_angles [0:360];
        begin
            // --- NẠP DỮ LIỆU GÓC (GIỮ NGUYÊN DATA CỦA BẠN) ---
            // Table of angles 0-360 degrees in Radians (Q16.16 Fixed Point)
            // Scaling Factor: 2^16 = 65536
            test_angles[0] = 32'h00000000; // 0 deg ~= 0.00000 rad
            test_angles[1] = 32'h00000478; // 1 deg ~= 0.01745 rad
            test_angles[2] = 32'h000008F0; // 2 deg ~= 0.03491 rad
            test_angles[3] = 32'h00000D67; // 3 deg ~= 0.05236 rad
            test_angles[4] = 32'h000011DF; // 4 deg ~= 0.06981 rad
            test_angles[5] = 32'h00001657; // 5 deg ~= 0.08727 rad
            test_angles[6] = 32'h00001ACF; // 6 deg ~= 0.10472 rad
            test_angles[7] = 32'h00001F47; // 7 deg ~= 0.12217 rad
            test_angles[8] = 32'h000023BF; // 8 deg ~= 0.13963 rad
            test_angles[9] = 32'h00002836; // 9 deg ~= 0.15708 rad
            test_angles[10] = 32'h00002CAE; // 10 deg ~= 0.17453 rad
            test_angles[11] = 32'h00003126; // 11 deg ~= 0.19199 rad
            test_angles[12] = 32'h0000359E; // 12 deg ~= 0.20944 rad
            test_angles[13] = 32'h00003A16; // 13 deg ~= 0.22689 rad
            test_angles[14] = 32'h00003E8D; // 14 deg ~= 0.24435 rad
            test_angles[15] = 32'h00004305; // 15 deg ~= 0.26180 rad
            test_angles[16] = 32'h0000477D; // 16 deg ~= 0.27925 rad
            test_angles[17] = 32'h00004BF5; // 17 deg ~= 0.29671 rad
            test_angles[18] = 32'h0000506D; // 18 deg ~= 0.31416 rad
            test_angles[19] = 32'h000054E5; // 19 deg ~= 0.33161 rad
            test_angles[20] = 32'h0000595C; // 20 deg ~= 0.34907 rad
            test_angles[21] = 32'h00005DD4; // 21 deg ~= 0.36652 rad
            test_angles[22] = 32'h0000624C; // 22 deg ~= 0.38397 rad
            test_angles[23] = 32'h000066C4; // 23 deg ~= 0.40143 rad
            test_angles[24] = 32'h00006B3C; // 24 deg ~= 0.41888 rad
            test_angles[25] = 32'h00006FB3; // 25 deg ~= 0.43633 rad
            test_angles[26] = 32'h0000742B; // 26 deg ~= 0.45379 rad
            test_angles[27] = 32'h000078A3; // 27 deg ~= 0.47124 rad
            test_angles[28] = 32'h00007D1B; // 28 deg ~= 0.48869 rad
            test_angles[29] = 32'h00008193; // 29 deg ~= 0.50615 rad
            test_angles[30] = 32'h0000860B; // 30 deg ~= 0.52360 rad
            test_angles[31] = 32'h00008A82; // 31 deg ~= 0.54105 rad
            test_angles[32] = 32'h00008EFA; // 32 deg ~= 0.55851 rad
            test_angles[33] = 32'h00009372; // 33 deg ~= 0.57596 rad
            test_angles[34] = 32'h000097EA; // 34 deg ~= 0.59341 rad
            test_angles[35] = 32'h00009C62; // 35 deg ~= 0.61087 rad
            test_angles[36] = 32'h0000A0D9; // 36 deg ~= 0.62832 rad
            test_angles[37] = 32'h0000A551; // 37 deg ~= 0.64577 rad
            test_angles[38] = 32'h0000A9C9; // 38 deg ~= 0.66323 rad
            test_angles[39] = 32'h0000AE41; // 39 deg ~= 0.68068 rad
            test_angles[40] = 32'h0000B2B9; // 40 deg ~= 0.69813 rad
            test_angles[41] = 32'h0000B731; // 41 deg ~= 0.71558 rad
            test_angles[42] = 32'h0000BBA8; // 42 deg ~= 0.73304 rad
            test_angles[43] = 32'h0000C020; // 43 deg ~= 0.75049 rad
            test_angles[44] = 32'h0000C498; // 44 deg ~= 0.76794 rad
            test_angles[45] = 32'h0000C910; // 45 deg ~= 0.78540 rad
            test_angles[46] = 32'h0000CD88; // 46 deg ~= 0.80285 rad
            test_angles[47] = 32'h0000D1FF; // 47 deg ~= 0.82030 rad
            test_angles[48] = 32'h0000D677; // 48 deg ~= 0.83776 rad
            test_angles[49] = 32'h0000DAEF; // 49 deg ~= 0.85521 rad
            test_angles[50] = 32'h0000DF67; // 50 deg ~= 0.87266 rad
            test_angles[51] = 32'h0000E3DF; // 51 deg ~= 0.89012 rad
            test_angles[52] = 32'h0000E857; // 52 deg ~= 0.90757 rad
            test_angles[53] = 32'h0000ECCE; // 53 deg ~= 0.92502 rad
            test_angles[54] = 32'h0000F146; // 54 deg ~= 0.94248 rad
            test_angles[55] = 32'h0000F5BE; // 55 deg ~= 0.95993 rad
            test_angles[56] = 32'h0000FA36; // 56 deg ~= 0.97738 rad
            test_angles[57] = 32'h0000FEAE; // 57 deg ~= 0.99484 rad
            test_angles[58] = 32'h00010326; // 58 deg ~= 1.01229 rad
            test_angles[59] = 32'h0001079D; // 59 deg ~= 1.02974 rad
            test_angles[60] = 32'h00010C15; // 60 deg ~= 1.04720 rad
            test_angles[61] = 32'h0001108D; // 61 deg ~= 1.06465 rad
            test_angles[62] = 32'h00011505; // 62 deg ~= 1.08210 rad
            test_angles[63] = 32'h0001197D; // 63 deg ~= 1.09956 rad
            test_angles[64] = 32'h00011DF4; // 64 deg ~= 1.11701 rad
            test_angles[65] = 32'h0001226C; // 65 deg ~= 1.13446 rad
            test_angles[66] = 32'h000126E4; // 66 deg ~= 1.15192 rad
            test_angles[67] = 32'h00012B5C; // 67 deg ~= 1.16937 rad
            test_angles[68] = 32'h00012FD4; // 68 deg ~= 1.18682 rad
            test_angles[69] = 32'h0001344C; // 69 deg ~= 1.20428 rad
            test_angles[70] = 32'h000138C3; // 70 deg ~= 1.22173 rad
            test_angles[71] = 32'h00013D3B; // 71 deg ~= 1.23918 rad
            test_angles[72] = 32'h000141B3; // 72 deg ~= 1.25664 rad
            test_angles[73] = 32'h0001462B; // 73 deg ~= 1.27409 rad
            test_angles[74] = 32'h00014AA3; // 74 deg ~= 1.29154 rad
            test_angles[75] = 32'h00014F1A; // 75 deg ~= 1.30900 rad
            test_angles[76] = 32'h00015392; // 76 deg ~= 1.32645 rad
            test_angles[77] = 32'h0001580A; // 77 deg ~= 1.34390 rad
            test_angles[78] = 32'h00015C82; // 78 deg ~= 1.36136 rad
            test_angles[79] = 32'h000160FA; // 79 deg ~= 1.37881 rad
            test_angles[80] = 32'h00016572; // 80 deg ~= 1.39626 rad
            test_angles[81] = 32'h000169E9; // 81 deg ~= 1.41372 rad
            test_angles[82] = 32'h00016E61; // 82 deg ~= 1.43117 rad
            test_angles[83] = 32'h000172D9; // 83 deg ~= 1.44862 rad
            test_angles[84] = 32'h00017751; // 84 deg ~= 1.46608 rad
            test_angles[85] = 32'h00017BC9; // 85 deg ~= 1.48353 rad
            test_angles[86] = 32'h00018040; // 86 deg ~= 1.50098 rad
            test_angles[87] = 32'h000184B8; // 87 deg ~= 1.51844 rad
            test_angles[88] = 32'h00018930; // 88 deg ~= 1.53589 rad
            test_angles[89] = 32'h00018DA8; // 89 deg ~= 1.55334 rad
            test_angles[90] = 32'h00019220; // 90 deg ~= 1.57080 rad
            test_angles[91] = 32'h00019698; // 91 deg ~= 1.58825 rad
            test_angles[92] = 32'h00019B0F; // 92 deg ~= 1.60570 rad
            test_angles[93] = 32'h00019F87; // 93 deg ~= 1.62316 rad
            test_angles[94] = 32'h0001A3FF; // 94 deg ~= 1.64061 rad
            test_angles[95] = 32'h0001A877; // 95 deg ~= 1.65806 rad
            test_angles[96] = 32'h0001ACEF; // 96 deg ~= 1.67552 rad
            test_angles[97] = 32'h0001B166; // 97 deg ~= 1.69297 rad
            test_angles[98] = 32'h0001B5DE; // 98 deg ~= 1.71042 rad
            test_angles[99] = 32'h0001BA56; // 99 deg ~= 1.72788 rad
            test_angles[100] = 32'h0001BECE; // 100 deg ~= 1.74533 rad
            test_angles[101] = 32'h0001C346; // 101 deg ~= 1.76278 rad
            test_angles[102] = 32'h0001C7BE; // 102 deg ~= 1.78024 rad
            test_angles[103] = 32'h0001CC35; // 103 deg ~= 1.79769 rad
            test_angles[104] = 32'h0001D0AD; // 104 deg ~= 1.81514 rad
            test_angles[105] = 32'h0001D525; // 105 deg ~= 1.83260 rad
            test_angles[106] = 32'h0001D99D; // 106 deg ~= 1.85005 rad
            test_angles[107] = 32'h0001DE15; // 107 deg ~= 1.86750 rad
            test_angles[108] = 32'h0001E28C; // 108 deg ~= 1.88496 rad
            test_angles[109] = 32'h0001E704; // 109 deg ~= 1.90241 rad
            test_angles[110] = 32'h0001EB7C; // 110 deg ~= 1.91986 rad
            test_angles[111] = 32'h0001EFF4; // 111 deg ~= 1.93732 rad
            test_angles[112] = 32'h0001F46C; // 112 deg ~= 1.95477 rad
            test_angles[113] = 32'h0001F8E4; // 113 deg ~= 1.97222 rad
            test_angles[114] = 32'h0001FD5B; // 114 deg ~= 1.98968 rad
            test_angles[115] = 32'h000201D3; // 115 deg ~= 2.00713 rad
            test_angles[116] = 32'h0002064B; // 116 deg ~= 2.02458 rad
            test_angles[117] = 32'h00020AC3; // 117 deg ~= 2.04204 rad
            test_angles[118] = 32'h00020F3B; // 118 deg ~= 2.05949 rad
            test_angles[119] = 32'h000213B2; // 119 deg ~= 2.07694 rad
            test_angles[120] = 32'h0002182A; // 120 deg ~= 2.09440 rad
            test_angles[121] = 32'h00021CA2; // 121 deg ~= 2.11185 rad
            test_angles[122] = 32'h0002211A; // 122 deg ~= 2.12930 rad
            test_angles[123] = 32'h00022592; // 123 deg ~= 2.14675 rad
            test_angles[124] = 32'h00022A0A; // 124 deg ~= 2.16421 rad
            test_angles[125] = 32'h00022E81; // 125 deg ~= 2.18166 rad
            test_angles[126] = 32'h000232F9; // 126 deg ~= 2.19911 rad
            test_angles[127] = 32'h00023771; // 127 deg ~= 2.21657 rad
            test_angles[128] = 32'h00023BE9; // 128 deg ~= 2.23402 rad
            test_angles[129] = 32'h00024061; // 129 deg ~= 2.25147 rad
            test_angles[130] = 32'h000244D8; // 130 deg ~= 2.26893 rad
            test_angles[131] = 32'h00024950; // 131 deg ~= 2.28638 rad
            test_angles[132] = 32'h00024DC8; // 132 deg ~= 2.30383 rad
            test_angles[133] = 32'h00025240; // 133 deg ~= 2.32129 rad
            test_angles[134] = 32'h000256B8; // 134 deg ~= 2.33874 rad
            test_angles[135] = 32'h00025B30; // 135 deg ~= 2.35619 rad
            test_angles[136] = 32'h00025FA7; // 136 deg ~= 2.37365 rad
            test_angles[137] = 32'h0002641F; // 137 deg ~= 2.39110 rad
            test_angles[138] = 32'h00026897; // 138 deg ~= 2.40855 rad
            test_angles[139] = 32'h00026D0F; // 139 deg ~= 2.42601 rad
            test_angles[140] = 32'h00027187; // 140 deg ~= 2.44346 rad
            test_angles[141] = 32'h000275FE; // 141 deg ~= 2.46091 rad
            test_angles[142] = 32'h00027A76; // 142 deg ~= 2.47837 rad
            test_angles[143] = 32'h00027EEE; // 143 deg ~= 2.49582 rad
            test_angles[144] = 32'h00028366; // 144 deg ~= 2.51327 rad
            test_angles[145] = 32'h000287DE; // 145 deg ~= 2.53073 rad
            test_angles[146] = 32'h00028C56; // 146 deg ~= 2.54818 rad
            test_angles[147] = 32'h000290CD; // 147 deg ~= 2.56563 rad
            test_angles[148] = 32'h00029545; // 148 deg ~= 2.58309 rad
            test_angles[149] = 32'h000299BD; // 149 deg ~= 2.60054 rad
            test_angles[150] = 32'h00029E35; // 150 deg ~= 2.61799 rad
            test_angles[151] = 32'h0002A2AD; // 151 deg ~= 2.63545 rad
            test_angles[152] = 32'h0002A724; // 152 deg ~= 2.65290 rad
            test_angles[153] = 32'h0002AB9C; // 153 deg ~= 2.67035 rad
            test_angles[154] = 32'h0002B014; // 154 deg ~= 2.68781 rad
            test_angles[155] = 32'h0002B48C; // 155 deg ~= 2.70526 rad
            test_angles[156] = 32'h0002B904; // 156 deg ~= 2.72271 rad
            test_angles[157] = 32'h0002BD7C; // 157 deg ~= 2.74017 rad
            test_angles[158] = 32'h0002C1F3; // 158 deg ~= 2.75762 rad
            test_angles[159] = 32'h0002C66B; // 159 deg ~= 2.77507 rad
            test_angles[160] = 32'h0002CAE3; // 160 deg ~= 2.79253 rad
            test_angles[161] = 32'h0002CF5B; // 161 deg ~= 2.80998 rad
            test_angles[162] = 32'h0002D3D3; // 162 deg ~= 2.82743 rad
            test_angles[163] = 32'h0002D84A; // 163 deg ~= 2.84489 rad
            test_angles[164] = 32'h0002DCC2; // 164 deg ~= 2.86234 rad
            test_angles[165] = 32'h0002E13A; // 165 deg ~= 2.87979 rad
            test_angles[166] = 32'h0002E5B2; // 166 deg ~= 2.89725 rad
            test_angles[167] = 32'h0002EA2A; // 167 deg ~= 2.91470 rad
            test_angles[168] = 32'h0002EEA2; // 168 deg ~= 2.93215 rad
            test_angles[169] = 32'h0002F319; // 169 deg ~= 2.94961 rad
            test_angles[170] = 32'h0002F791; // 170 deg ~= 2.96706 rad
            test_angles[171] = 32'h0002FC09; // 171 deg ~= 2.98451 rad
            test_angles[172] = 32'h00030081; // 172 deg ~= 3.00197 rad
            test_angles[173] = 32'h000304F9; // 173 deg ~= 3.01942 rad
            test_angles[174] = 32'h00030971; // 174 deg ~= 3.03687 rad
            test_angles[175] = 32'h00030DE8; // 175 deg ~= 3.05433 rad
            test_angles[176] = 32'h00031260; // 176 deg ~= 3.07178 rad
            test_angles[177] = 32'h000316D8; // 177 deg ~= 3.08923 rad
            test_angles[178] = 32'h00031B50; // 178 deg ~= 3.10669 rad
            test_angles[179] = 32'h00031FC8; // 179 deg ~= 3.12414 rad
            test_angles[180] = 32'h0003243F; // 180 deg ~= 3.14159 rad
            test_angles[181] = 32'h000328B7; // 181 deg ~= 3.15905 rad
            test_angles[182] = 32'h00032D2F; // 182 deg ~= 3.17650 rad
            test_angles[183] = 32'h000331A7; // 183 deg ~= 3.19395 rad
            test_angles[184] = 32'h0003361F; // 184 deg ~= 3.21141 rad
            test_angles[185] = 32'h00033A97; // 185 deg ~= 3.22886 rad
            test_angles[186] = 32'h00033F0E; // 186 deg ~= 3.24631 rad
            test_angles[187] = 32'h00034386; // 187 deg ~= 3.26377 rad
            test_angles[188] = 32'h000347FE; // 188 deg ~= 3.28122 rad
            test_angles[189] = 32'h00034C76; // 189 deg ~= 3.29867 rad
            test_angles[190] = 32'h000350EE; // 190 deg ~= 3.31613 rad
            test_angles[191] = 32'h00035565; // 191 deg ~= 3.33358 rad
            test_angles[192] = 32'h000359DD; // 192 deg ~= 3.35103 rad
            test_angles[193] = 32'h00035E55; // 193 deg ~= 3.36849 rad
            test_angles[194] = 32'h000362CD; // 194 deg ~= 3.38594 rad
            test_angles[195] = 32'h00036745; // 195 deg ~= 3.40339 rad
            test_angles[196] = 32'h00036BBD; // 196 deg ~= 3.42085 rad
            test_angles[197] = 32'h00037034; // 197 deg ~= 3.43830 rad
            test_angles[198] = 32'h000374AC; // 198 deg ~= 3.45575 rad
            test_angles[199] = 32'h00037924; // 199 deg ~= 3.47321 rad
            test_angles[200] = 32'h00037D9C; // 200 deg ~= 3.49066 rad
            test_angles[201] = 32'h00038214; // 201 deg ~= 3.50811 rad
            test_angles[202] = 32'h0003868B; // 202 deg ~= 3.52557 rad
            test_angles[203] = 32'h00038B03; // 203 deg ~= 3.54302 rad
            test_angles[204] = 32'h00038F7B; // 204 deg ~= 3.56047 rad
            test_angles[205] = 32'h000393F3; // 205 deg ~= 3.57792 rad
            test_angles[206] = 32'h0003986B; // 206 deg ~= 3.59538 rad
            test_angles[207] = 32'h00039CE3; // 207 deg ~= 3.61283 rad
            test_angles[208] = 32'h0003A15A; // 208 deg ~= 3.63028 rad
            test_angles[209] = 32'h0003A5D2; // 209 deg ~= 3.64774 rad
            test_angles[210] = 32'h0003AA4A; // 210 deg ~= 3.66519 rad
            test_angles[211] = 32'h0003AEC2; // 211 deg ~= 3.68264 rad
            test_angles[212] = 32'h0003B33A; // 212 deg ~= 3.70010 rad
            test_angles[213] = 32'h0003B7B1; // 213 deg ~= 3.71755 rad
            test_angles[214] = 32'h0003BC29; // 214 deg ~= 3.73500 rad
            test_angles[215] = 32'h0003C0A1; // 215 deg ~= 3.75246 rad
            test_angles[216] = 32'h0003C519; // 216 deg ~= 3.76991 rad
            test_angles[217] = 32'h0003C991; // 217 deg ~= 3.78736 rad
            test_angles[218] = 32'h0003CE09; // 218 deg ~= 3.80482 rad
            test_angles[219] = 32'h0003D280; // 219 deg ~= 3.82227 rad
            test_angles[220] = 32'h0003D6F8; // 220 deg ~= 3.83972 rad
            test_angles[221] = 32'h0003DB70; // 221 deg ~= 3.85718 rad
            test_angles[222] = 32'h0003DFE8; // 222 deg ~= 3.87463 rad
            test_angles[223] = 32'h0003E460; // 223 deg ~= 3.89208 rad
            test_angles[224] = 32'h0003E8D7; // 224 deg ~= 3.90954 rad
            test_angles[225] = 32'h0003ED4F; // 225 deg ~= 3.92699 rad
            test_angles[226] = 32'h0003F1C7; // 226 deg ~= 3.94444 rad
            test_angles[227] = 32'h0003F63F; // 227 deg ~= 3.96190 rad
            test_angles[228] = 32'h0003FAB7; // 228 deg ~= 3.97935 rad
            test_angles[229] = 32'h0003FF2F; // 229 deg ~= 3.99680 rad
            test_angles[230] = 32'h000403A6; // 230 deg ~= 4.01426 rad
            test_angles[231] = 32'h0004081E; // 231 deg ~= 4.03171 rad
            test_angles[232] = 32'h00040C96; // 232 deg ~= 4.04916 rad
            test_angles[233] = 32'h0004110E; // 233 deg ~= 4.06662 rad
            test_angles[234] = 32'h00041586; // 234 deg ~= 4.08407 rad
            test_angles[235] = 32'h000419FD; // 235 deg ~= 4.10152 rad
            test_angles[236] = 32'h00041E75; // 236 deg ~= 4.11898 rad
            test_angles[237] = 32'h000422ED; // 237 deg ~= 4.13643 rad
            test_angles[238] = 32'h00042765; // 238 deg ~= 4.15388 rad
            test_angles[239] = 32'h00042BDD; // 239 deg ~= 4.17134 rad
            test_angles[240] = 32'h00043055; // 240 deg ~= 4.18879 rad
            test_angles[241] = 32'h000434CC; // 241 deg ~= 4.20624 rad
            test_angles[242] = 32'h00043944; // 242 deg ~= 4.22370 rad
            test_angles[243] = 32'h00043DBC; // 243 deg ~= 4.24115 rad
            test_angles[244] = 32'h00044234; // 244 deg ~= 4.25860 rad
            test_angles[245] = 32'h000446AC; // 245 deg ~= 4.27606 rad
            test_angles[246] = 32'h00044B23; // 246 deg ~= 4.29351 rad
            test_angles[247] = 32'h00044F9B; // 247 deg ~= 4.31096 rad
            test_angles[248] = 32'h00045413; // 248 deg ~= 4.32842 rad
            test_angles[249] = 32'h0004588B; // 249 deg ~= 4.34587 rad
            test_angles[250] = 32'h00045D03; // 250 deg ~= 4.36332 rad
            test_angles[251] = 32'h0004617B; // 251 deg ~= 4.38078 rad
            test_angles[252] = 32'h000465F2; // 252 deg ~= 4.39823 rad
            test_angles[253] = 32'h00046A6A; // 253 deg ~= 4.41568 rad
            test_angles[254] = 32'h00046EE2; // 254 deg ~= 4.43314 rad
            test_angles[255] = 32'h0004735A; // 255 deg ~= 4.45059 rad
            test_angles[256] = 32'h000477D2; // 256 deg ~= 4.46804 rad
            test_angles[257] = 32'h00047C49; // 257 deg ~= 4.48550 rad
            test_angles[258] = 32'h000480C1; // 258 deg ~= 4.50295 rad
            test_angles[259] = 32'h00048539; // 259 deg ~= 4.52040 rad
            test_angles[260] = 32'h000489B1; // 260 deg ~= 4.53786 rad
            test_angles[261] = 32'h00048E29; // 261 deg ~= 4.55531 rad
            test_angles[262] = 32'h000492A1; // 262 deg ~= 4.57276 rad
            test_angles[263] = 32'h00049718; // 263 deg ~= 4.59022 rad
            test_angles[264] = 32'h00049B90; // 264 deg ~= 4.60767 rad
            test_angles[265] = 32'h0004A008; // 265 deg ~= 4.62512 rad
            test_angles[266] = 32'h0004A480; // 266 deg ~= 4.64258 rad
            test_angles[267] = 32'h0004A8F8; // 267 deg ~= 4.66003 rad
            test_angles[268] = 32'h0004AD6F; // 268 deg ~= 4.67748 rad
            test_angles[269] = 32'h0004B1E7; // 269 deg ~= 4.69494 rad
            test_angles[270] = 32'h0004B65F; // 270 deg ~= 4.71239 rad
            test_angles[271] = 32'h0004BAD7; // 271 deg ~= 4.72984 rad
            test_angles[272] = 32'h0004BF4F; // 272 deg ~= 4.74730 rad
            test_angles[273] = 32'h0004C3C7; // 273 deg ~= 4.76475 rad
            test_angles[274] = 32'h0004C83E; // 274 deg ~= 4.78220 rad
            test_angles[275] = 32'h0004CCB6; // 275 deg ~= 4.79966 rad
            test_angles[276] = 32'h0004D12E; // 276 deg ~= 4.81711 rad
            test_angles[277] = 32'h0004D5A6; // 277 deg ~= 4.83456 rad
            test_angles[278] = 32'h0004DA1E; // 278 deg ~= 4.85202 rad
            test_angles[279] = 32'h0004DE95; // 279 deg ~= 4.86947 rad
            test_angles[280] = 32'h0004E30D; // 280 deg ~= 4.88692 rad
            test_angles[281] = 32'h0004E785; // 281 deg ~= 4.90438 rad
            test_angles[282] = 32'h0004EBFD; // 282 deg ~= 4.92183 rad
            test_angles[283] = 32'h0004F075; // 283 deg ~= 4.93928 rad
            test_angles[284] = 32'h0004F4ED; // 284 deg ~= 4.95674 rad
            test_angles[285] = 32'h0004F964; // 285 deg ~= 4.97419 rad
            test_angles[286] = 32'h0004FDDC; // 286 deg ~= 4.99164 rad
            test_angles[287] = 32'h00050254; // 287 deg ~= 5.00909 rad
            test_angles[288] = 32'h000506CC; // 288 deg ~= 5.02655 rad
            test_angles[289] = 32'h00050B44; // 289 deg ~= 5.04400 rad
            test_angles[290] = 32'h00050FBC; // 290 deg ~= 5.06145 rad
            test_angles[291] = 32'h00051433; // 291 deg ~= 5.07891 rad
            test_angles[292] = 32'h000518AB; // 292 deg ~= 5.09636 rad
            test_angles[293] = 32'h00051D23; // 293 deg ~= 5.11381 rad
            test_angles[294] = 32'h0005219B; // 294 deg ~= 5.13127 rad
            test_angles[295] = 32'h00052613; // 295 deg ~= 5.14872 rad
            test_angles[296] = 32'h00052A8A; // 296 deg ~= 5.16617 rad
            test_angles[297] = 32'h00052F02; // 297 deg ~= 5.18363 rad
            test_angles[298] = 32'h0005337A; // 298 deg ~= 5.20108 rad
            test_angles[299] = 32'h000537F2; // 299 deg ~= 5.21853 rad
            test_angles[300] = 32'h00053C6A; // 300 deg ~= 5.23599 rad
            test_angles[301] = 32'h000540E2; // 301 deg ~= 5.25344 rad
            test_angles[302] = 32'h00054559; // 302 deg ~= 5.27089 rad
            test_angles[303] = 32'h000549D1; // 303 deg ~= 5.28835 rad
            test_angles[304] = 32'h00054E49; // 304 deg ~= 5.30580 rad
            test_angles[305] = 32'h000552C1; // 305 deg ~= 5.32325 rad
            test_angles[306] = 32'h00055739; // 306 deg ~= 5.34071 rad
            test_angles[307] = 32'h00055BB0; // 307 deg ~= 5.35816 rad
            test_angles[308] = 32'h00056028; // 308 deg ~= 5.37561 rad
            test_angles[309] = 32'h000564A0; // 309 deg ~= 5.39307 rad
            test_angles[310] = 32'h00056918; // 310 deg ~= 5.41052 rad
            test_angles[311] = 32'h00056D90; // 311 deg ~= 5.42797 rad
            test_angles[312] = 32'h00057208; // 312 deg ~= 5.44543 rad
            test_angles[313] = 32'h0005767F; // 313 deg ~= 5.46288 rad
            test_angles[314] = 32'h00057AF7; // 314 deg ~= 5.48033 rad
            test_angles[315] = 32'h00057F6F; // 315 deg ~= 5.49779 rad
            test_angles[316] = 32'h000583E7; // 316 deg ~= 5.51524 rad
            test_angles[317] = 32'h0005885F; // 317 deg ~= 5.53269 rad
            test_angles[318] = 32'h00058CD6; // 318 deg ~= 5.55015 rad
            test_angles[319] = 32'h0005914E; // 319 deg ~= 5.56760 rad
            test_angles[320] = 32'h000595C6; // 320 deg ~= 5.58505 rad
            test_angles[321] = 32'h00059A3E; // 321 deg ~= 5.60251 rad
            test_angles[322] = 32'h00059EB6; // 322 deg ~= 5.61996 rad
            test_angles[323] = 32'h0005A32E; // 323 deg ~= 5.63741 rad
            test_angles[324] = 32'h0005A7A5; // 324 deg ~= 5.65487 rad
            test_angles[325] = 32'h0005AC1D; // 325 deg ~= 5.67232 rad
            test_angles[326] = 32'h0005B095; // 326 deg ~= 5.68977 rad
            test_angles[327] = 32'h0005B50D; // 327 deg ~= 5.70723 rad
            test_angles[328] = 32'h0005B985; // 328 deg ~= 5.72468 rad
            test_angles[329] = 32'h0005BDFC; // 329 deg ~= 5.74213 rad
            test_angles[330] = 32'h0005C274; // 330 deg ~= 5.75959 rad
            test_angles[331] = 32'h0005C6EC; // 331 deg ~= 5.77704 rad
            test_angles[332] = 32'h0005CB64; // 332 deg ~= 5.79449 rad
            test_angles[333] = 32'h0005CFDC; // 333 deg ~= 5.81195 rad
            test_angles[334] = 32'h0005D454; // 334 deg ~= 5.82940 rad
            test_angles[335] = 32'h0005D8CB; // 335 deg ~= 5.84685 rad
            test_angles[336] = 32'h0005DD43; // 336 deg ~= 5.86431 rad
            test_angles[337] = 32'h0005E1BB; // 337 deg ~= 5.88176 rad
            test_angles[338] = 32'h0005E633; // 338 deg ~= 5.89921 rad
            test_angles[339] = 32'h0005EAAB; // 339 deg ~= 5.91667 rad
            test_angles[340] = 32'h0005EF22; // 340 deg ~= 5.93412 rad
            test_angles[341] = 32'h0005F39A; // 341 deg ~= 5.95157 rad
            test_angles[342] = 32'h0005F812; // 342 deg ~= 5.96903 rad
            test_angles[343] = 32'h0005FC8A; // 343 deg ~= 5.98648 rad
            test_angles[344] = 32'h00060102; // 344 deg ~= 6.00393 rad
            test_angles[345] = 32'h0006057A; // 345 deg ~= 6.02139 rad
            test_angles[346] = 32'h000609F1; // 346 deg ~= 6.03884 rad
            test_angles[347] = 32'h00060E69; // 347 deg ~= 6.05629 rad
            test_angles[348] = 32'h000612E1; // 348 deg ~= 6.07375 rad
            test_angles[349] = 32'h00061759; // 349 deg ~= 6.09120 rad
            test_angles[350] = 32'h00061BD1; // 350 deg ~= 6.10865 rad
            test_angles[351] = 32'h00062048; // 351 deg ~= 6.12611 rad
            test_angles[352] = 32'h000624C0; // 352 deg ~= 6.14356 rad
            test_angles[353] = 32'h00062938; // 353 deg ~= 6.16101 rad
            test_angles[354] = 32'h00062DB0; // 354 deg ~= 6.17847 rad
            test_angles[355] = 32'h00063228; // 355 deg ~= 6.19592 rad
            test_angles[356] = 32'h000636A0; // 356 deg ~= 6.21337 rad
            test_angles[357] = 32'h00063B17; // 357 deg ~= 6.23083 rad
            test_angles[358] = 32'h00063F8F; // 358 deg ~= 6.24828 rad
            test_angles[359] = 32'h00064407; // 359 deg ~= 6.26573 rad
            test_angles[360] = 32'h00000000; // 360 deg ~= 6.28319 rad

            fork
                // === LUỒNG 1: DRIVER (NẠP DỮ LIỆU) ===
                begin
                    for (k = 0; k < 361; k = k + 1) begin
                        @(posedge i_clk);
                        // Cấp dữ liệu vào
                        i_x <= 32'h00010000; // 1.0
                        i_y <= 32'h00000000; // 0.0
                        i_z <= test_angles[k];
                    end
                    // Sau khi nạp xong 360 mẫu, trả về 0
                    @(posedge i_clk);
                    i_x <= 0; i_y <= 0; i_z <= 0;
                end

                // === LUỒNG 2: MONITOR (THU THẬP KẾT QUẢ) ===
                begin
                    // Bước 1: Chờ độ trễ đường ống (Latency)
                    // (Bạn nói là 23 CLK, hãy chắc chắn con số này đúng)
                    repeat (23) @(posedge i_clk);

                    // Bước 2: Bắt đầu thu thập liên tục
                    for (m = 0; m < 361; m = m + 1) begin
                        @(posedge i_clk);
                        
                        // Delay nhỏ #0.1 để đảm bảo lấy được giá trị sau cạnh lên
                        #0.1; 

                        $display("\n==== TEST CASE %0d (Input Angle Index: %0d) ====", m, m);
                        // Lưu ý: Kết quả o_x, o_y tại thời điểm này tương ứng với
                        // đầu vào test_angles[m] đã nạp vào 24 chu kỳ trước.
                        
                        $display("Angle: %b_%b%b  (Hex: %h)", 
                                 test_angles[m][31], test_angles[m][30:23], test_angles[m][22:0], test_angles[m]);

                        $display("Sin  : %b_%b%b  (Hex: %h)", 
                                 o_y[31], o_y[30:23], o_y[22:0], o_y);

                        $display("Cos  : %b_%b%b  (Hex: %h)", 
                                 o_x[31], o_x[30:23], o_x[22:0], o_x);
                    end
                end
            join
        end
    endtask

endmodule
