class monitor  extends uvm_monitor;
    `uvm_component_utils (monitor)

    // Declare the virtual interface
    virtual IF vif;

    uvm_analysis_port #(sequence_item) mon_port;

    // constructor
    function new(string name = "monitor", uvm_component parent);
        super.new(name, parent);
        `uvm_info(get_type_name(), "Inside Constructor!", UVM_HIGH)
    endfunction :new

    // build_phase
    function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        `uvm_info(get_type_name(), "Inside Build Phase!", UVM_HIGH)

        mon_port = new("mon_port", this);

        if(!(uvm_config_db #(virtual IF)::get(this, "*", "vif", vif)))
            `uvm_fatal(get_type_name(),"Couldn't get handle to vif")
      
    endfunction :build_phase

    // run_phase
task run_phase(uvm_phase phase);
    super.run_phase(phase);

    forever begin
        @(negedge vif.clk);
        if (vif.wr_en || vif.rd_en) begin
            sequence_item  item;
            item = sequence_item::type_id::create("item");
            item.data_in  = vif.data_in;
            item.wr_en    = vif.wr_en;
            item.rd_en    = vif.rd_en;
            item.full     = vif.full;
            item.empty    = vif.empty;

            if (item.rd_en) begin
                // Delay to allow `data_out` to stabilize after `rd_en`
                
                //@(negedge vif.clk);
                item.data_out = vif.data_out;
                `uvm_info("Monitor_READ",
                          $sformatf("Captured Read: Data_out = %0h", item.data_out), 
                          UVM_LOW);
            end 
            else begin
                 item.data_out = 'hX; // Explicitly mark as don't care for writes
                `uvm_info("Monitor_WRITE",
                          $sformatf("Captured Write: Data_in = %0x", item.data_in), 
                          UVM_LOW);
            end
            // Write transaction to analysis port
            mon_port.write(item);
        end
    end
endtask :run_phase
endclass :monitor