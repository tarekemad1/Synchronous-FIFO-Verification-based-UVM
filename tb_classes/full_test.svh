class full_test extends uvm_test;
    `uvm_component_utils (full_test)

    env    env_h;
    SerialSeq serialseq_h;

    // constructor
    function new(string name = "full_test", uvm_component parent);
        super.new(name, parent);
        `uvm_info(get_type_name(), "Inside Constructor!", UVM_HIGH)
    endfunction :new

    // build_phase
    function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        `uvm_info(get_type_name(), "Inside Build Phase!", UVM_HIGH)

        env_h = env::type_id::create("env_h", this);
    endfunction :build_phase 

    // run_phase
task run_phase (uvm_phase phase);
    super.run_phase(phase);
    `uvm_info(get_type_name(), "Inside Run Phase!", UVM_HIGH);

    // Raise objection to keep the phase active
    phase.raise_objection(this);

    serialseq_h=SerialSeq::type_id::create("serialseq_h");

    serialseq_h.start(env_h.agnt.sqr);
    
    phase.drop_objection(this);
endtask :run_phase


endclass :full_test
            