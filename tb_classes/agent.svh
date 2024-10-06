class agent extends uvm_agent;
    `uvm_component_utils(agent);
    sequencer sequencer_h; 
    function new(string name , uvm_component parent );
        super.new(name , parent); 
    endfunction
    function void build_phase(uvm_phase phase );
        sequencer_h = sequencer::type_id::create("sequencer_h",this);

    endfunction
endclass