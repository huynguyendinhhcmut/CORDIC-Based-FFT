module rom_stage_9 (
    input logic           i_clk,
    input logic [9:0]     i_addr,   
    output logic [31:0]   o_data   
);

logic [31:0] rom [0:1023];

initial begin
	$readmemh("rom_stage_9.txt", rom);
end

always @(posedge i_clk) begin
	o_data <= rom[i_addr];
end

endmodule