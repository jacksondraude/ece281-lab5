----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/18/2025 02:42:49 PM
-- Design Name: 
-- Module Name: controller_fsm - FSM
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity controller_fsm is
    Port ( i_clk : in std_logic;
           i_reset : in STD_LOGIC;
           i_adv : in STD_LOGIC;
           o_cycle : out STD_LOGIC_VECTOR (3 downto 0));
end controller_fsm;

architecture FSM of controller_fsm is
    type sm_cpu is (s_idle, s_loadA, s_loadB, s_calc);
    signal f_state : sm_cpu := s_idle;
begin
    state_reg : process(i_clk)
    begin
        if i_reset = '1' then
                f_state <= s_idle;
            elsif rising_edge(i_clk) then
                if i_adv = '1' then
                    case f_state is
                        when s_idle => f_state <= s_loadA;
                        when s_loadA => f_state <= s_loadB;
                        when s_loadB => f_state <= s_calc;
                        when s_calc => f_state <= s_idle;
                    
                end case;
             end if;
          end if;
       end process;
       
       o_cycle <= "0001" when f_state = s_idle else
                  "0010" when f_state = s_loadA else
                  "0100" when f_state = s_loadB else
                  "1000";
   
                



end FSM;
