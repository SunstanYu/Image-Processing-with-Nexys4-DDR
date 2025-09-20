
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;



entity VGA is
    Port ( CLK25 : in  STD_LOGIC;									-- Horloge d'entr閑 de 25 MHz							
			  clkout : out  STD_LOGIC;					-- Horloge de sortie vers le ADV7123 et l'閏ran TFT
           Hsync,Vsync : out  STD_LOGIC;						-- H  in VGA  
			  Nblank : out  STD_LOGIC;								-- signal de commande du convertisseur N/A ADV7123
           activeArea : out  STD_LOGIC;
			  Nsync : out  STD_LOGIC);	-- signaux de synchronisation et commande de l'閏ran TFT
end VGA;

architecture Behavioral of VGA is
signal Hcnt:STD_LOGIC_VECTOR(9 downto 0):="0000000000";		-- pour le comptage des colonnes   9 downto 0
signal Vcnt:STD_LOGIC_VECTOR(9 downto 0):="0000000000";		-- pour le comptage des lignes 520   1000001000
signal video:STD_LOGIC;

constant HM: integer :=800;	--la taille maximale consid閞? 800 (horizontal)
constant HD: integer :=640;	--la taille de l'閏ran (horizontal)
constant HF: integer :=16;		--front porch
constant HB: integer :=48;		--back porch
constant HR: integer :=96;		--sync time
constant VM: integer :=525;	--la taille maximale consid閞? 525 (vertical)	
constant VD: integer :=480;	--la taille de l'閏ran (vertical)
constant VF: integer :=10;		--front porch
constant VB: integer :=33;		--back porch
constant VR: integer :=2;		--retrace
--constant HM: integer :=1040;	--la taille maximale consid閞? 800 (horizontal)
--constant HD: integer :=800;	--la taille de l'閏ran (horizontal)
--constant HF: integer :=56;		--front porch
--constant HB: integer :=64;		--back porch
--constant HR: integer :=120;		--sync time
--constant VM: integer :=666;	--la taille maximale consid閞? 525 (vertical)	
--constant VD: integer :=600;	--la taille de l'閏ran (vertical)
--constant VF: integer :=37;		--front porch
--constant VB: integer :=23;		--back porch
--constant VR: integer :=6;		--retrace


begin

-- initialisation d'un compteur de 0 ? 799 (800 pixel par ligne):
-- ? chaque front d'horloge en incr閙ente le compteur de colonnes
-- c-a-d du 0 ? 799.
	process(CLK25)
		begin
			if (CLK25'event and CLK25='1') then
				 if (Hcnt = HM) then
					       Hcnt <= "0000000000";
                           if (Vcnt= VM) then
                                Vcnt <= "0000000000";
                                activeArea <= '1';-- adress begin add  and  input begin
                            else
                                   if vCnt < 480-1 then--120
                                      activeArea <= '1';
                                   end if;
                                   Vcnt <= Vcnt+1;
                           end if;
			     else
                           if hcnt = 640-1 then--160                            
                              activeArea <= '0'; 
                           end if;
					       Hcnt <= Hcnt + 1;
				 end if;
			end if;
		end process;
----------------------------------------------------------------

 -- Horizontal sync  水平同步  回扫行数
	process(CLK25)
		begin
			if (CLK25'event and CLK25='1') then
				if (Hcnt >= (HD+HF) and Hcnt <= (HD+HF+HR-1)) then   --- Hcnt >= 656 and Hcnt <= 751
					Hsync <= '0';
				else
					Hsync <= '1';
				end if;
			end if;
		end process;
----------------------------------------------------------------

  -- Vertical sync  垂直同步   刷新频率
	process(CLK25)
		begin
			if (CLK25'event and CLK25='1') then
				if (Vcnt >= (VD+VF) and Vcnt <= (VD+VF+VR-1)) then  ---Vcnt >= 490 and vcnt<= 491
					Vsync <= '0';
				else
					Vsync <= '1';
				end if;
			end if;
		end process;
----------------------------------------------------------------

-- Nblank et Nsync pour commander le covertisseur ADV7123:
Nsync <= '1';
video <= '1' when (Hcnt < 640) and (Vcnt < 480)			-- c'est pour utiliser la r閟olution compl鑤e 640 x 480	
	      else '0';
Nblank <= video;
clkout <= CLK25;

		
end Behavioral;

