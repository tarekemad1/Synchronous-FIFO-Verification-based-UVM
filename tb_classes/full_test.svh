class full_test extends base_test;
    `uvm_component_utils(full_test);
    function new(string name , uvm_component parent);
        super.new(name , parent);
    endfunction
    task run_phase (uvm_phase phase );
        reset_seq reset_seq_h ; 
        write_seq write_seq_h ; 
        read_seq read_seq_h ; 
        random_seq random_seq_h;
        reset_seq_h = reset_seq::type_id::create("reset_seq_h");
        read_seq_h  = read_seq::type_id::create("read_seq_h");
        random_seq_h  = random_seq::type_id::create("random_seq_h");
        phase.raise_objection(this);

        reset_seq_h.start(sequencer_h); 
        repeat(8)
        begin 
            write_seq_h = write_seq::type_id::create("write_seq_h");
            write_seq_h.start(sequencer_h);
        end 
        repeat(8)
        begin 
            read_seq_h  = read_seq::type_id::create("read_seq_h");
            read_seq_h.start(sequencer_h);
        end 
        repeat(20)
        begin 
            random_seq_h = random_seq::type_id::create("random_seq_h");
            random_seq_h.start(sequencer_h);
        end 
            
        phase.drop_objection(this);
    endtask
endclass