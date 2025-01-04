class coverage_collector extends uvm_subscriber#(sequence_item);
    `uvm_component_utils(coverage_collector);

    uvm_analysis_imp #(sequence_item, coverage_collector) cov_imp;

    sequence_item item;
    sequence_item queue[$];


    covergroup cov1;
	option.per_instance = 1; 
        cov_wr_en_p : coverpoint item.wr_en {
            bins wr_en_1   = {1'b1}; 
            bins wr_en_0   = {1'b0};
            bins wr_en_1_0 = (1'b1 => 1'b0);
            bins wr_en_0_1 = (1'b0 => 1'b1);
        }
        cov_rd_en_p : coverpoint item.rd_en {
            bins rd_en_1 = {1'b1}; 
            bins rd_en_0 = {1'b0};
            bins rd_en_1_0 = (1'b1 => 1'b0);
            bins rd_en_0_1 = (1'b0 => 1'b1);
        }
        cov_full_p  : coverpoint item.full {
            bins full_1 = {1'b1}; 
            bins full_0 = {1'b0};
        } 
        cov_empty_p  : coverpoint item.empty {
            bins empty_1 = {1'b1}; 
            bins empty_0 = {1'b0};
        } 

        cross cov_wr_en_p, cov_rd_en_p {
            bins wr_rd_en_10 = binsof(cov_wr_en_p) intersect {1'b1} && binsof(cov_rd_en_p) intersect {1'b0};
            bins wr_rd_en_01 = binsof(cov_wr_en_p) intersect {1'b0} && binsof(cov_rd_en_p) intersect {1'b1};
            ignore_bins wr_rd_en_11 = binsof(cov_wr_en_p) intersect {1'b1} && binsof(cov_rd_en_p) intersect {1'b1};
        }
    endgroup

    // constructor
    function new(string name = "coverage_collector", uvm_component parent);
        super.new(name, parent);
        `uvm_info(get_type_name(), "Inside Constructor!", UVM_HIGH)

        cov1 = new();
    endfunction :new

    // build_phase
    function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        `uvm_info(get_type_name(), "Inside Build Phase!", UVM_HIGH)

        cov_imp = new("cov_imp", this);
    endfunction :build_phase

    function void write (sequence_item t);
        queue.push_front(t);
    endfunction :write

    //run phase
	task run_phase (uvm_phase phase);
        super.run_phase(phase);    
       `uvm_info(get_type_name(), "Inside Run Phase!", UVM_HIGH)
        forever begin
	      item = sequence_item::type_id::create("item",this);
          wait(queue.size!=0);
	     	item  = queue.pop_back();
	    cov1.sample();  
        end 
    endtask :run_phase
endclass :coverage_collector