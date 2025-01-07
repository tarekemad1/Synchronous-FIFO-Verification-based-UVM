class write_sequence extends uvm_sequence #(sequence_item);
    `uvm_object_utils(write_sequence)

    sequence_item  item;
    // constructor
    function new(string name = "write_sequence");
        super.new(name);
        `uvm_info(get_type_name(), "Inside Constructor!", UVM_HIGH)
    endfunction :new

    // body
    task body ();
        `uvm_info(get_type_name(), "Inside body task!", UVM_HIGH)
        repeat(10)begin 
        item = sequence_item ::type_id::create("item");
        start_item(item);
        assert(item.randomize() with {wr_en == 1; rd_en == 0;});
        finish_item(item);
        end
    endtask :body
endclass :write_sequence