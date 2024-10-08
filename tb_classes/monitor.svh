class monitor extends uvm_monitor;
    `uvm_component_utils(monitor);
    virtual SF_IF.IF_MONITOR vif ;
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
        @(vif.cb_monitor);
        tb_monitor();
    endtask

    task tb_monitor();
        forever begin 
            item = sequence_item::type_id::create("item");
            item.rst_n      = vif.IF_MONITOR.rst_n      ;
            item.w_en       = vif.IF_MONITOR.w_en       ; 
            item.r_en       = vif.IF_MONITOR.r_en       ; 
            item.data_in    = vif.IF_MONITOR.data_in    ; 
            item.data_out   = vif.IF_MONITOR.data_out   ;
            item.empty      = vif.IF_MONITOR.empty      ;    
            item.full       = vif.IF_MONITOR.full       ; 
            ap.write(item);
        end 
    endtask
endclass