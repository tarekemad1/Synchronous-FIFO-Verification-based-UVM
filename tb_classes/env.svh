class env extends uvm_env;
    `uvm_component_utils(env);
    agent agent_h ; 
    cvrge coverage_h ; 
    scoreboard scoreboard_h; 
    function new(string name  , uvm_component parent);
        super.new(name,parent);
    endfunction
    function void build_phase(uvm_phase phase );
        super.build_phase(phase);
        agent_h = agent::type_id::create("agent_h",this);
        coverage_h = cvrge::type_id::create("coverage_h",this);
    endfunction
    function void connect_phase(uvm_phase phase);
        agent_h.monitor_h.ap.connect(scoreboard_h.scb_imp);
        agent_h.monitor_h.ap.connect(coverage_h.cvrg_imp);
    endfunction
endclass