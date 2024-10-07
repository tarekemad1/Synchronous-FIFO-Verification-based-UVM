class monitor extends uvm_monitor;
    `uvm_component_utils(monitor);
    virtual SF_IF vif ;
    uvm_analysis_port#(sequence_item) ap;
    sequence_item item; 
    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        ap = new("ap",this);
        if(!uvm_config_db#(virtual SF_IF)::get(null,"*","vif",vif))
            `uvm_error(get_type_name(),"Failed to get interface")
    endfunction
    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        forever begin 
            item = sequence_item::type_id::create("item");
            @(posedge vif.clk);
            item.rst_n      = vif.rst_n      ;
            item.w_en       = vif.w_en       ; 
            item.r_en       = vif.r_en       ; 
            item.data_in    = vif.data_in    ; 
            item.data_out   = vif.data_out   ;
            item.empty      = vif.empty      ;    
            item.full       = vif.full       ; 
        end 
    endtask
endclass