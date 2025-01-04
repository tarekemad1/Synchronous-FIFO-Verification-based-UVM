class sequence_item extends uvm_sequence_item;
    `uvm_object_utils(sequence_item);
    rand bit [7:0] data_in;
    rand bit wr_en;
    rand bit rd_en;

    logic  [7:0] data_out;
    bit full;
    bit empty;


    constraint wr_en_c { wr_en dist {1 := 80, 0 := 20}; }
    constraint rd_en_c { rd_en dist {1 := 70, 0 := 30}; }
    constraint READ_WRITE{wr_en!=rd_en;}
    constraint DATA_IN{rd_en==1 -> data_in =='h0 ; }

    function new (string name = "sequence_item");
        super.new(name);
        `uvm_info(get_type_name(), "Inside Constructor!", UVM_HIGH)
    endfunction :new
endclass :sequence_item