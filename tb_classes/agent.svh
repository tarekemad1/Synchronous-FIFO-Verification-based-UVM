class agent extends uvm_agent;
    `uvm_component_utils (agent)

    sequencer  sqr;
    driver     drv;
    monitor    mon;

    // constructor
    function new (string name = "agent", uvm_component parent);
        super.new(name, parent);
        `uvm_info(get_type_name(), "Inside Constructor!", UVM_HIGH)
    endfunction :new

    // build_phase
    function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        `uvm_info(get_type_name(), "Inside Build Phase!", UVM_HIGH)

    
        sqr = sequencer ::type_id::create ("sqr", this);
        drv = driver    ::type_id::create ("drv", this);
        mon = monitor   ::type_id::create ("mon", this);

    endfunction :build_phase

    // connect_phase
    function void connect_phase (uvm_phase phase);
        super.connect_phase(phase);
        `uvm_info(get_type_name(), "Inside Connect Phase!", UVM_HIGH)
   
        drv.seq_item_port.connect(sqr.seq_item_export);
    endfunction :connect_phase
endclass :agent