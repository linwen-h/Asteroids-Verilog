module game_clock_setter(
    input CLOCK_50, 
    input [3:0] speed_level // allow for speed levels up to 10
    input reset,

    output reg [23:0] game_clock
    ); 

    reg cur_level_setting;

    

    always @ (posedge clk)
        begin
            case (speed_level)
                4'd0:
                4'd1:
                4'd2:
                4'd3:
                4'd4:
                4'd5:
                4'd6:
                4'd7:
                4'd8:
                4'd9:
                4'd10:
                endcase 
            if (reset) //TODO: consider setting everything to asynchornous low or all high

                 
        end
            else
                game_clock <= game_clock == 24'd0 ? 

endmodule