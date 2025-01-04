class random_sequence extends uvm_sequence #(sequence_item);
    `uvm_object_utils(random_sequence)

    sequence_item  item;
    // constructor
    function new(string name = "random_sequence");
        super.new(name);
        `uvm_info(get_type_name(), "Inside Constructor!", UVM_HIGH)
    endfunction :new

    // body
    task body ();
        `uvm_info(get_type_name(), "Inside body task!", UVM_HIGH)
        item = sequence_item ::type_id::create("item");
        start_item(item);
        assert(item.randomize() with { {wr_en, rd_en} dist { 01 := 60, 10 := 60}; });
        finish_item(item);
    endtask :body
endclass :random_sequence
