module temperature_display (
    input clk,
    input reset,
    input [9:0] temp_data,  
    output reg [6:0] seg_out,  
    output reg [3:0] digit_select // Select which digit to display 
);
    reg [3:0] digit;
    always @(*) begin
        case (digit)
            4'd0: seg_out = 7'b0111111; // Display '0'
            4'd1: seg_out = 7'b0000110; // Display '1'
            4'd2: seg_out = 7'b1011011; // Display '2'
            4'd3: seg_out = 7'b1001111; // Display '3'
            4'd4: seg_out = 7'b1100110; // Display '4'
            4'd5: seg_out = 7'b1101101; // Display '5'
            4'd6: seg_out = 7'b1111101; // Display '6'
            4'd7: seg_out = 7'b0000111; // Display '7'
            4'd8: seg_out = 7'b1111111; // Display '8'
            4'd9: seg_out = 7'b1101111; // Display '9'
            default: seg_out = 7'b0000000; // Blank display
        endcase
    end
    reg [1:0] digit_pos; 
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            digit_pos <= 2'b00;
            digit_select <= 4'b1110; 
        end else begin
            case (digit_pos)
                2'b00: begin
                    digit <= temp_data % 10; // Units place
                    digit_select <= 4'b1110; // Rightmost digit
                end
                2'b01: begin
                    digit <= (temp_data / 10) % 10; // Tens place
                    digit_select <= 4'b1101;
                end
                2'b10: begin
                    digit <= (temp_data / 100) % 10; // Hundreds place
                    digit_select <= 4'b1011;
                end
                2'b11: begin
                    digit <= (temp_data / 1000) % 10; // Thousands place
                    digit_select <= 4'b0111; // Leftmost digit
                end
            endcase
            digit_pos <= digit_pos + 1; // Move to the next digit on the next clock cycle
        end
    end
endmodule
