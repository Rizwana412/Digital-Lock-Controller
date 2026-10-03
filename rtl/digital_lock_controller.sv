module digital_lock_controller (
    input  logic clk,
    input  logic reset,
    input  logic enter,
    input  logic [3:0] digit,
    output logic unlock,
    output logic alarm
);

    logic [3:0] count;

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            count  <= 4'd0;
            unlock <= 1'b0;
            alarm  <= 1'b0;
        end
        else if (enter) begin
            if (digit == 4'd5) begin
                unlock <= 1'b1;
                alarm  <= 1'b0;
            end
            else begin
                unlock <= 1'b0;
                alarm  <= 1'b1;
            end
        end
    end

endmodule
