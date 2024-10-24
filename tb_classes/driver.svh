class driver extends uvm_driver#(sequence_item);
    `uvm_component_utils(driver);
    virtual SF_IF.IF_DRIVER vif ; 
    sequence_item item ; 
    function new(string name , uvm_component parent );
        super.new(name , parent);
    endfunction

    function void build_phase(uvm_phase phase);
        if(!uvm_config_db#(virtual vif)::get(null,"*","vif",vif))
            `uvm_error(get_type_name(),"Failed to retrieve interface");
    endfunction

    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        forever begin 
        item = sequence_item::type_id::create("item");
        seq_item_port.get_next_item(item);
        tb_driver();
        seq_item_port.item_done();
        end 
    endtask
    task tb_driver();
        if(item.w_en) begin;
            vif.IF_DRIVER.rst_n   = item.rst_n; 
            vif.IF_DRIVER.data_in = item.data_in; 
            vif.IF_DRIVER.w_en    = item.w_en ; 
            vif.IF_DRIVER.r_en    = item.r_en ; 
        end 
        else if(item.r_en) begin 
            vif.IF_DRIVER.r_en    = item.r_en ; 
        end 
        
        
        
        
    endtask

endclass