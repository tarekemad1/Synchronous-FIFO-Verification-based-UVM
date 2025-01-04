class SerialSeq extends uvm_sequence #(sequence_item);
    `uvm_object_utils(SerialSeq);
    write_sequence write_seq_h;
    read_sequence read_seq_h; 
    //uvm_event sequence_done;
    function new(string name="SerialSeq");
        super.new(name);
    endfunction

    task body();
            write_seq_h=write_sequence::type_id::create("write_seq_h");
            read_seq_h=read_sequence::type_id::create("read_seq_h");
            write_seq_h.start(m_sequencer);
            read_seq_h.start(m_sequencer);
            //sequence_done.trigger();
    endtask

endclass