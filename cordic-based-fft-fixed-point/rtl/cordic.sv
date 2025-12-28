module cordic (
	input logic i_clk, i_reset,
	input logic [31:0] i_x, i_y, i_z,
	output logic [31:0] o_x, o_y
);

logic angle_0_360, angle_90_270, angle_180_180, angle_270_90;
logic [3:0] check_angle;
logic [1:0] check7;
logic check1, check2, check3, check4, check5, check6;
logic [5:0] start_check, check;
logic [5:0] o_check1,  o_check2, o_check3, o_check4;
logic [5:0] o_check5,  o_check6, o_check7, o_check8;
logic [5:0] o_check9,  o_check10, o_check11, o_check12;
logic [5:0] o_check13, o_check14, o_check15, o_check16;
logic [5:0] o_check17, o_check18, o_check19;
logic [5:0] o_check20, o_check21, o_check22;

logic [31:0] z1, z2, z3_1, z3_2, z4;

logic [31:0] start_x, start_y, start_z;
logic [31:0] i_x1,  o_x1,  i_y1,  o_y1,  i_z1,  o_z1;
logic [31:0] i_x2,  o_x2,  i_y2,  o_y2,  i_z2,  o_z2;
logic [31:0] i_x3,  o_x3,  i_y3,  o_y3,  i_z3,  o_z3;
logic [31:0] i_x4,  o_x4,  i_y4,  o_y4,  i_z4,  o_z4;
logic [31:0] i_x5,  o_x5,  i_y5,  o_y5,  i_z5,  o_z5;
logic [31:0] i_x6,  o_x6,  i_y6,  o_y6,  i_z6,  o_z6;
logic [31:0] i_x7,  o_x7,  i_y7,  o_y7,  i_z7,  o_z7;
logic [31:0] i_x8,  o_x8,  i_y8,  o_y8,  i_z8,  o_z8;
logic [31:0] i_x9,  o_x9,  i_y9,  o_y9,  i_z9,  o_z9;
logic [31:0] i_x10, o_x10, i_y10, o_y10, i_z10, o_z10;
logic [31:0] i_x11, o_x11, i_y11, o_y11, i_z11, o_z11;
logic [31:0] i_x12, o_x12, i_y12, o_y12, i_z12, o_z12;
logic [31:0] i_x13, o_x13, i_y13, o_y13, i_z13, o_z13;
logic [31:0] i_x14, o_x14, i_y14, o_y14, i_z14, o_z14;
logic [31:0] i_x15, o_x15, i_y15, o_y15, i_z15, o_z15;
logic [31:0] i_x16, i_y16, i_z16, o_z16;
logic [31:0] o_x_k_3,  o_y_k_3;
logic [31:0] i_x_k_4,  o_x_k_4,  i_y_k_4,  o_y_k_4;
logic [31:0] i_x_k_6,  o_x_k_6,  i_y_k_6,  o_y_k_6;
logic [31:0] i_x_k_9,  o_x_k_9,  i_y_k_9,  o_y_k_9;
logic [31:0] i_x_k_10, o_x_k_10, i_y_k_10, o_y_k_10;
logic [31:0] i_x_k_11, o_x_k_11, i_y_k_11, o_y_k_11;
logic [31:0] i_x_k_14, o_x_k_14, i_y_k_14, o_y_k_14;

logic [31:0] x, y;
logic [31:0] delay23_x, delay23_y;
logic [31:0] x1, y1;

//         _                _           _       _  _           _                        _   
//        / \   _ __   __ _| | ___     / \   __| |(_)_   _ ___| |_ _ __ ___   ___ _ __ | |_ 
//       / _ \ | '_ \ / _` | |/ _ \   / _ \ / _` || | | | / __| __| '_ ` _ \ / _ \ '_ \| __|
//      / ___ \| | | | (_| | |  __/  / ___ \ (_| || | |_| \__ \ |_| | | | | |  __/ | | | |_ 
//     /_/   \_\_| |_|\__, |_|\___| /_/   \_\__,_|/ |\__,_|___/\__|_| |_| |_|\___|_| |_|\__|
//                    |___/                     |__/                                       

fullAdder32b fa_i_z (.a(i_z), .b(32'h0006487e), .cin(1'b0), .sum(z1)); // z + 360

always @(*) begin
    if (i_z[31])
        z2 = z1;
    else
        z2 = i_z;
end

comparator cmp1 (.a(z2), .b(32'h0001921f), .signed_mode(1'b0), .Gr(check1));
comparator cmp2 (.a(z2), .b(32'h0004b65f), .signed_mode(1'b0), .Lt(check2), .Gr(check3)); //90 < z2 < 270
comparator cmp3 (.a(z2), .b(32'h0006487e), .signed_mode(1'b0), .Lt(check4));

fullAdder32b faz1 (.a(z2), .b(32'h0003243f), .cin(1'b1), .sum(z3_1)); // z2 - 180
fullAdder32b faz2 (.a(z2), .b(32'h0006487e), .cin(1'b1), .sum(z3_2)); // z2 - 360

assign check5 = check1 & check2;
assign check6 = check3 & check4;
assign check7 = {check6, check5};

mux4to1 muxcheck (.i_data_0(z2), .i_data_1(z3_1), .i_data_2(z3_2), .i_data_3(32'b0), .i_sel(check7), .o_data(z4));

assign angle_0_360  = (&(~i_z)) | /*0*/

                       (~i_z[31] & ~i_z[30] & ~i_z[29] & ~i_z[28] &
                        ~i_z[27] & ~i_z[26] & ~i_z[25] & ~i_z[24] &
                        ~i_z[23] & ~i_z[22] & ~i_z[21] & ~i_z[20] &
                        ~i_z[19] &  i_z[18] &  i_z[17] & ~i_z[16] &
                        ~i_z[15] &  i_z[14] & ~i_z[13] & ~i_z[12] &
                         i_z[11] & ~i_z[10] & ~i_z[9]  & ~i_z[8]  &
                        ~i_z[7]  &  i_z[6]  &  i_z[5]  &  i_z[4]  &
                         i_z[3]  &  i_z[2]  &  i_z[1]  & ~i_z[0]) | /*360*/
                       
                       ( i_z[31] &  i_z[30] &  i_z[29] &  i_z[28] &
                         i_z[27] &  i_z[26] &  i_z[25] &  i_z[24] &
                         i_z[23] &  i_z[22] &  i_z[21] &  i_z[20] &
                         i_z[19] & ~i_z[18] & ~i_z[17] &  i_z[16] &
                         i_z[15] & ~i_z[14] &  i_z[13] &  i_z[12] &
                        ~i_z[11] &  i_z[10] &  i_z[9]  &  i_z[8]  &
                         i_z[7]  & ~i_z[6]  & ~i_z[5]  & ~i_z[4]  &
                        ~i_z[3]  & ~i_z[2]  &  i_z[1]  & ~i_z[0]);  /*-360*/

assign angle_90_270  = (~i_z[31] & ~i_z[30] & ~i_z[29] & ~i_z[28] &  // 0
                        ~i_z[27] & ~i_z[26] & ~i_z[25] & ~i_z[24] &  // 0
                        ~i_z[23] & ~i_z[22] & ~i_z[21] & ~i_z[20] &  // 0
                        ~i_z[19] & ~i_z[18] & ~i_z[17] &  i_z[16] &  // 1 (0001)
                         i_z[15] & ~i_z[14] & ~i_z[13] &  i_z[12] &  // 9 (1001)
                        ~i_z[11] & ~i_z[10] &  i_z[9]  & ~i_z[8]  &  // 2 (0010)
                        ~i_z[7]  & ~i_z[6]  & ~i_z[5]  &  i_z[4]  &  // 1 (0001)
                         i_z[3]  &  i_z[2]  &  i_z[1]  &  i_z[0] ) | // F (1111)

                       ( i_z[31] &  i_z[30] &  i_z[29] &  i_z[28] &  // F
                         i_z[27] &  i_z[26] &  i_z[25] &  i_z[24] &  // F
                         i_z[23] &  i_z[22] &  i_z[21] &  i_z[20] &  // F
                         i_z[19] & ~i_z[18] &  i_z[17] &  i_z[16] &  // B (1011)
                        ~i_z[15] &  i_z[14] & ~i_z[13] & ~i_z[12] &  // 4 (0100)
                         i_z[11] & ~i_z[10] & ~i_z[9]  &  i_z[8]  &  // 9 (1001)
                         i_z[7]  & ~i_z[6]  &  i_z[5]  & ~i_z[4]  &  // A (1010)
                        ~i_z[3]  & ~i_z[2]  & ~i_z[1]  &  i_z[0] );  // 1 (0001)

assign angle_180_180 = (~i_z[31] & ~i_z[30] & ~i_z[29] & ~i_z[28] &  // 0
                        ~i_z[27] & ~i_z[26] & ~i_z[25] & ~i_z[24] &  // 0
                        ~i_z[23] & ~i_z[22] & ~i_z[21] & ~i_z[20] &  // 0
                        ~i_z[19] & ~i_z[18] &  i_z[17] &  i_z[16] &  // 3 (0011)
                        ~i_z[15] & ~i_z[14] &  i_z[13] & ~i_z[12] &  // 2 (0010)
                        ~i_z[11] &  i_z[10] & ~i_z[9]  & ~i_z[8]  &  // 4 (0100)
                        ~i_z[7]  & ~i_z[6]  &  i_z[5]  &  i_z[4]  &  // 3 (0011)
                         i_z[3]  &  i_z[2]  &  i_z[1]  &  i_z[0] ) | // F (1111)

                       ( i_z[31] &  i_z[30] &  i_z[29] &  i_z[28] &  // F
                         i_z[27] &  i_z[26] &  i_z[25] &  i_z[24] &  // F
                         i_z[23] &  i_z[22] &  i_z[21] &  i_z[20] &  // F
                         i_z[19] &  i_z[18] & ~i_z[17] & ~i_z[16] &  // C (1100)
                         i_z[15] &  i_z[14] & ~i_z[13] &  i_z[12] &  // D (1101)
                         i_z[11] & ~i_z[10] &  i_z[9]  &  i_z[8]  &  // B (1011)
                         i_z[7]  &  i_z[6]  & ~i_z[5]  & ~i_z[4]  &  // C (1100)
                        ~i_z[3]  & ~i_z[2]  & ~i_z[1]  &  i_z[0] );  // 1 (0001)

assign angle_270_90  = ( i_z[31] &  i_z[30] &  i_z[29] &  i_z[28] &  // F
                         i_z[27] &  i_z[26] &  i_z[25] &  i_z[24] &  // F
                         i_z[23] &  i_z[22] &  i_z[21] &  i_z[20] &  // F
                         i_z[19] &  i_z[18] &  i_z[17] & ~i_z[16] &  // E (1110)
                        ~i_z[15] &  i_z[14] &  i_z[13] & ~i_z[12] &  // 6 (0110)
                         i_z[11] &  i_z[10] & ~i_z[9]  &  i_z[8]  &  // D (1101)
                         i_z[7]  &  i_z[6]  &  i_z[5]  & ~i_z[4]  &  // E (1110)
                        ~i_z[3]  & ~i_z[2]  & ~i_z[1]  &  i_z[0] ) | // 1 (0001)

                       (~i_z[31] & ~i_z[30] & ~i_z[29] & ~i_z[28] &  // 0
                        ~i_z[27] & ~i_z[26] & ~i_z[25] & ~i_z[24] &  // 0
                        ~i_z[23] & ~i_z[22] & ~i_z[21] & ~i_z[20] &  // 0
                        ~i_z[19] &  i_z[18] & ~i_z[17] & ~i_z[16] &  // 4 (0100)
                         i_z[15] & ~i_z[14] &  i_z[13] &  i_z[12] &  // B (1011)
                        ~i_z[11] &  i_z[10] &  i_z[9]  & ~i_z[8]  &  // 6 (0110)
                        ~i_z[7]  &  i_z[6]  & ~i_z[5]  &  i_z[4]  &  // 5 (0101)
                         i_z[3]  &  i_z[2]  &  i_z[1]  &  i_z[0] );  // F (1111)

assign check_angle = {angle_270_90, angle_180_180, angle_90_270, angle_0_360};
assign check = {check_angle, check7};

delay_23 delay23x (.i_clk(i_clk), .i_reset(i_reset),
						 .i_data(i_x),
						
						 .o_data(delay23_x));

delay_23 delay23y (.i_clk(i_clk), .i_reset(i_reset),
						 .i_data(i_x),
						
						 .o_data(delay23_y));

always_ff @(posedge i_clk or negedge i_reset) begin
    if (~i_reset) begin
        start_x     <= 32'b0;
        start_y     <= 32'b0;
        start_z     <= 32'b0;
        start_check <= 2'b0;
    end else begin
        start_x     <= i_x;
        start_y     <= i_y;
        start_z     <= z4;
        start_check <= check;
    end
end
        
//      ____  _                      ___  
//     / ___|| |_ __ _  __ _  ___   / _ \ 
//     \___ \| __/ _` |/ _` |/ _ \ | | | |
//      ___) | || (_| | (_| |  __/ | |_| |
//     |____/ \__\__,_|\__, |\___|  \___/ 
//                     |___/              

fullAdder32b fa_x0 (.a(start_x), .b(start_y),      .cin(~start_z[31]), .sum(i_x1));
fullAdder32b fa_y0 (.a(start_y), .b(start_x),      .cin( start_z[31]), .sum(i_y1));
fullAdder32b fa_z0 (.a(start_z), .b(32'h0000c910), .cin(~start_z[31]), .sum(i_z1)); // arctan(2^-0) = 0.7853981634

always_ff @(posedge i_clk or negedge i_reset) begin
	if (~i_reset) begin
        o_x1     <= 32'b0;
        o_y1     <= 32'b0;
		o_z1     <= 32'b0;
        o_check1 <= 0;
	end else begin
        o_x1     <= i_x1;
        o_y1     <= i_y1;
		o_z1     <= i_z1;
        o_check1 <= start_check;
    end
end

//      ____  _                     _ 
//     / ___|| |_ __ _  __ _  ___  / |
//     \___ \| __/ _` |/ _` |/ _ \ | |
//      ___) | || (_| | (_| |  __/ | |
//     |____/ \__\__,_|\__, |\___| |_|
//                     |___/          

logic [31:0] shift_o_x1, shift_o_y1;

assign shift_o_x1 = {o_x1[31], o_x1[31:1]};
assign shift_o_y1 = {o_y1[31], o_y1[31:1]};

fullAdder32b fa_x1 (.a(o_x1), .b(shift_o_y1),   .cin(~o_z1[31]), .sum(i_x2)); 
fullAdder32b fa_y1 (.a(o_y1), .b(shift_o_x1),   .cin( o_z1[31]), .sum(i_y2));
fullAdder32b fa_z1 (.a(o_z1), .b(32'h000076b2), .cin(~o_z1[31]), .sum(i_z2)); // arctan(2^-1) = 0.463647609

always_ff @(posedge i_clk or negedge i_reset) begin
	if (~i_reset) begin
        o_x2     <= 32'b0;
        o_y2     <= 32'b0;
		o_z2     <= 32'b0;
        o_check2 <= 0;
	end else begin
        o_x2     <= i_x2;
        o_y2     <= i_y2;
		o_z2     <= i_z2;
        o_check2 <= o_check1;
    end
end

//      ____  _                     ____  
//     / ___|| |_ __ _  __ _  ___  |___ \ 
//     \___ \| __/ _` |/ _` |/ _ \   __) |
//      ___) | || (_| | (_| |  __/  / __/ 
//     |____/ \__\__,_|\__, |\___| |_____|
//                     |___/              
logic [31:0] shift_o_x2, shift_o_y2;

assign shift_o_x2 = {{2{o_x2[31]}}, o_x2[31:2]};
assign shift_o_y2 = {{2{o_y2[31]}}, o_y2[31:2]};

fullAdder32b fa_x2 (.a(o_x2), .b(shift_o_y2),   .cin(~o_z2[31]), .sum(i_x3));
fullAdder32b fa_y2 (.a(o_y2), .b(shift_o_x2),   .cin( o_z2[31]), .sum(i_y3));
fullAdder32b fa_z2 (.a(o_z2), .b(32'h00003eb7), .cin(~o_z2[31]), .sum(i_z3)); // arctan(2^-2) = 0.2449786631

always_ff @(posedge i_clk or negedge i_reset) begin
    if (~i_reset) begin
        o_x3      <= 32'b0;
        o_y3      <= 32'b0;
        o_z3      <= 32'b0;
        o_check3  <= 0;
    end else begin
        o_x3      <= i_x3;
        o_y3      <= i_y3;
        o_z3      <= i_z3;
        o_check3  <= o_check2;
    end
end

//      ____  _                     _____ 
//     / ___|| |_ __ _  __ _  ___  |___ / 
//     \___ \| __/ _` |/ _` |/ _ \   |_ \ 
//      ___) | || (_| | (_| |  __/  ___) |
//     |____/ \__\__,_|\__, |\___| |____/ 
//                     |___/              
logic [31:0] shift_o_x3, shift_o_y3;

assign shift_o_x3 = {{3{o_x3[31]}}, o_x3[31:3]};
assign shift_o_y3 = {{3{o_y3[31]}}, o_y3[31:3]};

fullAdder32b fa_x3 (.a(o_x3), .b(shift_o_y3),   .cin(~o_z3[31]), .sum(i_x4));
fullAdder32b fa_y3 (.a(o_y3), .b(shift_o_x3),   .cin( o_z3[31]), .sum(i_y4));
fullAdder32b fa_z3 (.a(o_z3), .b(32'h00001fd6), .cin(~o_z3[31]), .sum(i_z4)); // arctan(2^-3) = 0.1243549945

always_ff @(posedge i_clk or negedge i_reset) begin
    if (~i_reset) begin
        o_x4      <= 32'b0;
        o_y4      <= 32'b0;
        o_z4      <= 32'b0;
        o_check4  <= 0;
    end else begin
        o_x4      <= i_x4;
        o_y4      <= i_y4;
        o_z4      <= i_z4;
        o_check4  <= o_check3;
    end
end

//      ____  _                     _  _   
//     / ___|| |_ __ _  __ _  ___  | || |  
//     \___ \| __/ _` |/ _` |/ _ \ | || |_ 
//      ___) | || (_| | (_| |  __/ |__   _|
//     |____/ \__\__,_|\__, |\___|    |_|  
//                     |___/               
logic [31:0] shift_o_x4, shift_o_y4;

assign shift_o_x4 = {{4{o_x4[31]}}, o_x4[31:4]};
assign shift_o_y4 = {{4{o_y4[31]}}, o_y4[31:4]};

fullAdder32b fa_x4 (.a(o_x4), .b(shift_o_y4),   .cin(~o_z4[31]), .sum(i_x5));
fullAdder32b fa_y4 (.a(o_y4), .b(shift_o_x4),   .cin( o_z4[31]), .sum(i_y5));
fullAdder32b fa_z4 (.a(o_z4), .b(32'h00000ffb), .cin(~o_z4[31]), .sum(i_z5)); // arctan(2^-4) = 0.06241881

always_ff @(posedge i_clk or negedge i_reset) begin
    if (~i_reset) begin
        o_x5      <= 32'b0;
        o_y5      <= 32'b0;
        o_z5      <= 32'b0;
        o_check5  <= 0;
    end else begin
        o_x5      <= i_x5;
        o_y5      <= i_y5;
        o_z5      <= i_z5;
        o_check5  <= o_check4;
    end
end

//      ____  _                     ____  
//     / ___|| |_ __ _  __ _  ___  | ___| 
//     \___ \| __/ _` |/ _` |/ _ \ |___ \ 
//      ___) | || (_| | (_| |  __/  ___) |
//     |____/ \__\__,_|\__, |\___| |____/ 
//                     |___/              
logic [31:0] shift_o_x5, shift_o_y5;

assign shift_o_x5 = {{5{o_x5[31]}}, o_x5[31:5]};
assign shift_o_y5 = {{5{o_y5[31]}}, o_y5[31:5]};

fullAdder32b fa_x5 (.a(o_x5), .b(shift_o_y5),   .cin(~o_z5[31]), .sum(i_x6));
fullAdder32b fa_y5 (.a(o_y5), .b(shift_o_x5),   .cin( o_z5[31]), .sum(i_y6));
fullAdder32b fa_z5 (.a(o_z5), .b(32'h000007ff), .cin(~o_z5[31]), .sum(i_z6)); // arctan(2^-5) = 0.03123983343

always_ff @(posedge i_clk or negedge i_reset) begin
    if (~i_reset) begin
        o_x6      <= 32'b0;
        o_y6      <= 32'b0;
        o_z6      <= 32'b0;
        o_check6  <= 0;
    end else begin
        o_x6      <= i_x6;
        o_y6      <= i_y6;
        o_z6      <= i_z6;
        o_check6  <= o_check5;
    end
end

//      ____  _                      __   
//     / ___|| |_ __ _  __ _  ___   / /_  
//     \___ \| __/ _` |/ _` |/ _ \ | '_ \ 
//      ___) | || (_| | (_| |  __/ | (_) |
//     |____/ \__\__,_|\__, |\___|  \___/ 
//                     |___/              
logic [31:0] shift_o_x6, shift_o_y6;

assign shift_o_x6 = {{6{o_x6[31]}}, o_x6[31:6]};
assign shift_o_y6 = {{6{o_y6[31]}}, o_y6[31:6]};

fullAdder32b fa_x6 (.a(o_x6), .b(shift_o_y6),   .cin(~o_z6[31]), .sum(i_x7));
fullAdder32b fa_y6 (.a(o_y6), .b(shift_o_x6),   .cin( o_z6[31]), .sum(i_y7));
fullAdder32b fa_z6 (.a(o_z6), .b(32'h00000400), .cin(~o_z6[31]), .sum(i_z7)); // arctan(2^-6) = 0.01562372862

always_ff @(posedge i_clk or negedge i_reset) begin
    if (~i_reset) begin
        o_x7      <= 32'b0;
        o_y7      <= 32'b0;
        o_z7      <= 32'b0;
        o_check7  <= 0;
    end else begin
        o_x7      <= i_x7;
        o_y7      <= i_y7;
        o_z7      <= i_z7;
        o_check7  <= o_check6;
    end
end

//      ____  _                     _____ 
//     / ___|| |_ __ _  __ _  ___  |___  |
//     \___ \| __/ _` |/ _` |/ _ \    / / 
//      ___) | || (_| | (_| |  __/   / /  
//     |____/ \__\__,_|\__, |\___|  /_/   
//                     |___/              
logic [31:0] shift_o_x7, shift_o_y7;

assign shift_o_x7 = {{7{o_x7[31]}}, o_x7[31:7]};
assign shift_o_y7 = {{7{o_y7[31]}}, o_y7[31:7]};

fullAdder32b fa_x7 (.a(o_x7), .b(shift_o_y7),   .cin(~o_z7[31]), .sum(i_x8));
fullAdder32b fa_y7 (.a(o_y7), .b(shift_o_x7),   .cin( o_z7[31]), .sum(i_y8));
fullAdder32b fa_z7 (.a(o_z7), .b(32'h00000200), .cin(~o_z7[31]), .sum(i_z8)); // arctan(2^-7) = 0.00781234106

always_ff @(posedge i_clk or negedge i_reset) begin
    if (~i_reset) begin
        o_x8      <= 32'b0;
        o_y8      <= 32'b0;
        o_z8      <= 32'b0;
        o_check8  <= 0;
    end else begin
        o_x8      <= i_x8;
        o_y8      <= i_y8;
        o_z8      <= i_z8;
        o_check8  <= o_check7;
    end
end

//      ____  _                      ___  
//     / ___|| |_ __ _  __ _  ___   ( _ ) 
//     \___ \| __/ _` |/ _` |/ _ \  / _ \ 
//      ___) | || (_| | (_| |  __/ | (_) |
//     |____/ \__\__,_|\__, |\___|  \___/ 
//                     |___/              
logic [31:0] shift_o_x8, shift_o_y8;

assign shift_o_x8 = {{8{o_x8[31]}}, o_x8[31:8]};
assign shift_o_y8 = {{8{o_y8[31]}}, o_y8[31:8]};

fullAdder32b fa_x8 (.a(o_x8), .b(shift_o_y8),   .cin(~o_z8[31]), .sum(i_x9));
fullAdder32b fa_y8 (.a(o_y8), .b(shift_o_x8),   .cin( o_z8[31]), .sum(i_y9));
fullAdder32b fa_z8 (.a(o_z8), .b(32'h00000100), .cin(~o_z8[31]), .sum(i_z9)); // arctan(2^-8) = 0.003906230132

always_ff @(posedge i_clk or negedge i_reset) begin
    if (~i_reset) begin
        o_x9      <= 32'b0;
        o_y9      <= 32'b0;
        o_z9      <= 32'b0;
        o_check9  <= 0;
    end else begin
        o_x9      <= i_x9;
        o_y9      <= i_y9;
        o_z9      <= i_z9;
        o_check9  <= o_check8;
    end
end

//      ____  _                      ___  
//     / ___|| |_ __ _  __ _  ___   / _ \ 
//     \___ \| __/ _` |/ _` |/ _ \ | (_) |
//      ___) | || (_| | (_| |  __/  \__, |
//     |____/ \__\__,_|\__, |\___|    /_/ 
//                     |___/              
logic [31:0] shift_o_x9, shift_o_y9;

assign shift_o_x9 = {{9{o_x9[31]}}, o_x9[31:9]};
assign shift_o_y9 = {{9{o_y9[31]}}, o_y9[31:9]};

fullAdder32b fa_x9 (.a(o_x9), .b(shift_o_y9),   .cin(~o_z9[31]), .sum(i_x10));
fullAdder32b fa_y9 (.a(o_y9), .b(shift_o_x9),   .cin( o_z9[31]), .sum(i_y10));
fullAdder32b fa_z9 (.a(o_z9), .b(32'h00000080), .cin(~o_z9[31]), .sum(i_z10)); // arctan(2^-9) = 0.001953122516

always_ff @(posedge i_clk or negedge i_reset) begin
    if (~i_reset) begin
        o_x10      <= 32'b0;
        o_y10      <= 32'b0;
        o_z10      <= 32'b0;
        o_check10  <= 0;
    end else begin
        o_x10      <= i_x10;
        o_y10      <= i_y10;
        o_z10      <= i_z10;
        o_check10  <= o_check9;
    end
end
//      ____  _                     _  ___  
//     / ___|| |_ __ _  __ _  ___  / |/ _ \ 
//     \___ \| __/ _` |/ _` |/ _ \ | | | | |
//      ___) | || (_| | (_| |  __/ | | |_| |
//     |____/ \__\__,_|\__, |\___| |_|\___/ 
//                     |___/                
logic [31:0] shift_o_x10, shift_o_y10;

assign shift_o_x10 = {{10{o_x10[31]}}, o_x10[31:10]};
assign shift_o_y10 = {{10{o_y10[31]}}, o_y10[31:10]};

fullAdder32b fa_x10 (.a(o_x10), .b(shift_o_y10),  .cin(~o_z10[31]), .sum(i_x11));
fullAdder32b fa_y10 (.a(o_y10), .b(shift_o_x10),  .cin( o_z10[31]), .sum(i_y11));
fullAdder32b fa_z10 (.a(o_z10), .b(32'h00000040), .cin(~o_z10[31]), .sum(i_z11)); // arctan(2^-10) = 9.7656219e-4

always_ff @(posedge i_clk or negedge i_reset) begin
    if (~i_reset) begin
        o_x11      <= 32'b0;
        o_y11      <= 32'b0;
        o_z11      <= 32'b0;
        o_check11  <= 0;
    end else begin
        o_x11      <= i_x11;
        o_y11      <= i_y11;
        o_z11      <= i_z11;
        o_check11  <= o_check10;
    end
end

//      ____  _                     _ _ 
//     / ___|| |_ __ _  __ _  ___  / / |
//     \___ \| __/ _` |/ _` |/ _ \ | | |
//      ___) | || (_| | (_| |  __/ | | |
//     |____/ \__\__,_|\__, |\___| |_|_|
//                     |___/            
logic [31:0] shift_o_x11, shift_o_y11;

assign shift_o_x11 = {{11{o_x11[31]}}, o_x11[31:11]};
assign shift_o_y11 = {{11{o_y11[31]}}, o_y11[31:11]};

fullAdder32b fa_x11 (.a(o_x11), .b(shift_o_y11),  .cin(~o_z11[31]), .sum(i_x12));
fullAdder32b fa_y11 (.a(o_y11), .b(shift_o_x11),  .cin( o_z11[31]), .sum(i_y12));
fullAdder32b fa_z11 (.a(o_z11), .b(32'h00000020), .cin(~o_z11[31]), .sum(i_z12)); // arctan(2^-11) = 4.88281211e-4

always_ff @(posedge i_clk or negedge i_reset) begin
    if (~i_reset) begin
        o_x12      <= 32'b0;
        o_y12      <= 32'b0;
        o_z12      <= 32'b0;
        o_check12  <= 0;
    end else begin
        o_x12      <= i_x12;
        o_y12      <= i_y12;
        o_z12      <= i_z12;
        o_check12  <= o_check11;
    end
end

//      ____  _                     _ ____  
//     / ___|| |_ __ _  __ _  ___  / |___ \ 
//     \___ \| __/ _` |/ _` |/ _ \ | | __) |
//      ___) | || (_| | (_| |  __/ | |/ __/ 
//     |____/ \__\__,_|\__, |\___| |_|_____|
//                     |___/                
logic [31:0] shift_o_x12, shift_o_y12;

assign shift_o_x12 = {{12{o_x12[31]}}, o_x12[31:12]};
assign shift_o_y12 = {{12{o_y12[31]}}, o_y12[31:12]};

fullAdder32b fa_x12 (.a(o_x12), .b(shift_o_y12),  .cin(~o_z12[31]), .sum(i_x13));
fullAdder32b fa_y12 (.a(o_y12), .b(shift_o_x12),  .cin( o_z12[31]), .sum(i_y13));
fullAdder32b fa_z12 (.a(o_z12), .b(32'h00000010), .cin(~o_z12[31]), .sum(i_z13)); // arctan(2^-12) = 2.4414062e-4

always_ff @(posedge i_clk or negedge i_reset) begin
    if (~i_reset) begin
        o_x13      <= 32'b0;
        o_y13      <= 32'b0;
        o_z13      <= 32'b0;
        o_check13  <= 0;
    end else begin
        o_x13      <= i_x13;
        o_y13      <= i_y13;
        o_z13      <= i_z13;
        o_check13  <= o_check12;
    end
end

//      ____  _                     _ _____ 
//     / ___|| |_ __ _  __ _  ___  / |___ / 
//     \___ \| __/ _` |/ _` |/ _ \ | | |_ \ 
//      ___) | || (_| | (_| |  __/ | |___) |
//     |____/ \__\__,_|\__, |\___| |_|____/ 
//                     |___/                
logic [31:0] shift_o_x13, shift_o_y13;

assign shift_o_x13 = {{13{o_x13[31]}}, o_x13[31:13]};
assign shift_o_y13 = {{13{o_y13[31]}}, o_y13[31:13]};

fullAdder32b fa_x13 (.a(o_x13), .b(shift_o_y13),  .cin(~o_z13[31]), .sum(i_x14));
fullAdder32b fa_y13 (.a(o_y13), .b(shift_o_x13),  .cin( o_z13[31]), .sum(i_y14));
fullAdder32b fa_z13 (.a(o_z13), .b(32'h00000008), .cin(~o_z13[31]), .sum(i_z14)); // arctan(2^-13) = 1.22070312e-4

always_ff @(posedge i_clk or negedge i_reset) begin
    if (~i_reset) begin
        o_x14      <= 32'b0;
        o_y14      <= 32'b0;
        o_z14      <= 32'b0;
        o_check14  <= 0;
    end else begin
        o_x14      <= i_x14;
        o_y14      <= i_y14;
        o_z14      <= i_z14;
        o_check14  <= o_check13;
    end
end

//      ____  _                     _ _  _   
//     / ___|| |_ __ _  __ _  ___  / | || |  
//     \___ \| __/ _` |/ _` |/ _ \ | | || |_ 
//      ___) | || (_| | (_| |  __/ | |__   _|
//     |____/ \__\__,_|\__, |\___| |_|  |_|  
//                     |___/                 
logic [31:0] shift_o_x14, shift_o_y14;

assign shift_o_x14 = {{14{o_x14[31]}}, o_x14[31:14]};
assign shift_o_y14 = {{14{o_y14[31]}}, o_y14[31:14]};

fullAdder32b fa_x14 (.a(o_x14), .b(shift_o_y14),  .cin(~o_z14[31]), .sum(i_x15));
fullAdder32b fa_y14 (.a(o_y14), .b(shift_o_x14),  .cin( o_z14[31]), .sum(i_y15));
fullAdder32b fa_z14 (.a(o_z14), .b(32'h00000004), .cin(~o_z14[31]), .sum(i_z15)); // arctan(2^-14) = 6.10351562e-5

always_ff @(posedge i_clk or negedge i_reset) begin
    if (~i_reset) begin
        o_x15      <= 32'b0;
        o_y15      <= 32'b0;
        o_z15      <= 32'b0;
        o_check15  <= 0;
    end else begin
        o_x15      <= i_x15;
        o_y15      <= i_y15;
        o_z15      <= i_z15;
        o_check15  <= o_check14;
    end
end

//      ____  _                     _ ____  
//     / ___|| |_ __ _  __ _  ___  / | ___| 
//     \___ \| __/ _` |/ _` |/ _ \ | |___ \ 
//      ___) | || (_| | (_| |  __/ | |___) |
//     |____/ \__\__,_|\__, |\___| |_|____/ 
//                     |___/                
logic [31:0] shift_o_x15, shift_o_y15;

assign shift_o_x15 = {{15{o_x15[31]}}, o_x15[31:15]};
assign shift_o_y15 = {{15{o_y15[31]}}, o_y15[31:15]};

fullAdder32b fa_x15 (.a(o_x15), .b(shift_o_y15),  .cin(~o_z15[31]), .sum(i_x16));
fullAdder32b fa_y15 (.a(o_y15), .b(shift_o_x15),  .cin( o_z15[31]), .sum(i_y16));
fullAdder32b fa_z15 (.a(o_z15), .b(32'h00000002), .cin(~o_z15[31]), .sum(i_z16)); // arctan(2^-15) = 3.05175781e-5

always_ff @(posedge i_clk or negedge i_reset) begin
	if (~i_reset) begin
        o_x_k_3   <= 32'b0;
        o_y_k_3   <= 32'b0;
		o_z16     <= 32'b0;
        o_check16 <= 0; 
	end else begin
        o_x_k_3   <= {i_x16[31], i_x16[31:1]}; // 0.5
        o_y_k_3   <= {i_y16[31], i_y16[31:1]}; // 0.5
		o_z16     <= i_z16;
        o_check16 <= o_check15;
    end
end

//      _           ____ /\      _____ 
//     / |    _    |___ \/\|    |___ / 
//     | |  _| |_    __) |  _____ |_ \ 
//     | | |_   _|  / __/  |_____|__) |
//     |_|   |_|   |_____|      |____/ 
//                                     
logic [31:0] shift_o_x_k_3, shift_o_y_k_3;

assign shift_o_x_k_3 = {{3{o_x_k_3[31]}}, o_x_k_3[31:3]};
assign shift_o_y_k_3 = {{3{o_y_k_3[31]}}, o_y_k_3[31:3]};

fullAdder32b fa_xk4 (.a(o_x_k_3), .b(shift_o_x_k_3), .cin(1'b0), .sum(i_x_k_4));
fullAdder32b fa_yk4 (.a(o_y_k_3), .b(shift_o_y_k_3), .cin(1'b0), .sum(i_y_k_4));

always_ff @(posedge i_clk or negedge i_reset) begin
    if (~i_reset) begin
        o_x_k_4   <= 32'b0;
        o_y_k_4   <= 32'b0;
        o_check17 <= 0;
    end else begin
        o_x_k_4   <= i_x_k_4;
        o_y_k_4   <= i_y_k_4;
        o_check17 <= o_check16;
    end
end

//      _           ____ /\       _  _   
//     / |    _    |___ \/\|     | || |  
//     | |  _| |_    __) |  _____| || |_ 
//     | | |_   _|  / __/  |_____|__   _|
//     |_|   |_|   |_____|          |_|  
//                                       
logic [31:0] shift_o_x_k_4, shift_o_y_k_4;

assign shift_o_x_k_4 = {{4{o_x_k_4[31]}}, o_x_k_4[31:4]};
assign shift_o_y_k_4 = {{4{o_y_k_4[31]}}, o_y_k_4[31:4]};

fullAdder32b fa_xk6 (.a(o_x_k_4), .b(shift_o_x_k_4), .cin(1'b0), .sum(i_x_k_6));
fullAdder32b fa_yk6 (.a(o_y_k_4), .b(shift_o_y_k_4), .cin(1'b0), .sum(i_y_k_6));

always_ff @(posedge i_clk or negedge i_reset) begin
    if (~i_reset) begin
        o_x_k_6   <= 32'b0;
        o_y_k_6   <= 32'b0;
        o_check18 <= 0;
    end else begin
        o_x_k_6   <= i_x_k_6;
        o_y_k_6   <= i_y_k_6;
        o_check18 <= o_check17;
    end
end

//      _           ____ /\        __   
//     / |    _    |___ \/\|      / /_  
//     | |  _| |_    __) |  _____| '_ \ 
//     | | |_   _|  / __/  |_____| (_) |
//     |_|   |_|   |_____|        \___/ 
//                                      
logic [31:0] shift_o_x_k_6, shift_o_y_k_6;

assign shift_o_x_k_6 = {{6{o_x_k_6[31]}}, o_x_k_6[31:6]};
assign shift_o_y_k_6 = {{6{o_y_k_6[31]}}, o_y_k_6[31:6]};

fullAdder32b fa_xk9 (.a(o_x_k_6), .b(shift_o_x_k_6), .cin(1'b0), .sum(i_x_k_9));
fullAdder32b fa_yk9 (.a(o_y_k_6), .b(shift_o_y_k_6), .cin(1'b0), .sum(i_y_k_9));

always_ff @(posedge i_clk or negedge i_reset) begin
	if (~i_reset) begin
        o_x_k_9   <= 32'b0;
        o_y_k_9   <= 32'b0;
        o_check19 <= 0;
    end else begin
        o_x_k_9   <= i_x_k_9;
        o_y_k_9   <= i_y_k_9;
        o_check19 <= o_check18;
    end
end

//      _           ____ /\       ___  
//     / |    _    |___ \/\|     / _ \ 
//     | |  _| |_    __) |  ____| (_) |
//     | | |_   _|  / __/  |_____\__, |
//     |_|   |_|   |_____|         /_/ 
//                                     
logic [31:0] shift_o_x_k_9, shift_o_y_k_9;

assign shift_o_x_k_9 = {{9{o_x_k_9[31]}}, o_x_k_9[31:9]};
assign shift_o_y_k_9 = {{9{o_y_k_9[31]}}, o_y_k_9[31:9]};

fullAdder32b fa_xk10 (.a(o_x_k_9), .b(shift_o_x_k_9), .cin(1'b0), .sum(i_x_k_10));
fullAdder32b fa_yk10 (.a(o_y_k_9), .b(shift_o_y_k_9), .cin(1'b0), .sum(i_y_k_10));

always_ff @(posedge i_clk or negedge i_reset) begin
	if (~i_reset) begin
        o_x_k_10  <= 32'b0;
        o_y_k_10  <= 32'b0;
        o_check20 <= 0;
    end else begin
        o_x_k_10  <= i_x_k_10;
        o_y_k_10  <= i_y_k_10;
        o_check20 <= o_check19;
    end
end

//      _           ____ /\       _  ___  
//     / |         |___ \/\|     / |/ _ \ 
//     | |  _____    __) |  _____| | | | |
//     | | |_____|  / __/  |_____| | |_| |
//     |_|         |_____|       |_|\___/ 
//                                        
logic [31:0] shift_o_x_k_10, shift_o_y_k_10;

assign shift_o_x_k_10 = {{10{o_x_k_10[31]}}, o_x_k_10[31:10]};
assign shift_o_y_k_10 = {{10{o_y_k_10[31]}}, o_y_k_10[31:10]};

fullAdder32b fa_xk11 (.a(o_x_k_10), .b(shift_o_x_k_10), .cin(1'b1), .sum(i_x_k_11));
fullAdder32b fa_yk11 (.a(o_y_k_10), .b(shift_o_y_k_10), .cin(1'b1), .sum(i_y_k_11));

always_ff @(posedge i_clk or negedge i_reset) begin
	if (~i_reset) begin
        o_x_k_11  <= 32'b0;
        o_y_k_11  <= 32'b0;
        o_check21 <= 0;
    end else begin
        o_x_k_11  <= i_x_k_11;
        o_y_k_11  <= i_y_k_11;
        o_check21 <= o_check20;
    end
end

//      _           ____ /\       _ _ 
//     / |         |___ \/\|     / / |
//     | |  _____    __) |  _____| | |
//     | | |_____|  / __/  |_____| | |
//     |_|         |_____|       |_|_|
//                                    
logic [31:0] shift_o_x_k_11, shift_o_y_k_11;

assign shift_o_x_k_11 = {{11{o_x_k_11[31]}}, o_x_k_11[31:11]};
assign shift_o_y_k_11 = {{11{o_y_k_11[31]}}, o_y_k_11[31:11]};

fullAdder32b fa_xk14 (.a(o_x_k_11), .b(shift_o_x_k_11), .cin(1'b1), .sum(i_x_k_14));
fullAdder32b fa_yk14 (.a(o_y_k_11), .b(shift_o_y_k_11), .cin(1'b1), .sum(i_y_k_14));

always_ff @(posedge i_clk or negedge i_reset) begin
	if (~i_reset) begin
        o_x_k_14  <= 32'b0;
        o_y_k_14  <= 32'b0;
        o_check22 <= 0;
    end else begin
        o_x_k_14  <= i_x_k_14;
        o_y_k_14  <= i_y_k_14;
        o_check22 <= o_check21;
    end
end

//      _           ____ /\       _ _  _   
//     / |         |___ \/\|     / | || |  
//     | |  _____    __) |  _____| | || |_ 
//     | | |_____|  / __/  |_____| |__   _|
//     |_|         |_____|       |_|  |_|  
//                                         
logic [31:0] shift_o_x_k_14, shift_o_y_k_14;

assign shift_o_x_k_14 = {{14{o_x_k_14[31]}}, o_x_k_14[31:14]};
assign shift_o_y_k_14 = {{14{o_y_k_14[31]}}, o_y_k_14[31:14]};

fullAdder32b o_fa_xk (.a(o_x_k_14), .b(shift_o_x_k_14), .cin(1'b1), .sum(x));
fullAdder32b o_fa_yk (.a(o_y_k_14), .b(shift_o_y_k_14), .cin(1'b1), .sum(y));

//      ____                 _ _        _       _  _                                _
//     |  _ \ ___  ___ _   _| | |_     / \   __| |(_)_   _ ___ _ __ ___   ___ _ __ | |_
//     | |_) / _ \/ __| | | | | __|   / _ \ / _` || | | | / __| '_ ` _ \ / _ \ '_ \| __|
//     |  _ <  __/\__ \ |_| | | |_   / ___ \ (_| || | |_| \__ \ | | | | |  __/ | | | |_
//     |_| \_\___||___/\__,_|_|\__| /_/   \_\__,_|/ |\__,_|___/_| |_| |_|\___|_| |_|\__|
//                                              |__/                                    

mux4to1 muxresultx (.i_data_0(x), .i_data_1(~x + 32'b1), .i_data_2(x), .i_data_3(32'b0), .i_sel(o_check22[1:0]), .o_data(x1));
mux4to1 muxresulty (.i_data_0(y), .i_data_1(~y + 32'b1), .i_data_2(y), .i_data_3(32'b0), .i_sel(o_check22[1:0]), .o_data(y1));

always @(*) begin
    case (o_check22[5:2])
        4'b0001: begin
            o_x = delay23_x;
            o_y = 32'b00000000000000000000000000000000;
        end
        4'b0010: begin
            o_x = 32'b00000000000000000000000000000000;
            o_y = delay23_y;
        end
        4'b0100: begin
            o_x = ~delay23_x + 32'b1;
            o_y = 32'b00000000000000000000000000000000;
        end
        4'b1000: begin
            o_x = 32'b00000000000000000000000000000000;
            o_y = ~delay23_y + 32'b1;
        end
        default: begin
            o_x = x1;
            o_y = y1;
        end
    endcase
end

endmodule
