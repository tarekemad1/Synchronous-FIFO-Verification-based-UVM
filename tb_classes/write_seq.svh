class write_seq extends uvm_sequence#(sequence_item);
    `uvm_object_utils(write_seq);
    sequence_item item ; 
    function new(string name="write_seq" );
        super.new(name);
    endfunction
    task run_phase (uvm_phase phase);
        item = sequence_item::type_id::create("item");
        start_item(item );
        WRITE_SEQ: assert (item.randomize() with{item.w_en==1;} )
            else $error("Assertion write_seq failed!");
        finish_item(item);
    endtask
endclass