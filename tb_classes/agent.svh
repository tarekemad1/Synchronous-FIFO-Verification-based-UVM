class agent extends uvm_agent;
    `uvm_component_utils(agent);
    sequencer sequencer_h; 
    monitor monitor_h ; 
    function new(string name , uvm_component parent );
        super.new(name , parent); 
    endfunction
    function void build_phase(uvm_phase phase );
        sequencer_h = sequencer::type_id::create("sequencer_h",this);
        monitor_h = monitor::type_id::create("monitor_h",this);

    endfunction
endclass