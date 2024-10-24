interface SF_IF(input clk) ;
    logic rst_n         ; 
    logic w_en          ; 
    logic r_en          ;
    bit[7:0] data_in    ; 
    bit[7:0] data_out   ;
    logic full          ; 
    logic empty         ;
    clocking cb_monitor @(posedge clk );
        input full      ;
        input empty     ; 
        input data_out  ;
        input w_en     ; 
        input r_en     ; 
        input data_in  ;
    endclocking
    modport IF_MONITOR (clocking cb_monitor ,input rst_n); 
    clocking cb_driver @(posedge clk); 
        output data_in ;
        output w_en ; 
        output r_en ; 
        input full; 
        input empty ; 
        input data_out; 
    endclocking
    modport IF_DRIVER (clocking cb_driver ,output rst_n);
endinterface