module control(
    iOP, iRdy,
    PC_en, PCT_en, IR_en, MDR_en, MAR_en, MOR_en,
    RF_Write,
    ALU_op,
    MAR_Select, ALUB_Select, PCA_Select,
    PC_Select, C_Select, AddrC_Select
);


// Module IO
input wire [16:0] iOP; // Operation Code Input (Includes OPX)
input wire iRdy; // External ready signal from system (active high)
// Register Enable Signals
output wire PC_en, PCT_en, IR_en, MDR_en, MAR_en, MOR_en;
output wire RF_Write; // Register File Write Signal
output wire [5:0] ALU_op; // ALU Operation
output wire    MAR_Select,  // Memory Address Select
        ALUB_Select, // ALU B input Select
        PCA_Select;  // Program Counter Adder Select
output wire [1:0]  PC_Select,    // Program Counter IN Select
            C_Select,     // Register File Write Select
            AddrC_Select; // Register File Write Register Select

parameter [1:0] CaS_RA   = 2'b10,  CaSIR_dest = 2'b01;
parameter [1:0] CS_PCT   = 2'b10,  CS_MDR     = 2'b01;
parameter [1:0] PCS_RA   = 2'b10,  PCS_Call   = 2'b01;
parameter       MARS_ALU = 1'b0,   MARS_PC    = 1'b1;

endmodule 
