class cvrge extends uvm_subscriber#(sequence_item);
    `uvm_component_utils(cvrge);
    sequence_item item ;
    uvm_analysis_imp#(sequence_item,cvrge) cvrg_imp;
    covergroup SYNCH_FIFO_SIGNALS;
     RESET_N :coverpoint item.rst_n{bins RESET_ACTIVE ={0};bins RESET_DEACTIVE ={1};}
     WRITE_EN:coverpoint item.w_en{bins W_EN ={1};bins W_NOT_EN ={0};}
     READ_EN :coverpoint item.r_en{bins R_EN ={1}; bins R_NOT_E={0};}
     SYNCH_FULL:coverpoint item.full{bins FULL={1};bins NOT_FULL ={0};}
     SYNCH_EMPTY:coverpoint item.empty{bins EMPTY={1};bins NOT_EMPTY={0};}
     DATA_IN :coverpoint item.data_in{option.auto_bin_max = 6;}
    endgroup
    function new(string name , uvm_component parent);
        super.new(name, parent);
        SYNCH_FIFO_SIGNALS =new();
    endfunction
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        cvrg_imp = new("cvrg_imp",this);
    endfunction

    function void write (sequence_item t );
        item = sequence_item::type_id::create("item");
        $cast(item,t);
        SYNCH_FIFO_SIGNALS.sample();
    endfunction
endclass