----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2023/05/28 16:07:53
-- Design Name: 
-- Module Name: processing - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity processing is
Port (
    clock : in STD_LOGIC;
    method : in STD_LOGIC_VECTOR (2 downto 0);
    rgb_in : in STD_LOGIC_VECTOR (11 downto 0);
    red_out : out STD_LOGIC_VECTOR (3 downto 0);
    green_out : out STD_LOGIC_VECTOR (3 downto 0);
    blue_out : out STD_LOGIC_VECTOR (3 downto 0)
 );
end processing;

architecture Behavioral of processing is
signal r,g,b : integer range 0 to 127;

begin 
r <= conv_integer(rgb_in(11 downto 8));
g <= conv_integer(rgb_in(7 downto 4));
b <= conv_integer(rgb_in(3 downto 0));


apply_process_kernel: process(clock)
variable sum : integer;
begin
    if rising_edge(clock) then
        case method is
            when "000" => -- identity
                    red_out <= rgb_in(11 downto 8);
                    green_out <= rgb_in(7 downto 4);
                    blue_out <= rgb_in(3 downto 0);
            when "001" => -- black and white
                    sum := (r+g+b)/3;
                    red_out <= conv_std_logic_vector(sum,4);
                    green_out <= conv_std_logic_vector(sum,4);
                    blue_out <= conv_std_logic_vector(sum,4);
            when "011" => -- inverted colors
                    red_out <= (not rgb_in(11 downto 8));
                    green_out <= (not rgb_in(7 downto 4));
                    blue_out <= (not rgb_in(3 downto 0));
            when "111" => -- swap red and green colors
                    red_out <=  rgb_in(7 downto 4);
                    green_out <=  rgb_in(11 downto 8);
                    blue_out <= rgb_in(3 downto 0);
            when "110" => -- swap red and blue colors
                    red_out <= rgb_in(3 downto 0);
                    green_out <=  rgb_in(7 downto 4);
                    blue_out <=  rgb_in(11 downto 8);
            when "010" => -- swap green and blue colors
                    red_out <=  rgb_in(11 downto 8);
                    green_out <=  rgb_in(3 downto 0);
                    blue_out <=  rgb_in(7 downto 4);
             when others => 
                    red_out <= rgb_in(11 downto 8);
                    green_out <= rgb_in(7 downto 4);
                    blue_out <= rgb_in(3 downto 0);
        end case;
    end if;
end process apply_process_kernel;
end Behavioral;
