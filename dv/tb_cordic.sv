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

        i_reset = 0;
        i_x = 32'h0; i_y = 32'h0; i_z = 32'h0;

        #4 i_reset = 1; 

        repeat_test_cases();

        #20;
        $finish;
    end

    //==== 5. Task chạy test ====
    task repeat_test_cases;
        integer i;
        reg [31:0] test_angles [0:180];
        begin
            // Các góc mẫu (Floating Point)
            test_angles[0] = 32'hbfc90fdb; // -90 degrees
            test_angles[1] = 32'hbfc6d3f2; // -89 degrees
            test_angles[2] = 32'hbfc49809; // -88 degrees
            test_angles[3] = 32'hbfc25c20; // -87 degrees
            test_angles[4] = 32'hbfc02037; // -86 degrees
            test_angles[5] = 32'hbfbde44e; // -85 degrees
            test_angles[6] = 32'hbfbba866; // -84 degrees
            test_angles[7] = 32'hbfb96c7d; // -83 degrees
            test_angles[8] = 32'hbfb73094; // -82 degrees
            test_angles[9] = 32'hbfb4f4ab; // -81 degrees
            test_angles[10] = 32'hbfb2b8c2; // -80 degrees
            test_angles[11] = 32'hbfb07cda; // -79 degrees
            test_angles[12] = 32'hbfae40f1; // -78 degrees
            test_angles[13] = 32'hbfac0508; // -77 degrees
            test_angles[14] = 32'hbfa9c91f; // -76 degrees
            test_angles[15] = 32'hbfa78d36; // -75 degrees
            test_angles[16] = 32'hbfa5514d; // -74 degrees
            test_angles[17] = 32'hbfa31565; // -73 degrees
            test_angles[18] = 32'hbfa0d97c; // -72 degrees
            test_angles[19] = 32'hbf9e9d93; // -71 degrees
            test_angles[20] = 32'hbf9c61aa; // -70 degrees
            test_angles[21] = 32'hbf9a25c1; // -69 degrees
            test_angles[22] = 32'hbf97e9d8; // -68 degrees
            test_angles[23] = 32'hbf95adf0; // -67 degrees
            test_angles[24] = 32'hbf937207; // -66 degrees
            test_angles[25] = 32'hbf91361e; // -65 degrees
            test_angles[26] = 32'hbf8efa35; // -64 degrees
            test_angles[27] = 32'hbf8cbe4c; // -63 degrees
            test_angles[28] = 32'hbf8a8263; // -62 degrees
            test_angles[29] = 32'hbf88467b; // -61 degrees
            test_angles[30] = 32'hbf860a92; // -60 degrees
            test_angles[31] = 32'hbf83cea9; // -59 degrees
            test_angles[32] = 32'hbf8192c0; // -58 degrees
            test_angles[33] = 32'hbf7eadaf; // -57 degrees
            test_angles[34] = 32'hbf7a35dd; // -56 degrees
            test_angles[35] = 32'hbf75be0b; // -55 degrees
            test_angles[36] = 32'hbf71463a; // -54 degrees
            test_angles[37] = 32'hbf6cce68; // -53 degrees
            test_angles[38] = 32'hbf685696; // -52 degrees
            test_angles[39] = 32'hbf63dec5; // -51 degrees
            test_angles[40] = 32'hbf5f66f3; // -50 degrees
            test_angles[41] = 32'hbf5aef21; // -49 degrees
            test_angles[42] = 32'hbf567750; // -48 degrees
            test_angles[43] = 32'hbf51ff7e; // -47 degrees
            test_angles[44] = 32'hbf4d87ac; // -46 degrees
            test_angles[45] = 32'hbf490fdb; // -45 degrees
            test_angles[46] = 32'hbf449809; // -44 degrees
            test_angles[47] = 32'hbf402037; // -43 degrees
            test_angles[48] = 32'hbf3ba866; // -42 degrees
            test_angles[49] = 32'hbf373094; // -41 degrees
            test_angles[50] = 32'hbf32b8c2; // -40 degrees
            test_angles[51] = 32'hbf2e40f1; // -39 degrees
            test_angles[52] = 32'hbf29c91f; // -38 degrees
            test_angles[53] = 32'hbf25514d; // -37 degrees
            test_angles[54] = 32'hbf20d97c; // -36 degrees
            test_angles[55] = 32'hbf1c61aa; // -35 degrees
            test_angles[56] = 32'hbf17e9d8; // -34 degrees
            test_angles[57] = 32'hbf137207; // -33 degrees
            test_angles[58] = 32'hbf0efa35; // -32 degrees
            test_angles[59] = 32'hbf0a8263; // -31 degrees
            test_angles[60] = 32'hbf060a92; // -30 degrees
            test_angles[61] = 32'hbf0192c0; // -29 degrees
            test_angles[62] = 32'hbefa35dd; // -28 degrees
            test_angles[63] = 32'hbef1463a; // -27 degrees
            test_angles[64] = 32'hbee85696; // -26 degrees
            test_angles[65] = 32'hbedf66f3; // -25 degrees
            test_angles[66] = 32'hbed67750; // -24 degrees
            test_angles[67] = 32'hbecd87ac; // -23 degrees
            test_angles[68] = 32'hbec49809; // -22 degrees
            test_angles[69] = 32'hbebba866; // -21 degrees
            test_angles[70] = 32'hbeb2b8c2; // -20 degrees
            test_angles[71] = 32'hbea9c91f; // -19 degrees
            test_angles[72] = 32'hbea0d97c; // -18 degrees
            test_angles[73] = 32'hbe97e9d8; // -17 degrees
            test_angles[74] = 32'hbe8efa35; // -16 degrees
            test_angles[75] = 32'hbe860a92; // -15 degrees
            test_angles[76] = 32'hbe7a35dd; // -14 degrees
            test_angles[77] = 32'hbe685696; // -13 degrees
            test_angles[78] = 32'hbe567750; // -12 degrees
            test_angles[79] = 32'hbe449809; // -11 degrees
            test_angles[80] = 32'hbe32b8c2; // -10 degrees
            test_angles[81] = 32'hbe20d97c; // -9 degrees
            test_angles[82] = 32'hbe0efa35; // -8 degrees
            test_angles[83] = 32'hbdfa35dd; // -7 degrees
            test_angles[84] = 32'hbdd67750; // -6 degrees
            test_angles[85] = 32'hbdb2b8c2; // -5 degrees
            test_angles[86] = 32'hbd8efa35; // -4 degrees
            test_angles[87] = 32'hbd567750; // -3 degrees
            test_angles[88] = 32'hbd0efa35; // -2 degrees
            test_angles[89] = 32'hbc8efa35; // -1 degrees
            test_angles[90] = 32'h00000000; // 0 degrees
            test_angles[91] = 32'h3c8efa35; // 1 degrees
            test_angles[92] = 32'h3d0efa35; // 2 degrees
            test_angles[93] = 32'h3d567750; // 3 degrees
            test_angles[94] = 32'h3d8efa35; // 4 degrees
            test_angles[95] = 32'h3db2b8c2; // 5 degrees
            test_angles[96] = 32'h3dd67750; // 6 degrees
            test_angles[97] = 32'h3dfa35dd; // 7 degrees
            test_angles[98] = 32'h3e0efa35; // 8 degrees
            test_angles[99] = 32'h3e20d97c; // 9 degrees
            test_angles[100] = 32'h3e32b8c2; // 10 degrees
            test_angles[101] = 32'h3e449809; // 11 degrees
            test_angles[102] = 32'h3e567750; // 12 degrees
            test_angles[103] = 32'h3e685696; // 13 degrees
            test_angles[104] = 32'h3e7a35dd; // 14 degrees
            test_angles[105] = 32'h3e860a92; // 15 degrees
            test_angles[106] = 32'h3e8efa35; // 16 degrees
            test_angles[107] = 32'h3e97e9d8; // 17 degrees
            test_angles[108] = 32'h3ea0d97c; // 18 degrees
            test_angles[109] = 32'h3ea9c91f; // 19 degrees
            test_angles[110] = 32'h3eb2b8c2; // 20 degrees
            test_angles[111] = 32'h3ebba866; // 21 degrees
            test_angles[112] = 32'h3ec49809; // 22 degrees
            test_angles[113] = 32'h3ecd87ac; // 23 degrees
            test_angles[114] = 32'h3ed67750; // 24 degrees
            test_angles[115] = 32'h3edf66f3; // 25 degrees
            test_angles[116] = 32'h3ee85696; // 26 degrees
            test_angles[117] = 32'h3ef1463a; // 27 degrees
            test_angles[118] = 32'h3efa35dd; // 28 degrees
            test_angles[119] = 32'h3f0192c0; // 29 degrees
            test_angles[120] = 32'h3f060a92; // 30 degrees
            test_angles[121] = 32'h3f0a8263; // 31 degrees
            test_angles[122] = 32'h3f0efa35; // 32 degrees
            test_angles[123] = 32'h3f137207; // 33 degrees
            test_angles[124] = 32'h3f17e9d8; // 34 degrees
            test_angles[125] = 32'h3f1c61aa; // 35 degrees
            test_angles[126] = 32'h3f20d97c; // 36 degrees
            test_angles[127] = 32'h3f25514d; // 37 degrees
            test_angles[128] = 32'h3f29c91f; // 38 degrees
            test_angles[129] = 32'h3f2e40f1; // 39 degrees
            test_angles[130] = 32'h3f32b8c2; // 40 degrees
            test_angles[131] = 32'h3f373094; // 41 degrees
            test_angles[132] = 32'h3f3ba866; // 42 degrees
            test_angles[133] = 32'h3f402037; // 43 degrees
            test_angles[134] = 32'h3f449809; // 44 degrees
            test_angles[135] = 32'h3f490fdb; // 45 degrees
            test_angles[136] = 32'h3f4d87ac; // 46 degrees
            test_angles[137] = 32'h3f51ff7e; // 47 degrees
            test_angles[138] = 32'h3f567750; // 48 degrees
            test_angles[139] = 32'h3f5aef21; // 49 degrees
            test_angles[140] = 32'h3f5f66f3; // 50 degrees
            test_angles[141] = 32'h3f63dec5; // 51 degrees
            test_angles[142] = 32'h3f685696; // 52 degrees
            test_angles[143] = 32'h3f6cce68; // 53 degrees
            test_angles[144] = 32'h3f71463a; // 54 degrees
            test_angles[145] = 32'h3f75be0b; // 55 degrees
            test_angles[146] = 32'h3f7a35dd; // 56 degrees
            test_angles[147] = 32'h3f7eadaf; // 57 degrees
            test_angles[148] = 32'h3f8192c0; // 58 degrees
            test_angles[149] = 32'h3f83cea9; // 59 degrees
            test_angles[150] = 32'h3f860a92; // 60 degrees
            test_angles[151] = 32'h3f88467b; // 61 degrees
            test_angles[152] = 32'h3f8a8263; // 62 degrees
            test_angles[153] = 32'h3f8cbe4c; // 63 degrees
            test_angles[154] = 32'h3f8efa35; // 64 degrees
            test_angles[155] = 32'h3f91361e; // 65 degrees
            test_angles[156] = 32'h3f937207; // 66 degrees
            test_angles[157] = 32'h3f95adf0; // 67 degrees
            test_angles[158] = 32'h3f97e9d8; // 68 degrees
            test_angles[159] = 32'h3f9a25c1; // 69 degrees
            test_angles[160] = 32'h3f9c61aa; // 70 degrees
            test_angles[161] = 32'h3f9e9d93; // 71 degrees
            test_angles[162] = 32'h3fa0d97c; // 72 degrees
            test_angles[163] = 32'h3fa31565; // 73 degrees
            test_angles[164] = 32'h3fa5514d; // 74 degrees
            test_angles[165] = 32'h3fa78d36; // 75 degrees
            test_angles[166] = 32'h3fa9c91f; // 76 degrees
            test_angles[167] = 32'h3fac0508; // 77 degrees
            test_angles[168] = 32'h3fae40f1; // 78 degrees
            test_angles[169] = 32'h3fb07cda; // 79 degrees
            test_angles[170] = 32'h3fb2b8c2; // 80 degrees
            test_angles[171] = 32'h3fb4f4ab; // 81 degrees
            test_angles[172] = 32'h3fb73094; // 82 degrees
            test_angles[173] = 32'h3fb96c7d; // 83 degrees
            test_angles[174] = 32'h3fbba866; // 84 degrees
            test_angles[175] = 32'h3fbde44e; // 85 degrees
            test_angles[176] = 32'h3fc02037; // 86 degrees
            test_angles[177] = 32'h3fc25c20; // 87 degrees
            test_angles[178] = 32'h3fc49809; // 88 degrees
            test_angles[179] = 32'h3fc6d3f2; // 89 degrees
            test_angles[180] = 32'h3fc90fdb; // 90 degrees


            for (i = 0; i < 181; i = i + 1) begin
                @(posedge i_clk);
                
                // Input vector (1.0, 0.0)
                i_x = 32'h3f800000; 
                i_y = 32'h00000000; 
                i_z = test_angles[i];

                // Chờ pipeline (ví dụ 17 cycles)
                repeat (23) @(posedge i_clk);

                $display("\n==== TEST CASE %0d ====", i);
                // IN THEO ĐỊNH DẠNG: 1_8_23 bits
                $display("Angle: %b_%b_%b  (Hex: %h)", 
                         test_angles[i][31], test_angles[i][30:23], test_angles[i][22:0], test_angles[i]);
                                  
                $display("Sin  : %b_%b_%b  (Hex: %h)", 
                         o_y[31], o_y[30:23], o_y[22:0], o_y);
                
                $display("Cos  : %b_%b_%b  (Hex: %h)", 
                         o_x[31], o_x[30:23], o_x[22:0], o_x);
            end
        end
    endtask

endmodule
