module cordic (
	input logic i_clk, i_reset,
	input logic [31:0] i_x, i_y, i_z,
	output logic [31:0] o_x, o_y
);

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

//      ____  _                      ___  
//     / ___|| |_ __ _  __ _  ___   / _ \ 
//     \___ \| __/ _` |/ _` |/ _ \ | | | |
//      ___) | || (_| | (_| |  __/ | |_| |
//     |____/ \__\__,_|\__, |\___|  \___/ 
//                     |___/              
fpu_add_sub fpu_x0 (.i_a(i_x), .i_b(i_y), .i_control(~i_z[31]), .o_result(i_x1));
always_ff @(posedge i_clk or negedge i_reset) begin
	if (~i_reset) 
		o_x1 <= 32'b0;
	else
		o_x1 <= i_x1;
end

fpu_add_sub fpu_y0 (.i_a(i_y), .i_b(i_x), .i_control(i_z[31]), .o_result(i_y1));
always_ff @(posedge i_clk or negedge i_reset) begin
	if (~i_reset) 
		o_y1 <= 32'b0;
	else
		o_y1 <= i_y1;
end

fpu_add_sub fpu_z0 (.i_a(i_z), .i_b(32'b0_01111110_10010010000111111011011), .i_control(~i_z[31]), .o_result(i_z1)); // arctan(2^-0) = 0.7853981634
always_ff @(posedge i_clk or negedge i_reset) begin
	if (~i_reset) 
		o_z1 <= 32'b0;
	else
		o_z1 <= i_z1;
end

//      ____  _                     _ 
//     / ___|| |_ __ _  __ _  ___  / |
//     \___ \| __/ _` |/ _` |/ _ \ | |
//      ___) | || (_| | (_| |  __/ | |
//     |____/ \__\__,_|\__, |\___| |_|
//                     |___/          
logic [7:0] shift_o_x1, shift_o_y1;

fullAdder8b shift_x1 (.a(o_x1[30:23]), .b(8'b1), .cin(1'b1), .sum(shift_o_x1));
fullAdder8b shift_y1 (.a(o_y1[30:23]), .b(8'b1), .cin(1'b1), .sum(shift_o_y1));

fpu_add_sub fpu_x1 (.i_a(o_x1), .i_b({o_y1[31], shift_o_y1, o_y1[22:0]}), .i_control(~o_z1[31]), .o_result(i_x2)); 
always_ff @(posedge i_clk or negedge i_reset) begin
	if (~i_reset) 
		o_x2 <= 32'b0;
	else
		o_x2 <= i_x2;
end

fpu_add_sub fpu_y1 (.i_a(o_y1), .i_b({o_x1[31], shift_o_x1, o_x1[22:0]}), .i_control(o_z1[31]), .o_result(i_y2));
always_ff @(posedge i_clk or negedge i_reset) begin
	if (~i_reset) 
		o_y2 <= 32'b0;
	else
		o_y2 <= i_y2;
end

fpu_add_sub fpu_z1 (.i_a(o_z1), .i_b(32'b0_01111101_11011010110001100111000), .i_control(~o_z1[31]), .o_result(i_z2)); // arctan(2^-1) = 0.463647609
always_ff @(posedge i_clk or negedge i_reset) begin
	if (~i_reset)
		o_z2 <= 32'b0;
	else
		o_z2 <= i_z2;
end

//      ____  _                     ____  
//     / ___|| |_ __ _  __ _  ___  |___ \ 
//     \___ \| __/ _` |/ _` |/ _ \   __) |
//      ___) | || (_| | (_| |  __/  / __/ 
//     |____/ \__\__,_|\__, |\___| |_____|
//                     |___/              
logic [7:0] shift_o_x2, shift_o_y2;

fullAdder8b shift_x2 (.a(o_x2[30:23]), .b(8'h2), .cin(1'b1), .sum(shift_o_x2));
fullAdder8b shift_y2 (.a(o_y2[30:23]), .b(8'h2), .cin(1'b1), .sum(shift_o_y2));

fpu_add_sub fpu_x2 (.i_a(o_x2), .i_b({o_y2[31], shift_o_y2, o_y2[22:0]}), .i_control(~o_z2[31]), .o_result(i_x3));
always_ff @(posedge i_clk or negedge i_reset) begin
	if (~i_reset) 
		o_x3 <= 32'b0;
	else
		o_x3 <= i_x3;
end

fpu_add_sub fpu_y2 (.i_a(o_y2), .i_b({o_x2[31], shift_o_x2, o_x2[22:0]}), .i_control(o_z2[31]), .o_result(i_y3));
always_ff @(posedge i_clk or negedge i_reset) begin
	if (~i_reset)
		o_y3 <= 32'b0;
	else
		o_y3 <= i_y3;
end

fpu_add_sub fpu_z2 (.i_a(o_z2), .i_b(32'b0_01111100_11110101101101110110000), .i_control(~o_z2[31]), .o_result(i_z3)); // arctan(2^-2) = 0.2449786631
always_ff @(posedge i_clk or negedge i_reset) begin
	if (~i_reset)
		o_z3 <= 32'b0;
	else
		o_z3 <= i_z3;
end

//      ____  _                     _____ 
//     / ___|| |_ __ _  __ _  ___  |___ / 
//     \___ \| __/ _` |/ _` |/ _ \   |_ \ 
//      ___) | || (_| | (_| |  __/  ___) |
//     |____/ \__\__,_|\__, |\___| |____/ 
//                     |___/              
logic [7:0] shift_o_x3, shift_o_y3;

fullAdder8b shift_x3 (.a(o_x3[30:23]), .b(8'h3), .cin(1'b1), .sum(shift_o_x3));
fullAdder8b shift_y3 (.a(o_y3[30:23]), .b(8'h3), .cin(1'b1), .sum(shift_o_y3));

fpu_add_sub fpu_x3 (.i_a(o_x3), .i_b({o_y3[31], shift_o_y3, o_y3[22:0]}), .i_control(~o_z3[31]), .o_result(i_x4));
always_ff @(posedge i_clk or negedge i_reset) begin
	if (~i_reset) 
		o_x4 <= 32'b0;
   else
      o_x4 <= i_x4;
end

fpu_add_sub fpu_y3 (.i_a(o_y3), .i_b({o_x3[31], shift_o_x3, o_x3[22:0]}), .i_control(o_z3[31]), .o_result(i_y4));
always_ff @(posedge i_clk or negedge i_reset) begin
	if (~i_reset) 
		o_y4 <= 32'b0;
	else
		o_y4 <= i_y4;
end

fpu_add_sub fpu_z3 (.i_a(o_z3), .i_b(32'b0_01111011_11111101010110111010101), .i_control(~o_z3[31]), .o_result(i_z4)); // arctan(2^-3) = 0.1243549945
always_ff @(posedge i_clk or negedge i_reset) begin
	if (~i_reset)
		o_z4 <= 32'b0;
	else
		o_z4 <= i_z4;
end

//      ____  _                     _  _   
//     / ___|| |_ __ _  __ _  ___  | || |  
//     \___ \| __/ _` |/ _` |/ _ \ | || |_ 
//      ___) | || (_| | (_| |  __/ |__   _|
//     |____/ \__\__,_|\__, |\___|    |_|  
//                     |___/               
logic [7:0] shift_o_x4, shift_o_y4;

fullAdder8b shift_x4 (.a(o_x4[30:23]), .b(8'h4), .cin(1'b1), .sum(shift_o_x4));
fullAdder8b shift_y4 (.a(o_y4[30:23]), .b(8'h4), .cin(1'b1), .sum(shift_o_y4));

fpu_add_sub fpu_x4 (.i_a(o_x4), .i_b({o_y4[31], shift_o_y4, o_y4[22:0]}), .i_control(~o_z4[31]), .o_result(i_x5));
always_ff @(posedge i_clk or negedge i_reset) begin
	if (~i_reset) 
		o_x5 <= 32'b0;
   else
      o_x5 <= i_x5;
end

fpu_add_sub fpu_y4 (.i_a(o_y4), .i_b({o_x4[31], shift_o_x4, o_x4[22:0]}), .i_control(o_z4[31]), .o_result(i_y5));
always_ff @(posedge i_clk or negedge i_reset) begin
	if (~i_reset) 
		o_y5 <= 32'b0;
   else
      o_y5 <= i_y5;
end

fpu_add_sub fpu_z4 (.i_a(o_z4), .i_b(32'b0_01111010_11111111010101011011110), .i_control(~o_z4[31]), .o_result(i_z5)); // arctan(2^-4) = 0.06241881
always_ff @(posedge i_clk or negedge i_reset) begin
	if (~i_reset)
		o_z5 <= 32'b0;
	else
		o_z5 <= i_z5;
end

//      ____  _                     ____  
//     / ___|| |_ __ _  __ _  ___  | ___| 
//     \___ \| __/ _` |/ _` |/ _ \ |___ \ 
//      ___) | || (_| | (_| |  __/  ___) |
//     |____/ \__\__,_|\__, |\___| |____/ 
//                     |___/              
logic [7:0] shift_o_x5, shift_o_y5;

fullAdder8b shift_x5 (.a(o_x5[30:23]), .b(8'h5), .cin(1'b1), .sum(shift_o_x5));
fullAdder8b shift_y5 (.a(o_y5[30:23]), .b(8'h5), .cin(1'b1), .sum(shift_o_y5));

fpu_add_sub fpu_x5 (.i_a(o_x5), .i_b({o_y5[31], shift_o_y5, o_y5[22:0]}), .i_control(~o_z5[31]), .o_result(i_x6));
always_ff @(posedge i_clk or negedge i_reset) begin
	if (~i_reset) 
		o_x6 <= 32'b0;
   else
      o_x6 <= i_x6;
end

fpu_add_sub fpu_y5 (.i_a(o_y5), .i_b({o_x5[31], shift_o_x5, o_x5[22:0]}), .i_control(o_z5[31]), .o_result(i_y6));
always_ff @(posedge i_clk or negedge i_reset) begin
	if (~i_reset) 
		o_y6 <= 32'b0;
   else
      o_y6 <= i_y6;
end

fpu_add_sub fpu_z5 (.i_a(o_z5), .i_b(32'b0_01111001_11111111110101010101110), .i_control(~o_z5[31]), .o_result(i_z6)); // arctan(2^-5) = 0.03123983343
always_ff @(posedge i_clk or negedge i_reset) begin
	if (~i_reset)
		o_z6 <= 32'b0;
	else
		o_z6 <= i_z6;
end

//      ____  _                      __   
//     / ___|| |_ __ _  __ _  ___   / /_  
//     \___ \| __/ _` |/ _` |/ _ \ | '_ \ 
//      ___) | || (_| | (_| |  __/ | (_) |
//     |____/ \__\__,_|\__, |\___|  \___/ 
//                     |___/              
logic [7:0] shift_o_x6, shift_o_y6;

fullAdder8b shift_x6 (.a(o_x6[30:23]), .b(8'h6), .cin(1'b1), .sum(shift_o_x6));
fullAdder8b shift_y6 (.a(o_y6[30:23]), .b(8'h6), .cin(1'b1), .sum(shift_o_y6));

fpu_add_sub fpu_x6 (.i_a(o_x6), .i_b({o_y6[31], shift_o_y6, o_y6[22:0]}), .i_control(~o_z6[31]), .o_result(i_x7));
always_ff @(posedge i_clk or negedge i_reset) begin
	if (~i_reset) 
		o_x7 <= 32'b0;
   else
      o_x7 <= i_x7;
end

fpu_add_sub fpu_y6 (.i_a(o_y6), .i_b({o_x6[31], shift_o_x6, o_x6[22:0]}), .i_control(o_z6[31]), .o_result(i_y7));
always_ff @(posedge i_clk or negedge i_reset) begin
	if (~i_reset) 
		o_y7 <= 32'b0;
   else
      o_y7 <= i_y7;
end

fpu_add_sub fpu_z6 (.i_a(o_z6), .i_b(32'b0_01111000_11111111111101010101011), .i_control(~o_z6[31]), .o_result(i_z7)); // arctan(2^-6) = 0.01562372862
always_ff @(posedge i_clk or negedge i_reset) begin
	if (~i_reset)
		o_z7 <= 32'b0;
	else
		o_z7 <= i_z7;
end

//      ____  _                     _____ 
//     / ___|| |_ __ _  __ _  ___  |___  |
//     \___ \| __/ _` |/ _` |/ _ \    / / 
//      ___) | || (_| | (_| |  __/   / /  
//     |____/ \__\__,_|\__, |\___|  /_/   
//                     |___/              
logic [7:0] shift_o_x7, shift_o_y7;

fullAdder8b shift_x7 (.a(o_x7[30:23]), .b(8'h7), .cin(1'b1), .sum(shift_o_x7));
fullAdder8b shift_y7 (.a(o_y7[30:23]), .b(8'h7), .cin(1'b1), .sum(shift_o_y7));

fpu_add_sub fpu_x7 (.i_a(o_x7), .i_b({o_y7[31], shift_o_y7, o_y7[22:0]}), .i_control(~o_z7[31]), .o_result(i_x8));
always_ff @(posedge i_clk or negedge i_reset) begin
	if (~i_reset) 
		o_x8 <= 32'b0;
   else
      o_x8 <= i_x8;
end

fpu_add_sub fpu_y7 (.i_a(o_y7), .i_b({o_x7[31], shift_o_x7, o_x7[22:0]}), .i_control(o_z7[31]), .o_result(i_y8));
always_ff @(posedge i_clk or negedge i_reset) begin
	if (~i_reset) 
		o_y8 <= 32'b0;
   else
      o_y8 <= i_y8;
end

fpu_add_sub fpu_z7 (.i_a(o_z7), .i_b(32'b0_01110111_11111111111111010101011), .i_control(~o_z7[31]), .o_result(i_z8)); // arctan(2^-7) = 0.00781234106
always_ff @(posedge i_clk or negedge i_reset) begin
	if (~i_reset)
		o_z8 <= 32'b0;
	else
		o_z8 <= i_z8;
end

//      ____  _                      ___  
//     / ___|| |_ __ _  __ _  ___   ( _ ) 
//     \___ \| __/ _` |/ _` |/ _ \  / _ \ 
//      ___) | || (_| | (_| |  __/ | (_) |
//     |____/ \__\__,_|\__, |\___|  \___/ 
//                     |___/              
logic [7:0] shift_o_x8, shift_o_y8;

fullAdder8b shift_x8 (.a(o_x8[30:23]), .b(8'h8), .cin(1'b1), .sum(shift_o_x8));
fullAdder8b shift_y8 (.a(o_y8[30:23]), .b(8'h8), .cin(1'b1), .sum(shift_o_y8));

fpu_add_sub fpu_x8 (.i_a(o_x8), .i_b({o_y8[31], shift_o_y8, o_y8[22:0]}), .i_control(~o_z8[31]), .o_result(i_x9));
always_ff @(posedge i_clk or negedge i_reset) begin
	if (~i_reset) 
		o_x9 <= 32'b0;
   else
      o_x9 <= i_x9;
end

fpu_add_sub fpu_y8 (.i_a(o_y8), .i_b({o_x8[31], shift_o_x8, o_x8[22:0]}), .i_control(o_z8[31]), .o_result(i_y9));
always_ff @(posedge i_clk or negedge i_reset) begin
	if (~i_reset) 
		o_y9 <= 32'b0;
   else
      o_y9 <= i_y9;
end

fpu_add_sub fpu_z8 (.i_a(o_z8), .i_b(32'b0_01110110_11111111111111110101011), .i_control(~o_z8[31]), .o_result(i_z9)); // arctan(2^-8) = 0.003906230132
always_ff @(posedge i_clk or negedge i_reset) begin
	if (~i_reset)
		o_z9 <= 32'b0;
	else
		o_z9 <= i_z9;
end

//      ____  _                      ___  
//     / ___|| |_ __ _  __ _  ___   / _ \ 
//     \___ \| __/ _` |/ _` |/ _ \ | (_) |
//      ___) | || (_| | (_| |  __/  \__, |
//     |____/ \__\__,_|\__, |\___|    /_/ 
//                     |___/              
logic [7:0] shift_o_x9, shift_o_y9;

fullAdder8b shift_x9 (.a(o_x9[30:23]), .b(8'h9), .cin(1'b1), .sum(shift_o_x9));
fullAdder8b shift_y9 (.a(o_y9[30:23]), .b(8'h9), .cin(1'b1), .sum(shift_o_y9));

fpu_add_sub fpu_x9 (.i_a(o_x9), .i_b({o_y9[31], shift_o_y9, o_y9[22:0]}), .i_control(~o_z9[31]), .o_result(i_x10));
always_ff @(posedge i_clk or negedge i_reset) begin
	if (~i_reset) 
		o_x10 <= 32'b0;
   else
		o_x10 <= i_x10;
end

fpu_add_sub fpu_y9 (.i_a(o_y9), .i_b({o_x9[31], shift_o_x9, o_x9[22:0]}), .i_control(o_z9[31]), .o_result(i_y10));
always_ff @(posedge i_clk or negedge i_reset) begin
	if (~i_reset) 
		o_y10 <= 32'b0;
   else
      o_y10 <= i_y10;
end

fpu_add_sub fpu_z9 (.i_a(o_z9), .i_b(32'b0_01110101_11111111111111111101011), .i_control(~o_z9[31]), .o_result(i_z10)); // arctan(2^-9) = 0.001953122516
always_ff @(posedge i_clk or negedge i_reset) begin
	if (~i_reset)
		o_z10 <= 32'b0;
	else
		o_z10 <= i_z10;
end

//      ____  _                     _  ___  
//     / ___|| |_ __ _  __ _  ___  / |/ _ \ 
//     \___ \| __/ _` |/ _` |/ _ \ | | | | |
//      ___) | || (_| | (_| |  __/ | | |_| |
//     |____/ \__\__,_|\__, |\___| |_|\___/ 
//                     |___/                
logic [7:0] shift_o_x10, shift_o_y10;

fullAdder8b shift_x10 (.a(o_x10[30:23]), .b(8'hA), .cin(1'b1), .sum(shift_o_x10));
fullAdder8b shift_y10 (.a(o_y10[30:23]), .b(8'hA), .cin(1'b1), .sum(shift_o_y10));

fpu_add_sub fpu_x10 (.i_a(o_x10), .i_b({o_y10[31], shift_o_y10, o_y10[22:0]}), .i_control(~o_z10[31]), .o_result(i_x11));
always_ff @(posedge i_clk or negedge i_reset) begin
	if (~i_reset) 
		o_x11 <= 32'b0;
   else
		o_x11 <= i_x11;
end

fpu_add_sub fpu_y10 (.i_a(o_y10), .i_b({o_x10[31], shift_o_x10, o_x10[22:0]}), .i_control(o_z10[31]), .o_result(i_y11));
always_ff @(posedge i_clk or negedge i_reset) begin
	if (~i_reset) 
		o_y11 <= 32'b0;
   else
		o_y11 <= i_y11;
end

fpu_add_sub fpu_z10 (.i_a(o_z10), .i_b(32'b0_01110100_11111111111111111111011), .i_control(~o_z10[31]), .o_result(i_z11)); // arctan(2^-10) = 9.7656219e-4
always_ff @(posedge i_clk or negedge i_reset) begin
	if (~i_reset)
		o_z11 <= 32'b0;
	else
		o_z11 <= i_z11;
end

//      ____  _                     _ _ 
//     / ___|| |_ __ _  __ _  ___  / / |
//     \___ \| __/ _` |/ _` |/ _ \ | | |
//      ___) | || (_| | (_| |  __/ | | |
//     |____/ \__\__,_|\__, |\___| |_|_|
//                     |___/            
logic [7:0] shift_o_x11, shift_o_y11;

fullAdder8b shift_x11 (.a(o_x11[30:23]), .b(8'hB), .cin(1'b1), .sum(shift_o_x11));
fullAdder8b shift_y11 (.a(o_y11[30:23]), .b(8'hB), .cin(1'b1), .sum(shift_o_y11));

fpu_add_sub fpu_x11 (.i_a(o_x11), .i_b({o_y11[31], shift_o_y11, o_y11[22:0]}), .i_control(~o_z11[31]), .o_result(i_x12));
always_ff @(posedge i_clk or negedge i_reset) begin
	if (~i_reset) 
		o_x12 <= 32'b0;
   else
      o_x12 <= i_x12;
end

fpu_add_sub fpu_y11 (.i_a(o_y11), .i_b({o_x11[31], shift_o_x11, o_x11[22:0]}), .i_control(o_z11[31]), .o_result(i_y12));
always_ff @(posedge i_clk or negedge i_reset) begin
	if (~i_reset) 
		o_y12 <= 32'b0;
   else
      o_y12 <= i_y12;
end

fpu_add_sub fpu_z11 (.i_a(o_z11), .i_b(32'b0_01110011_11111111111111111111111), .i_control(~o_z11[31]), .o_result(i_z12)); // arctan(2^-11) = 4.88281211e-4
always_ff @(posedge i_clk or negedge i_reset) begin
	if (~i_reset)
		o_z12 <= 32'b0;
	else
		o_z12 <= i_z12;
end

//      ____  _                     _ ____  
//     / ___|| |_ __ _  __ _  ___  / |___ \ 
//     \___ \| __/ _` |/ _` |/ _ \ | | __) |
//      ___) | || (_| | (_| |  __/ | |/ __/ 
//     |____/ \__\__,_|\__, |\___| |_|_____|
//                     |___/                
logic [7:0] shift_o_x12, shift_o_y12;

fullAdder8b shift_x12 (.a(o_x12[30:23]), .b(8'hC), .cin(1'b1), .sum(shift_o_x12));
fullAdder8b shift_y12 (.a(o_y12[30:23]), .b(8'hC), .cin(1'b1), .sum(shift_o_y12));

fpu_add_sub fpu_x12 (.i_a(o_x12), .i_b({o_y12[31], shift_o_y12, o_y12[22:0]}), .i_control(~o_z12[31]), .o_result(i_x13));
always_ff @(posedge i_clk or negedge i_reset) begin
	if (~i_reset) 
		o_x13 <= 32'b0;
   else
      o_x13 <= i_x13;
end

fpu_add_sub fpu_y12 (.i_a(o_y12), .i_b({o_x12[31], shift_o_x12, o_x12[22:0]}), .i_control(o_z12[31]), .o_result(i_y13));
always_ff @(posedge i_clk or negedge i_reset) begin
	if (~i_reset) 
		o_y13 <= 32'b0;
   else
      o_y13 <= i_y13;
end

fpu_add_sub fpu_z12 (.i_a(o_z12), .i_b(32'b0_01110011_00000000000000000000000), .i_control(~o_z12[31]), .o_result(i_z13)); // arctan(2^-12) = 2.4414062e-4
always_ff @(posedge i_clk or negedge i_reset) begin
	if (~i_reset)
		o_z13 <= 32'b0;
	else
		o_z13 <= i_z13;
end

//      ____  _                     _ _____ 
//     / ___|| |_ __ _  __ _  ___  / |___ / 
//     \___ \| __/ _` |/ _` |/ _ \ | | |_ \ 
//      ___) | || (_| | (_| |  __/ | |___) |
//     |____/ \__\__,_|\__, |\___| |_|____/ 
//                     |___/                
logic [7:0] shift_o_x13, shift_o_y13;

fullAdder8b shift_x13 (.a(o_x13[30:23]), .b(8'hD), .cin(1'b1), .sum(shift_o_x13));
fullAdder8b shift_y13 (.a(o_y13[30:23]), .b(8'hD), .cin(1'b1), .sum(shift_o_y13));

fpu_add_sub fpu_x13 (.i_a(o_x13), .i_b({o_y13[31], shift_o_y13, o_y13[22:0]}), .i_control(~o_z13[31]), .o_result(i_x14));
always_ff @(posedge i_clk or negedge i_reset) begin
	if (~i_reset) 
		o_x14 <= 32'b0;
   else
      o_x14 <= i_x14;
end

fpu_add_sub fpu_y13 (.i_a(o_y13), .i_b({o_x13[31], shift_o_x13, o_x13[22:0]}), .i_control(o_z13[31]), .o_result(i_y14));
always_ff @(posedge i_clk or negedge i_reset) begin
	if (~i_reset) 
		o_y14 <= 32'b0;
   else
      o_y14 <= i_y14;
end

fpu_add_sub fpu_z13 (.i_a(o_z13), .i_b(32'b0_01110010_00000000000000000000000), .i_control(~o_z13[31]), .o_result(i_z14)); // arctan(2^-13) = 1.22070312e-4
always_ff @(posedge i_clk or negedge i_reset) begin
	if (~i_reset)
		o_z14 <= 32'b0;
	else
		o_z14 <= i_z14;
end

//      ____  _                     _ _  _   
//     / ___|| |_ __ _  __ _  ___  / | || |  
//     \___ \| __/ _` |/ _` |/ _ \ | | || |_ 
//      ___) | || (_| | (_| |  __/ | |__   _|
//     |____/ \__\__,_|\__, |\___| |_|  |_|  
//                     |___/                 
logic [7:0] shift_o_x14, shift_o_y14;

fullAdder8b shift_x14 (.a(o_x14[30:23]), .b(8'hE), .cin(1'b1), .sum(shift_o_x14));
fullAdder8b shift_y14 (.a(o_y14[30:23]), .b(8'hE), .cin(1'b1), .sum(shift_o_y14));

fpu_add_sub fpu_x14 (.i_a(o_x14), .i_b({o_y14[31], shift_o_y14, o_y14[22:0]}), .i_control(~o_z14[31]), .o_result(i_x15));
always_ff @(posedge i_clk or negedge i_reset) begin
	if (~i_reset) 
		o_x15 <= 32'b0;
   else
      o_x15 <= i_x15;
end

fpu_add_sub fpu_y14 (.i_a(o_y14), .i_b({o_x14[31], shift_o_x14, o_x14[22:0]}), .i_control(o_z14[31]), .o_result(i_y15));
always_ff @(posedge i_clk or negedge i_reset) begin
	if (~i_reset) 
		o_y15 <= 32'b0;
   else
      o_y15 <= i_y15;
end

fpu_add_sub fpu_z14 (.i_a(o_z14), .i_b(32'b0_01110001_00000000000000000000000), .i_control(~o_z14[31]), .o_result(i_z15)); // arctan(2^-14) = 6.10351562e-5
always_ff @(posedge i_clk or negedge i_reset) begin
	if (~i_reset)
		o_z15 <= 32'b0;
	else
		o_z15 <= i_z15;
end

//      ____  _                     _ ____  
//     / ___|| |_ __ _  __ _  ___  / | ___| 
//     \___ \| __/ _` |/ _` |/ _ \ | |___ \ 
//      ___) | || (_| | (_| |  __/ | |___) |
//     |____/ \__\__,_|\__, |\___| |_|____/ 
//                     |___/                
logic [7:0] shift_o_x15, shift_o_y15;
logic [7:0] shift_i_x16, shift_i_y16;

fullAdder8b shift_x15 (.a(o_x15[30:23]), .b(8'hF), .cin(1'b1), .sum(shift_o_x15));
fullAdder8b shift_y15 (.a(o_y15[30:23]), .b(8'hF), .cin(1'b1), .sum(shift_o_y15));

fpu_add_sub fpu_x15 (.i_a(o_x15), .i_b({o_y15[31], shift_o_y15, o_y15[22:0]}), .i_control(~o_z15[31]), .o_result(i_x16));
fullAdder8b shift_x16 (.a(i_x16[30:23]), .b(8'h1), .cin(1'b1), .sum(shift_i_x16));
always_ff @(posedge i_clk or negedge i_reset) begin
	if (~i_reset) 
		o_x_k_3 <= 32'b0;
   else
      o_x_k_3 <= {i_x16[31], shift_i_x16, i_x16[22:0]}; // 0.5
end

fpu_add_sub fpu_y15 (.i_a(o_y15), .i_b({o_x15[31], shift_o_x15, o_x15[22:0]}), .i_control(o_z15[31]), .o_result(i_y16));
fullAdder8b shift_y16 (.a(i_y16[30:23]), .b(8'h1), .cin(1'b1), .sum(shift_i_y16));
always_ff @(posedge i_clk or negedge i_reset) begin
	if (~i_reset) 
       o_y_k_3 <= 32'b0;
   else
       o_y_k_3 <= {i_y16[31], shift_i_y16, i_y16[22:0]}; // 0.5
end

fpu_add_sub fpu_z15 (.i_a(o_z15), .i_b(32'b0_01110000_00000000000000000000000), .i_control(~o_z15[31]), .o_result(i_z16)); // arctan(2^-15) = 3.05175781e-5
always_ff @(posedge i_clk or negedge i_reset) begin
	if (~i_reset)
		o_z16 <= 32'b0;
	else
		o_z16 <= i_z16;
end

//      _           ____ /\      _____ 
//     / |    _    |___ \/\|    |___ / 
//     | |  _| |_    __) |  _____ |_ \ 
//     | | |_   _|  / __/  |_____|__) |
//     |_|   |_|   |_____|      |____/ 
//                                     
logic [7:0] shift_o_x_k_3, shift_o_y_k_3;

fullAdder8b shift_x_k_3 (.a(o_x_k_3[30:23]), .b(8'h3), .cin(1'b1), .sum(shift_o_x_k_3));
fullAdder8b shift_y_k_3 (.a(o_y_k_3[30:23]), .b(8'h3), .cin(1'b1), .sum(shift_o_y_k_3));

fpu_add_sub fpu_xk4 (.i_a(o_x_k_3), .i_b({o_x_k_3[31], shift_o_x_k_3, o_x_k_3[22:0]}), .i_control(1'b0), .o_result(i_x_k_4));
always_ff @(posedge i_clk or negedge i_reset) begin
	if (~i_reset) 
       o_x_k_4 <= 32'b0;
   else
       o_x_k_4 <= i_x_k_4;
end

fpu_add_sub fpu_yk4 (.i_a(o_y_k_3), .i_b({o_y_k_3[31], shift_o_y_k_3, o_y_k_3[22:0]}), .i_control(1'b0), .o_result(i_y_k_4));
always_ff @(posedge i_clk or negedge i_reset) begin
	if (~i_reset) 
       o_y_k_4 <= 32'b0;
   else
       o_y_k_4 <= i_y_k_4;
end

//      _           ____ /\       _  _   
//     / |    _    |___ \/\|     | || |  
//     | |  _| |_    __) |  _____| || |_ 
//     | | |_   _|  / __/  |_____|__   _|
//     |_|   |_|   |_____|          |_|  
//                                       
logic [7:0] shift_o_x_k_4, shift_o_y_k_4;

fullAdder8b shift_x_k_4 (.a(o_x_k_4[30:23]), .b(8'h4), .cin(1'b1), .sum(shift_o_x_k_4));
fullAdder8b shift_y_k_4 (.a(o_y_k_4[30:23]), .b(8'h4), .cin(1'b1), .sum(shift_o_y_k_4));

fpu_add_sub fpu_xk6 (.i_a(o_x_k_4), .i_b({o_x_k_4[31], shift_o_x_k_4, o_x_k_4[22:0]}), .i_control(1'b0), .o_result(i_x_k_6));
always_ff @(posedge i_clk or negedge i_reset) begin
	if (~i_reset) 
       o_x_k_6 <= 32'b0;
   else
       o_x_k_6 <= i_x_k_6;
end

fpu_add_sub fpu_yk6 (.i_a(o_y_k_4), .i_b({o_y_k_4[31], shift_o_y_k_4, o_y_k_4[22:0]}), .i_control(1'b0), .o_result(i_y_k_6));
always_ff @(posedge i_clk or negedge i_reset) begin
	if (~i_reset) 
       o_y_k_6 <= 32'b0;
   else
       o_y_k_6 <= i_y_k_6;
end

//      _           ____ /\        __   
//     / |    _    |___ \/\|      / /_  
//     | |  _| |_    __) |  _____| '_ \ 
//     | | |_   _|  / __/  |_____| (_) |
//     |_|   |_|   |_____|        \___/ 
//                                      
logic [7:0] shift_o_x_k_6, shift_o_y_k_6;

fullAdder8b shift_x_k_6 (.a(o_x_k_6[30:23]), .b(8'h6), .cin(1'b1), .sum(shift_o_x_k_6));
fullAdder8b shift_y_k_6 (.a(o_y_k_6[30:23]), .b(8'h6), .cin(1'b1), .sum(shift_o_y_k_6));

fpu_add_sub fpu_xk9 (.i_a(o_x_k_6), .i_b({o_x_k_6[31], shift_o_x_k_6, o_x_k_6[22:0]}), .i_control(1'b0), .o_result(i_x_k_9));
always_ff @(posedge i_clk or negedge i_reset) begin
	if (~i_reset) 
       o_x_k_9 <= 32'b0;
   else
       o_x_k_9 <= i_x_k_9;
end

fpu_add_sub fpu_yk9 (.i_a(o_y_k_6), .i_b({o_y_k_6[31], shift_o_y_k_6, o_y_k_6[22:0]}), .i_control(1'b0), .o_result(i_y_k_9));
always_ff @(posedge i_clk or negedge i_reset) begin
	if (~i_reset) 
       o_y_k_9 <= 32'b0;
   else
       o_y_k_9 <= i_y_k_9;
end

//      _           ____ /\       ___  
//     / |    _    |___ \/\|     / _ \ 
//     | |  _| |_    __) |  ____| (_) |
//     | | |_   _|  / __/  |_____\__, |
//     |_|   |_|   |_____|         /_/ 
//                                     
logic [7:0] shift_o_x_k_9, shift_o_y_k_9;

fullAdder8b shift_x_k_9 (.a(o_x_k_9[30:23]), .b(8'h9), .cin(1'b1), .sum(shift_o_x_k_9));
fullAdder8b shift_y_k_9 (.a(o_y_k_9[30:23]), .b(8'h9), .cin(1'b1), .sum(shift_o_y_k_9));

fpu_add_sub fpu_xk10 (.i_a(o_x_k_9), .i_b({o_x_k_9[31], shift_o_x_k_9, o_x_k_9[22:0]}), .i_control(1'b0), .o_result(i_x_k_10));
always_ff @(posedge i_clk or negedge i_reset) begin
	if (~i_reset) 
       o_x_k_10 <= 32'b0;
   else
       o_x_k_10 <= i_x_k_10;
end

fpu_add_sub fpu_yk10 (.i_a(o_y_k_9), .i_b({o_y_k_9[31], shift_o_y_k_9, o_y_k_9[22:0]}), .i_control(1'b0), .o_result(i_y_k_10));
always_ff @(posedge i_clk or negedge i_reset) begin
	if (~i_reset) 
       o_y_k_10 <= 32'b0;
   else
       o_y_k_10 <= i_y_k_10;
end

//      _           ____ /\       _  ___  
//     / |         |___ \/\|     / |/ _ \ 
//     | |  _____    __) |  _____| | | | |
//     | | |_____|  / __/  |_____| | |_| |
//     |_|         |_____|       |_|\___/ 
//                                        
logic [7:0] shift_o_x_k_10, shift_o_y_k_10;

fullAdder8b shift_x_k_10 (.a(o_x_k_10[30:23]), .b(8'hA), .cin(1'b1), .sum(shift_o_x_k_10));
fullAdder8b shift_y_k_10 (.a(o_y_k_10[30:23]), .b(8'hA), .cin(1'b1), .sum(shift_o_y_k_10));

fpu_add_sub fpu_xk11 (.i_a(o_x_k_10), .i_b({o_x_k_10[31], shift_o_x_k_10, o_x_k_10[22:0]}), .i_control(1'b1), .o_result(i_x_k_11));
always_ff @(posedge i_clk or negedge i_reset) begin
	if (~i_reset) 
       o_x_k_11 <= 32'b0;
   else
       o_x_k_11 <= i_x_k_11;
end

fpu_add_sub fpu_yk11 (.i_a(o_y_k_10), .i_b({o_y_k_10[31], shift_o_y_k_10, o_y_k_10[22:0]}), .i_control(1'b1), .o_result(i_y_k_11));
always_ff @(posedge i_clk or negedge i_reset) begin
	if (~i_reset) 
       o_y_k_11 <= 32'b0;
   else
       o_y_k_11 <= i_y_k_11;
end

//      _           ____ /\       _ _ 
//     / |         |___ \/\|     / / |
//     | |  _____    __) |  _____| | |
//     | | |_____|  / __/  |_____| | |
//     |_|         |_____|       |_|_|
//                                    
logic [7:0] shift_o_x_k_11, shift_o_y_k_11;

fullAdder8b shift_x_k_11 (.a(o_x_k_11[30:23]), .b(8'hB), .cin(1'b1), .sum(shift_o_x_k_11));
fullAdder8b shift_y_k_11 (.a(o_y_k_11[30:23]), .b(8'hB), .cin(1'b1), .sum(shift_o_y_k_11));

fpu_add_sub fpu_xk14 (.i_a(o_x_k_11), .i_b({o_x_k_11[31], shift_o_x_k_11, o_x_k_11[22:0]}), .i_control(1'b1), .o_result(i_x_k_14));
always_ff @(posedge i_clk or negedge i_reset) begin
	if (~i_reset) 
       o_x_k_14 <= 32'b0;
   else
       o_x_k_14 <= i_x_k_14;
end

fpu_add_sub fpu_yk14 (.i_a(o_y_k_11), .i_b({o_y_k_11[31], shift_o_y_k_11, o_y_k_11[22:0]}), .i_control(1'b1), .o_result(i_y_k_14));
always_ff @(posedge i_clk or negedge i_reset) begin
	if (~i_reset) 
       o_y_k_14 <= 32'b0;
   else
       o_y_k_14 <= i_y_k_14;
end

//      _           ____ /\       _ _  _   
//     / |         |___ \/\|     / | || |  
//     | |  _____    __) |  _____| | || |_ 
//     | | |_____|  / __/  |_____| |__   _|
//     |_|         |_____|       |_|  |_|  
//                                         
logic [7:0] shift_o_x_k_14, shift_o_y_k_14;

fullAdder8b shift_x_k_14 (.a(o_x_k_14[30:23]), .b(8'hE), .cin(1'b1), .sum(shift_o_x_k_14));
fullAdder8b shift_y_k_14 (.a(o_y_k_14[30:23]), .b(8'hE), .cin(1'b1), .sum(shift_o_y_k_14));

fpu_add_sub o_fpu_xk (.i_a(o_x_k_14), .i_b({o_x_k_14[31], shift_o_x_k_14, o_x_k_14[22:0]}), .i_control(1'b1), .o_result(o_x));
fpu_add_sub o_fpu_yk (.i_a(o_y_k_14), .i_b({o_y_k_14[31], shift_o_y_k_14, o_y_k_14[22:0]}), .i_control(1'b1), .o_result(o_y));

endmodule