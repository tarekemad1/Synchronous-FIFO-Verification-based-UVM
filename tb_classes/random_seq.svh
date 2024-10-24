class random_seq extends base_sequence;
    `uvm_object_utils(random_seq);
    sequence_item item ; 
    function new(string name ="random_seq");
        super.new(name);
    endfunction
    
    task run_phase(uvm_phase phase);
    item  = sequence_item::type_id::create("item");
        start_item(item);
        RANDOM_OPERATION: assert (item.randomize())
            else $error("Assertion RANDOM_OPERATION failed!");
        finish_item(item);
    endtask
endclass
