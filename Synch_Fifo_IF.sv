interface SF_IF(input clk) ;
    logic rst_n         ; 
    logic w_en          ; 
    logic r_en          ;
    bit[7:0] data_in    ; 
    bit[7:0] data_out   ;
    logic full          ; 
    logic empty         ;
    clocking cb @(posedge clk );
        input full      ;
        input empty     ; 
        input data_out  ;
        output w_en     ; 
        output r_en     ; 
        output data_in  ;
    endclocking
    modport Test (clocking cb ,output rst_n); 
endinterface