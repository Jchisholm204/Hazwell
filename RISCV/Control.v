module Control(
    iClk,
    nRst,
    iOpcode,
    iFunct3,
    iFunct7,
    oStep,
    iRdy_ALU, iRdy_MEM,
    oLoad, oStore,
    oBranch, oImm,
    oJump, oRegWrite, oPCWrite
);

// Inputs
input  wire iClk, nRst;
input  wire [6:0] iOpcode;
input  wire [2:0] iFunct3;
input  wire [6:0] iFunct7;
output wire [4:0] oStep;

// Ready Signals from ALU and Memory
input wire iRdy_ALU, iRdy_MEM;
// Triggers to use in the pipeline
output wire oLoad,  // Load from memory required
            oStore, // Store to memory required
            oBranch, // Conditional Branch evaluation required
            oImm,    // Immediate value required
            oJump,   // Unconditional Jump
            oRegWrite, // Write to register file required
            oPCWrite;  // Write to PC required

// Internal Control
reg [4:0] step;
wire sys_rdy;
// Optional Stages
wire T_ALU, T_MEM, T_BRANCH;
// Instruction Types
wire alui, alur, // ALU Immediate, ALU Register
     jalr, jal, // Jump and Link Register, Jump and Link
     lui, auipc, // Load Upper Immediate, Add Upper Immediate to PC
     branch, // Conditional Branch
     load, store; // Load and Store


// Internal Assignments
assign sys_rdy = (step[0] && iRdy_MEM) || (step[1]) || (step[2] && iRdy_ALU) || (step[3] && iRdy_MEM) || (step[4]);
assign T_ALU = alui || alur;
assign T_MEM = load || store;
assign T_BRANCH = branch;

// Instruction Types
assign alui   = (iOpcode == 7'b0010011);
assign alur   = (iOpcode == 7'b0110011);
assign jalr   = (iOpcode == 7'b1100111);
assign jal    = (iOpcode == 7'b1101111);
assign lui    = (iOpcode == 7'b0110111);
assign auipc  = (iOpcode == 7'b0010111);
assign branch = (iOpcode == 7'b1100011);
assign load   = (iOpcode == 7'b0000011);
assign store  = (iOpcode == 7'b0100011);

// External Assignments
assign oLoad = load;
assign oStore = store;
assign oBranch = branch;
assign oImm = alui || lui || auipc || jalr || jal || branch || load || store;
assign oJump = jalr || jal;
assign oRegWrite = alur || alui || lui || load;
assign oPCWrite = auipc || jal || jalr;
assign oStep = step;

always@(posedge iClk or negedge nRst)
begin
    if(!nRst)
    begin
        step <= 5'b00001;
    end
    else if(iRdy)
    begin
        step[0] = step[4];
        step[1] = step[0];
        step[2] = step[1];
        step[3] = step[2];
        step[4] = step[3];
    end
end


endmodule
