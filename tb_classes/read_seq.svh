class read_seq extends uvm_sequence#(sequence_item);
    `uvm_object_utils(read_seq);
    sequence_item item ; 
    function new(string name="read_seq" );
        super.new(name);
    endfunction
    task run_phase (uvm_phase phase);
        item = sequence_item::type_id::create("item");
        start_item(item );
        READ_SEQ: assert (item.randomize() with{item.r_en==1;} )
            else $error("Assertion READ_SEQ failed!");
        finish_item(item);
    endtask
endclass