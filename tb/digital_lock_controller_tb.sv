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
        $dumpfile("sim/digital_lock_controller.vcd");
        $dumpvars(0, digital_lock_controller_tb);

        clk   = 1'b0;
        reset = 1'b1;
        enter = 1'b0;
        digit = 4'd0;

        // Reset
        #20;
        reset = 1'b0;

        // Test 1: Correct digit/password input
        $display("TEST 1: Correct input");
        enter_digit(4'd5);

        #10;

        if (unlock == 1'b1)
            $display("TEST 1 PASSED: Unlock activated");
        else
            $display("TEST 1 FAILED: Unlock not activated");

        // Reset
        @(negedge clk);
        reset = 1'b1;
        @(negedge clk);
        reset = 1'b0;

        // Test 2: Wrong input
        $display("TEST 2: Wrong input");
        enter_digit(4'd7);

        #10;

        if (alarm == 1'b1)
            $display("TEST 2 PASSED: Alarm activated");
        else
            $display("TEST 2 FAILED: Alarm not activated");

        #20;

        $display("Simulation completed.");
        $finish;
    end

endmodule
