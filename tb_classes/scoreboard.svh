class scoreboard extends uvm_subscriber#(sequence_item);
    `uvm_component_utils(scoreboard);
    uvm_analysis_imp#(sequence_item) scb_imp;
    int expected_data ;
    sequence_item item_q[$:8];
    function new(string name , uvm_component parent);
        super.new(name , parent );
    endfunction
    function void build_phase(uvm_phase phase);
        scb_imp =new("scb_imp",this);
    endfunction
    task run_phase(uvm_phase phase);
    if (item_q.size()>= 2 ) begin
            expected_data = item_q.pop_front();
    end
    compare(expected_data, item.data_out);
    endtask

    function void write(sequence_item t );
        item_q.push_back(t.data_in);
    
    endfunction

    function void compare(int expected_data , bit[15:0] actual_data);
        if(item.r_en && actual_data == expected_data)
            `uvm_info(get_type_name(),"Successful operation",$sformat("Successful operation DATA_IN =%0h DATA_OUT = %0h",exptected_data,actual_data))
        else if (item.r_en) 
             `uvm_error(get_type_name(),$sformat("Failed operation Expected =%0h Actual =%0h",expected_data,actual_data));
    endfunction
endclass