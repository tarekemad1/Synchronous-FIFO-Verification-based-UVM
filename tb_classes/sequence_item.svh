parameter DATA_WIDTH = 8; 
class sequence_item extends uvm_sequence_item;
    `uvm_object_utils(sequence_item);
    function new(string name = "");
        super.new(name);
    endfunction
  rand bit  rst_n ;
  rand bit  w_en, r_en ;
  rand bit  [DATA_WIDTH-1:0] data_in;
  bit  [DATA_WIDTH-1:0] data_out;
  bit  full, empty;
  constraint RESET_N{
    rst_n dist{1:/90 , 0:/10};
  }
  constraint WRITE_READ_ENABLING{
    w_en dist{0:=50 , 1:=50};
    r_en dist{0:=50 , 1:=50};
    w_en != r_en;
  }
  function string  convert2string();
    string s ; 
    s = {super.convert2string(), $sformat("rst_n = %0b ,w_en = %0b  ,r_en = %0b ,data_in = %0h ,data_out = %0h ,full = %0b ,empty =%0b ")
                                            ,rst_n , w_en,r_en,data_in,data_out,full,empty};
            return s ; 
  endfunction

endclass
