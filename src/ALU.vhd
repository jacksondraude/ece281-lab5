----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/18/2025 02:50:18 PM
-- Design Name: 
-- Module Name: ALU - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU is
    Port ( i_A : in STD_LOGIC_VECTOR (7 downto 0);
           i_B : in STD_LOGIC_VECTOR (7 downto 0);
           i_op : in STD_LOGIC_VECTOR (2 downto 0);
           o_result : out STD_LOGIC_VECTOR (7 downto 0);
           o_flags : out STD_LOGIC_VECTOR (3 downto 0));
end ALU;

architecture Behavioral of ALU is
    signal w_result : std_logic_vector(7 downto 0);
    signal w_carry : std_logic;
    signal w_overflow : std_logic;
    signal w_zero : std_logic;
    signal w_neg : std_logic;
    

begin
    alu_process : process (i_A, i_B, i_op)
        variable v_a : unsigned(8 downto 0);
        variable v_b : unsigned(8 downto 0);
        variable v_result : unsigned(8 downto 0);
        variable v_and : std_logic_vector(7 downto 0);
        variable v_or : std_logic_vector(7 downto 0);
    begin
        v_a := unsigned('0' & i_A);
        v_b := unsigned('0' & i_B);
        
        case i_op is 
            when "000" => 
            v_result := v_a + v_b;
            w_result <= std_logic_vector(v_result(7 downto 0));
            w_carry <= v_result(8);
            w_neg <= v_result(7);
            w_overflow <= (not i_A(7) and not i_B(7) and v_result(7)) or (i_A(7) and i_B(7) and not v_result(7));
            if v_result(7 downto 0) = "00000000" then
                w_zero <= '1';
            else
                w_zero <= '0';
            end if;
            
            when "001" => 
            v_result := v_a - v_b;
            w_result <= std_logic_vector(v_result(7 downto 0));
            w_carry <= v_result(8);
            w_neg <= v_result(7);
            w_overflow <= (not i_A(7) and  i_B(7) and v_result(7)) or (i_A(7) and not i_B(7) and not v_result(7));
            if v_result(7 downto 0) = "00000000" then
                w_zero <= '1';
            else
                w_zero <= '0';
            end if;
            
            when "010" => 
            v_and := i_A and i_B;
            w_result <= v_and;
            w_carry <= '0';
            w_overflow <= '0';
            w_neg <= v_and(7);
            if v_and = "00000000" then
                w_zero <= '1';
            else
                w_zero <= '0';
            end if;
            
            
            when "011" => 
            v_or := i_A or i_B;
            w_result <= v_or;
            w_carry <= '0';
            w_overflow <= '0';
            w_neg <= v_or(7);
            if v_or = "00000000" then
                w_zero <= '1';
            else
                w_zero <= '0';
            end if;
            
            
            when others => 
            w_result <= (others => '0');
            w_carry <= '0';
            w_overflow <= '0';
            w_neg <= v_result(7);
            if v_result(7 downto 0) = "00000000" then
                w_zero <= '1';
            else
                w_zero <= '0';
            end if;
            
            
        end case;
    end process;
    
    o_result <= w_result;
    o_flags <= w_neg & w_zero & w_carry & w_overflow;
                      
end Behavioral;
