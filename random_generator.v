//Adapted from: https://stackoverflow.com/questions/14497877/how-to-implement-a-pseudo-hardware-random-number-generator
module random_generator(
  input clk,
  input reset,

  output reg [3:0] data
);

reg [3:0] data_next;

always @* begin
  data_next[3] = data[3]^data[0];
  data_next[2] = data[2]^data_next[3];
  data_next[1] = data[1]^data_next[2];
  data_next[0] = data[0]^data_next[1];
end

always @(posedge clk)
  if(reset)
    data <= 4'hf;
  else
    data <= data_next;

endmodule
