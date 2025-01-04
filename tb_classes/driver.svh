class driver extends uvm_driver #(sequence_item);
    `uvm_component_utils (driver)

    // Declare the virtual interface
    virtual IF  vif;


    // constructor
    function new(string name = "driver", uvm_component parent);
        super.new(name, parent);
        `uvm_info(get_type_name(), "Inside Constructor!", UVM_HIGH)
    endfunction :new

    // build_phase
    function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        `uvm_info(get_type_name(), "Inside Build Phase!", UVM_HIGH)

        // Get the interface handle
        if (!(uvm_config_db #(virtual IF)::get(this, "*", "vif", vif)))
            `uvm_fatal(get_type_name(),"Couldn't get handle to vif")

    endfunction :build_phase

    // run_phase
    task run_phase (uvm_phase phase);
        super.run_phase(phase);
        `uvm_info(get_type_name(), "Inside Run Phase!", UVM_HIGH)
        forever begin
            sequence_item  item;
            item=sequence_item::type_id::create("item");
            seq_item_port.get_next_item(item);
            drive_item(item);
            seq_item_port.item_done();
        end
    endtask :run_phase

    task drive_item (sequence_item item);
        @(posedge vif.clk);
        //#10;

            vif.data_in <= item.data_in;
            vif.wr_en   <= item.wr_en;
            vif.rd_en   <= item.rd_en;
            
         `uvm_info("DRIVER", $sformatf("Driver Received: wr_en=%0d,rd_en=%0d ,  data_in=%0h", item.wr_en,vif.rd_en ,item.data_in), UVM_LOW);
                @(posedge vif.clk); // Wait for the next clock cycle
            vif.wr_en   <= 0;
            vif.rd_en   <= 0;
        if (item.wr_en) begin
            @(posedge vif.clk);
            vif.data_in <= 'hX;
            end
    endtask :drive_item
endclass :driver