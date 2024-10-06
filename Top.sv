module top;
    import uvm_pkg ::* ;
    import SynchFifo_pkg::*;
    `include "uvm_macros.svh"; 
    
    initial begin 
        bit clk ; 
        forever #5 clk <= ~clk ;
    end 
    SF_IF vif(clk); 
    SF_DUT sf_u (clk , vif.rst_n,vif.w_en,vif.r_en,vif.data_in,vif.data_out,vif.full,vif.empty);

initial begin
    uvm_config_db#(virtual SynchFifoIf)::set(null,"*","vif",vif);
    run_test();
end 
endmodule