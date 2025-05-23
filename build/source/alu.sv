/*
    This file was generated automatically by Alchitry Labs 2.0.30-BETA.
    Do not edit this file directly. Instead edit the original Lucid source.
    This is a temporary file and any changes made to it will be destroyed.
*/

module alu (
        input wire [31:0] a,
        input wire [31:0] b,
        input wire [5:0] alufn,
        output reg [31:0] out,
        output reg z,
        output reg v,
        output reg n
    );
    logic [31:0] out_sig;
    localparam _MP_SIZE_260243388 = 6'h20;
    logic [31:0] M_adder_a;
    logic [31:0] M_adder_b;
    logic [5:0] M_adder_alufn_signal;
    logic [31:0] M_adder_out;
    logic M_adder_z;
    logic M_adder_v;
    logic M_adder_n;
    
    adder #(
        .SIZE(_MP_SIZE_260243388)
    ) adder (
        .a(M_adder_a),
        .b(M_adder_b),
        .alufn_signal(M_adder_alufn_signal),
        .out(M_adder_out),
        .z(M_adder_z),
        .v(M_adder_v),
        .n(M_adder_n)
    );
    
    
    logic [31:0] M_multiplier_a;
    logic [31:0] M_multiplier_b;
    logic [31:0] M_multiplier_mul;
    
    multiplier multiplier (
        .a(M_multiplier_a),
        .b(M_multiplier_b),
        .mul(M_multiplier_mul)
    );
    
    
    logic [31:0] M_bullet_moving_encode_a;
    logic [31:0] M_bullet_moving_encode_b;
    logic [31:0] M_bullet_moving_encode_out;
    
    bullet_moving_encode bullet_moving_encode (
        .a(M_bullet_moving_encode_a),
        .b(M_bullet_moving_encode_b),
        .out(M_bullet_moving_encode_out)
    );
    
    
    logic [31:0] M_bullet_encode_a;
    logic [31:0] M_bullet_encode_b;
    logic [31:0] M_bullet_encode_out;
    
    bullet_encode bullet_encode (
        .a(M_bullet_encode_a),
        .b(M_bullet_encode_b),
        .out(M_bullet_encode_out)
    );
    
    
    logic [31:0] M_enemy_color_encode_a;
    logic [31:0] M_enemy_color_encode_b;
    logic [31:0] M_enemy_color_encode_out;
    
    enemy_color_encode enemy_color_encode (
        .a(M_enemy_color_encode_a),
        .b(M_enemy_color_encode_b),
        .out(M_enemy_color_encode_out)
    );
    
    
    always @* begin
        M_adder_a = a;
        M_adder_b = b;
        M_adder_alufn_signal = alufn;
        z = M_adder_z;
        v = M_adder_v;
        n = M_adder_n;
        M_multiplier_a = a;
        M_multiplier_b = b;
        M_bullet_moving_encode_a = a;
        M_bullet_moving_encode_b = b;
        M_bullet_encode_a = a;
        M_bullet_encode_b = b;
        M_enemy_color_encode_a = a;
        M_enemy_color_encode_b = b;
        
        case (alufn)
            6'h0: begin
                out_sig = M_adder_out;
            end
            6'h1: begin
                out_sig = M_adder_out;
            end
            6'h2: begin
                out_sig = M_multiplier_mul;
            end
            6'h33: begin
                out_sig = a == b;
            end
            6'h35: begin
                out_sig = a < b;
            end
            6'h37: begin
                out_sig = a <= b;
            end
            6'h3d: begin
                out_sig = M_enemy_color_encode_out;
            end
            6'h3e: begin
                out_sig = M_bullet_encode_out;
            end
            6'h3f: begin
                out_sig = M_bullet_moving_encode_out;
            end
            default: begin
                out_sig = 1'h0;
            end
        endcase
        out = out_sig;
    end
    
    
endmodule