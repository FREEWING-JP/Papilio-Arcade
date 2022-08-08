`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:42:21 08/06/2022 
// Design Name: 
// Module Name:    ax309 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module ax309(
  input  wire       CLK_50MHZ,         // 50MHz system clock signal
  input  wire       BTN_nRESET,        // reset push button

  output wire       VGA_HSYNC,         // vga hsync signal
  output wire       VGA_VSYNC,         // vga vsync signal
  output wire [3:0] VGA_RED,           // vga red signal
  output wire [3:0] VGA_GREEN,         // vga green signal
  output wire [3:0] VGA_BLUE,          // vga blue signal

  output wire       AUDIO,             // pwm output audio channel
  output wire [3:0] led,               // led
  input  wire [3:0] key_in,            // key_in

  inout         usb_dp,
  inout         usb_dm
    );



wire I_RESET = ~BTN_nRESET;

wire CLK_24MHzU;
wire CLK_32MHz;
wire CLK_24MHz;
wire RESET = 1'b0;

  dcm dcm
   (// Clock in ports
    .CLK_IN1(CLK_50MHZ),      // IN 50MHz
    // Clock out ports
    .CLK_OUT1(CLK_24MHzU),     // OUT 24.000MHz
//    .CLK_OUT2(CLK_32MHz),     // OUT 32.000MHz
//    .CLK_OUT3(CLK_24MHz),     // OUT 24.576MHz
    .CLK_OUT2(CLK_24MHz),     // OUT 24.576MHz
    // Status and control signals
    .RESET(RESET),// IN
    .LOCKED());      // OUT

// JOYPAD
wire [ 7:0] joypad_cfg;
wire        joypad_cfg_upd;

// Instantiate the module
wire [7:0] usb_gamepad_data;
wire usb_gamepad_ena;
wire usb_out_gate;
wire usb_dp_o;
wire usb_dm_o;
usb_gamepad_module usb_gamepad_module (
    .clk24(CLK_24MHzU), 
    .rst(!BTN_nRESET), 
    .uart_rx(1'b0), 
    .uart_tx(), 
    .usb_gamepad_data(usb_gamepad_data), 
	.usb_gamepad_ena(usb_gamepad_ena),
    .usb_out_gate(usb_out_gate), 
    .usb_dp_in(usb_dp), 
    .usb_dm_in(usb_dm), 
    .usb_dp_out(usb_dp_o), 
    .usb_dm_out(usb_dm_o)
    );

assign usb_dp = usb_out_gate ? usb_dp_o : 1'bz;
assign usb_dm = usb_out_gate ? usb_dm_o : 1'bz;

assign led = usb_gamepad_data[3:0]; // START, SELECT, B, A

// Instantiate the module
   wire [4:0] I_JOYSTICK_A;
   wire [4:0] I_JOYSTICK_B = 5'b00000;
   wire [3:0] I_SW;
   wire [3:0] O_VIDEO_R;          // vga red signal
   wire [3:0] O_VIDEO_G;          // vga green signal
   wire [3:0] O_VIDEO_B;          // vga blue signal

PACMAN u1 (
    .O_VIDEO_R(O_VIDEO_R), 
    .O_VIDEO_G(O_VIDEO_G), 
    .O_VIDEO_B(O_VIDEO_B), 
    .O_HSYNC(O_HSYNC), 
    .O_VSYNC(O_VSYNC), 
    .O_AUDIO_L(O_AUDIO_L), 
    .O_AUDIO_R(O_AUDIO_R), 
    .I_JOYSTICK_A(I_JOYSTICK_A), 
    .I_JOYSTICK_B(5'b0000), 
    .JOYSTICK_A_GND(), 
    .JOYSTICK_B_GND(), 
    .I_SW(I_SW), 
    .O_LED(), 
    .I_RESET(I_RESET), 
//    .OSC_IN(CLK_32MHz),
    .CLK_24MHz(CLK_24MHz)
    );

wire U1 = ~usb_gamepad_data[4];
wire D1 = ~usb_gamepad_data[5];
wire L1 = ~usb_gamepad_data[6];
wire R1 = ~usb_gamepad_data[7];
wire J1 = ~usb_gamepad_data[0];

wire S1 = usb_gamepad_data[3];
wire S2 = 1'b0;

wire C1 = usb_gamepad_data[2];
wire C2 = 1'b0;
assign I_JOYSTICK_A = { J1, R1, L1, D1, U1 };
assign I_SW = { C2, S2, C1, S1 };

assign VGA_HSYNC = O_HSYNC;
assign VGA_VSYNC = O_VSYNC;
assign VGA_RED   = O_VIDEO_R;
assign VGA_GREEN = O_VIDEO_G;
assign VGA_BLUE  = O_VIDEO_B;

assign AUDIO = ~O_AUDIO_L;

endmodule
