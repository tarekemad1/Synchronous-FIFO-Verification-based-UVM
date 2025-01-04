class env  extends uvm_env;
    `uvm_component_utils (env)
    
    agent               agnt;
    scoreboard          scb;
    coverage_collector  cov;

    // constructor
    function new(string name = "env", uvm_component parent);
        super.new(name, parent);
        `uvm_info(get_type_name(), "Inside Constructor!", UVM_HIGH)
    endfunction :new

    // build_phase
    function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        `uvm_info(get_type_name(), "Inside Build Phase!", UVM_HIGH)

        agnt = agent::type_id::create("agnt", this);
        scb  = scoreboard::type_id::create("scb", this);
        cov  = coverage_collector::type_id::create("cov", this);
    endfunction :build_phase

    // connect_phase
    function void connect_phase (uvm_phase phase);
        super.connect_phase(phase);
        `uvm_info(get_type_name(), "Inside Connect Phase!", UVM_HIGH)

        agnt.mon.mon_port.connect(scb.scb_imp);
        agnt.mon.mon_port.connect(cov.cov_imp);
    endfunction :connect_phase

endclass :env