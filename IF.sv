interface IF (input logic clk, rst);
    logic [7:0] data_in;
    logic wr_en; 
    logic rd_en;

    logic [7:0] data_out;
    logic full;
    logic empty;
endinterface :IF