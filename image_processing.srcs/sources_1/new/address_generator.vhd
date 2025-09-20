
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Adress_Generator is
    Port ( 	CLK25,enable : in  	STD_LOGIC;								
            vsync        : in  	STD_LOGIC;
				adress 		: inout STD_LOGIC_VECTOR (18 downto 0));	
end Adress_Generator;

architecture Behavioral of Adress_Generator is
   signal val: STD_LOGIC_VECTOR(adress'range):= (others => '0');		
   constant Larg: integer :=640;													
   constant Haut: integer :=480;													
   constant Taille_Memoire : natural := Larg * Haut;						
begin
	process(CLK25)-- Ò»Ö¡»º´æ
		begin
         if rising_edge(CLK25) then
            if (enable='1') then													
					if (val < Taille_Memoire) then													
                  val <= val + 1 ;
					end if;
				end if;
            if vsync = '0' then 
               val <= (others => '0');
            end if;
			end if;	
		end process;
adress <= val;																		
end Behavioral;

