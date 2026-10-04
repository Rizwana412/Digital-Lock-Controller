`timescale 1ns/1ps

module digital_lock_controller_tb;

    logic       clk;
    logic       reset;
    logic       enter;
    logic [3:0] digit;

    logic       unlock;
    logic       alarm;

    // Instantiate the Digital Lock Controller
    digital_lock_controller dut (
        .clk    (clk),
        .reset  (reset),
        .enter  (enter),
        .digit  (digit),
        .unlock (unlock),
        .alarm  (alarm)
    );

    // Clock generation: 10 ns period
    always #5 clk = ~clk;

    // Task to enter one digit
    task enter_digit(input logic [3:0] d);
        begin
            @(negedge clk);
            digit = d;
            enter = 1'b1;

            @(negedge clk);
            enter = 1'b0;
        end
    endtask
initial begin
    $dumpfile("sim/digital_lock_controller_3.vcd");
    $dumpvars(0, digital_lock_controller_tb);

    clk   = 1'b0;
    reset = 1'b1;
    enter = 1'b0;
    digit = 4'd0;

    // Hold reset active
    #20;
    
    // Release reset
    reset = 1'b0;

    // Allow the controller to operate after reset
    #20;

    $display("RESET TEST COMPLETED");
    $finish;
end
endmodule
