class scoreboard extends uvm_scoreboard;
    `uvm_component_utils(scoreboard)

    // Analysis port to receive transactions
    uvm_analysis_imp #(sequence_item, scoreboard) scb_imp;
    parameter FIFO_DEPTH = 8;

    // FIFO queue storage with maximum capacity of 8
    sequence_item fifo_queue [$:FIFO_DEPTH-1]; // Bounded dynamic array to simulate FIFO behavior

    // Constructor
    function new(string name = "scoreboard", uvm_component parent = null);
        super.new(name, parent);
        `uvm_info(get_type_name(), "Inside Constructor!", UVM_HIGH)
    endfunction : new

    // Build phase
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info(get_type_name(), "Inside Build Phase!", UVM_HIGH)

        // Initialize analysis port
        scb_imp = new("scb_imp", this);
    endfunction : build_phase

    // Write function to handle transactions
    function void write(sequence_item f_item);
        // Debug log for incoming transaction
        `uvm_info("DEBUG", 
                  $sformatf("Transaction: wr_en=%0b, rd_en=%0b, data_in=%0h, data_out=%0h  empty_flag=%0b  full_flag=%0b   ", 
                            f_item.wr_en, f_item.rd_en, f_item.data_in, f_item.data_out,f_item.empty,f_item.full), UVM_LOW);

        // Handle write enable
        if (f_item.wr_en) begin
            if (fifo_queue.size() < FIFO_DEPTH) begin
                fifo_queue.push_back(f_item);
                `uvm_info("FIFO", 
                          $sformatf("Write operation succeeded. FIFO Depth: %0d, Written Data = %0h full_flag=%0b", 
                                    fifo_queue.size(), f_item.data_in,f_item.full), 
                          UVM_LOW);
            end else begin
                `uvm_error("FIFO_FULL", "Write attempted when FIFO is full.");
            end
        end

        // Handle read enable
        if (f_item.rd_en) begin
            if (fifo_queue.size() > 0) begin
                sequence_item out = fifo_queue.pop_front();

                // Log FIFO contents after popping
                `uvm_info("FIFO_STATE", $sformatf("FIFO Contents After Pop: %p", fifo_queue), UVM_LOW);

                `uvm_info("SCOREBOARD_DEBUG", 
                          $sformatf("Popped Data from FIFO: %0h (Expected for Match) empty_flag=%0d", out.data_in,out.empty), 
                          UVM_LOW);

                if (out.data_in == f_item.data_out) begin
                    `uvm_info("FIFO_MATCH", 
                              $sformatf("Data matched: Expected = %0h, Got = %0h", 
                                        out.data_in, f_item.data_out), 
                              UVM_LOW);
                end else begin
                    `uvm_error("FIFO_MISMATCH", 
                               $sformatf("Data mismatch: Expected = %0h, Got = %0h", 
                                         out.data_in, f_item.data_out));
                end

                `uvm_info("FIFO", 
                          $sformatf("READ operation succeeded. FIFO Depth: %0d, READ Data = %0h", 
                                    fifo_queue.size(), f_item.data_out), 
                          UVM_LOW);
            end else begin
                `uvm_error("FIFO_EMPTY", "Read attempted when FIFO is empty.");
            end
        end
    endfunction : write

    // Run phase for monitoring the FIFO
    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        `uvm_info(get_type_name(), "Inside Run Phase!", UVM_HIGH)

        // Monitor the FIFO continuously
        forever begin
            if (fifo_queue.size() != 0) begin
                `uvm_info("FIFO_STATE", 
                $sformatf("FIFO Depth: %0d, FIFO Contents: '%p'", fifo_queue.size(), fifo_queue), 
                UVM_LOW);

            end
            #10; // Add a small delay for better simulation readability
        end
    endtask : run_phase
endclass : scoreboard
