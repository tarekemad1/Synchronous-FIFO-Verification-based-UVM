class scoreboard extends uvm_subscriber#(sequence_item);
    `uvm_component_utils(scoreboard);
    uvm_analysis_imp#(sequence_item,scoreboard) scb_imp;
    
    sequence_item item_q[$:8];
    function new(string name , uvm_component parent);
        super.new(name , parent );
    endfunction
    function void build_phase(uvm_phase phase);
        scb_imp =new("scb_imp",this);
    endfunction
    task run_phase(uvm_phase phase);
    forever
    begin 
       // @(item_q.size()>0 );
        sequence_item expected_item ;
        sequence_item actual_item ; 

        actual_item  = item_q[0] ;
        expected_item = golden_model(item_q);
        compare(expected_item, actual_item);
    end 
    endtask

    function void write(sequence_item t );
         item_q.push_back(t);
    endfunction
    function sequence_item golden_model(sequence_item q[$]);
        sequence_item expected_item ;
        expected_item  = sequence_item::type_id::create("expected_item") ;
        
        if (q[0].r_en && q.size()==0) 
        begin 
            expected_item.empty=1'b1;
            expected_item.full = 1'b0 ;
        end 
        else if(q.size()==8 && q[7].w_en)
        begin 
            expected_item.full = 1'b1 ;
            expected_item.empty= 1'b0 ; 
        end 
        else if(q[0].r_en)  begin
            expected_item.empty =1'b0  ; expected_item.full = 1'b0; 
            expected_item.empty =1'b0  ; expected_item.empty= 1'b0 ; 
            expected_item       = q.pop_front(); 
        end
        return expected_item ; 
    endfunction

    function void compare(sequence_item exptected_item , sequence_item actual_item);
        if(actual_item.r_en && actual_item == exptected_item)
            `uvm_info(get_type_name(),"Successful operation",$sformat("Successful operation DATA_IN =%0h DATA_OUT = %0h",exptected_data,actual_item))
        else if (actual_item.r_en) 
             `uvm_error(get_type_name(),$sformat("Failed operation Expected =%0h Actual =%0h",exptected_item,actual_item));
    endfunction
endclass