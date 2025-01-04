module top;
    import uvm_pkg::*;
    import synch_pkg::*;
    parameter HALF_CYCLE =5 ; 
    parameter rst_n_TIME  =20 ; 
    logic rst_n , clk ; 

    IF vif (clk , rst_n );
    synch_fifo      dut(clk,rst_n, vif.wr_en  ,  vif.rd_en  , vif.data_in, vif.data_out , vif.full , vif.empty);


    initial begin
        clk = 0 ;
        forever begin
            #HALF_CYCLE; clk = ~clk;
        end
    end

    initial begin
        rst_n = 0;
        #rst_n_TIME ;
        #20 rst_n = 1; // Keep reset asserted for 2 clock cycles
    end

    initial begin
        uvm_config_db #(virtual IF)::set(null, "*", "vif", vif);
        run_test();
    end

endmodule