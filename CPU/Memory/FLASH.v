module FLASH(
    Address, CS, WE, OE, nRST
    Data
);

input wire [21:0] Address;
input wire CS, WE, OE, nRST;
output wire [7:0] Data;
    
endmodule