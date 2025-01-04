module synch_fifo #(parameter DEPTH = 8, DATA_WIDTH = 8) (
  input clk, rst_n,
  input wr_en, rd_en,
  input [DATA_WIDTH-1:0] data_in,
  output reg [DATA_WIDTH-1:0] data_out,
  output full, empty
);

  // Internal signals
  reg [DATA_WIDTH-1:0] fifo_mem [DEPTH-1:0];  // FIFO memory
  reg [DEPTH-1:0] wr_ptr, rd_ptr;             // Write and read pointers
  reg [DEPTH:0] fifo_count;                   // FIFO count

  // Write operation
  always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
      wr_ptr <= 0;
      fifo_count <= 0;
    end else if (wr_en && !full) begin
      fifo_mem[wr_ptr] <= data_in;
      wr_ptr <= wr_ptr + 1;
      fifo_count <= fifo_count + 1;
    end
  end

  // Read operation
  always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
      rd_ptr <= 0;
      data_out <= {DATA_WIDTH{1'b0}};  // Initialize data_out to a known value on reset
    end else if (rd_en && !empty) begin
      data_out <= fifo_mem[rd_ptr];  // Update data_out with valid data
      rd_ptr <= rd_ptr + 1;
      fifo_count <= fifo_count - 1;
    end
  end

  // Full and empty flags
  assign full = (fifo_count == DEPTH);
  assign empty = (fifo_count == 0);

endmodule
