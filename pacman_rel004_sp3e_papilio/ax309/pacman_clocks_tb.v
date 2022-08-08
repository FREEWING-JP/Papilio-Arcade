`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   22:04:37 08/06/2022
// Design Name:   PACMAN_CLOCKS
// Module Name:   D:/00_Projects/00_GH/00_FPGA/00_Papilio/Arcade/pacman_rel004_sp3e_papilio/ax309/pacman_clocks_tb.v
// Project Name:  pacman_p1_500k
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: PACMAN_CLOCKS
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module pacman_clocks_tb;

	// Inputs
	reg I_CLK_REF;
	reg I_CLK;
	reg I_RESET_L;

	// Outputs
//	wire O_CLK_REF;
	wire O_ENA_12;
	wire O_ENA_6;
//	wire O_CLK;
	wire O_RESET;

	// Instantiate the Unit Under Test (UUT)
	PACMAN_CLOCKS uut (
//		.I_CLK_REF(I_CLK_REF), 
		.I_CLK(I_CLK), 
		.I_RESET_L(I_RESET_L), 
//		.O_CLK_REF(O_CLK_REF), 
		.O_ENA_12(O_ENA_12), 
		.O_ENA_6(O_ENA_6), 
//		.O_CLK(O_CLK), 
		.O_RESET(O_RESET)
	);


//   parameter   P_CLOCK_FREQ = 100.0 / 32.0; // 32MHz
   parameter   P_CLOCK_FREQ = 100.0 / 18.432; // 18.432MHz

    always #(P_CLOCK_FREQ/2) begin
        I_CLK_REF <= ~I_CLK_REF;
        I_CLK <= ~I_CLK;
    end

	initial begin
		// Initialize Inputs
		I_CLK_REF = 0;
		I_CLK = 0;
		I_RESET_L = 0;

		// Wait 100 ns for global reset to finish
		#100;
		I_RESET_L = 1;
		#100;
		I_RESET_L = 1;
        
		// Add stimulus here

	end
      
endmodule

