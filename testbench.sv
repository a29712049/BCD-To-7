`timescale 1ns/1ps
module BCD_tb;
    reg clk;
    reg rst_n;
    reg Load;
    reg [3:0] Din;
    wire [7:0]Q_out;

parameter PERIOD = 10;
parameter real DUTY_CYCLE = 0.5;
parameter OFFSET = 0;
BCD BCD_tb(clk, rst_n, Load, Din, Q_out);

initial
begin
    #OFFSET;
    forever
    begin
        Din = 4'b0101;
        clk = 1'b0;
        #(PERIOD-(PERIOD*DUTY_CYCLE)) clk = 1'b1;
        #(PERIOD*DUTY_CYCLE);
    end
end
initial begin
    Load = 1'b0;
    rst_n = 1'b0;
    #10 rst_n = 1'b1;
    #150 rst_n = 1'b0;
    #10 rst_n = 1'b1;
    #20 Load = 1'b1;
    #10 Load = 1'b0;
    #100 $finish;
end

initial begin
    $dumpfile("BCD.vcd");
    $dumpvars(0, BCD_tb);
end

endmodule