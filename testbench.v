`timescale 1ns / 1ps
module tb_temperature_display;
    reg clk;
    reg reset;
    reg [9:0] temp_data; 
    wire [6:0] seg_out;
    wire [3:0] digit_select;
    temperature_display uut (
        .clk(clk),
        .reset(reset),
        .temp_data(temp_data),
        .seg_out(seg_out),
        .digit_select(digit_select)
    );
    always #5 clk = ~clk; 
    initial begin
        $dumpfile("dumpfile.vcd");
	    $dumpvars(1);
        clk = 0;
        reset = 1;
        temp_data = 10'd0;
        #10;
        reset = 0;
      	repeat (20) begin
            #20 temp_data = $random % 1024; 
            #10 $display("Temperature: %d, Seg_out: %b, Digit_select: %b", temp_data, seg_out, digit_select);
        end
        #500 $finish;
    end
endmodule
