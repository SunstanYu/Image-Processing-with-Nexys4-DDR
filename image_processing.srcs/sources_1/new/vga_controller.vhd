
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;



entity rgb_controller is
    Port ( CLK25 : in  STD_LOGIC;															
		   clkout : out  STD_LOGIC;					
           Hsync,Vsync : out  STD_LOGIC;						
		   Nblank : out  STD_LOGIC;	
		   mode: in std_logic;
		   x: out STD_LOGIC_VECTOR(9 downto 0);
		   y: out STD_LOGIC_VECTOR(9 downto 0);
		   addr: out STD_LOGIC_VECTOR(15 DOWNTO 0);							
           activeArea : out  STD_LOGIC;
           img_area: out std_logic;
		   Nsync : out  STD_LOGIC
		   );	
end rgb_controller;

architecture Behavioral of rgb_controller is
signal Hcnt:STD_LOGIC_VECTOR(9 downto 0):="0000000000";		-- pour le comptage des colonnes   9 downto 0
signal Vcnt:STD_LOGIC_VECTOR(9 downto 0):="0000000000";		-- pour le comptage des lignes 520   1000001000
signal video:STD_LOGIC;

constant HM: integer :=800;	
constant HD: integer :=640;
constant HF: integer :=16;		--front porch
constant HB: integer :=48;		--back porch
constant HR: integer :=96;		--sync time
constant VM: integer :=525;	
constant VD: integer :=480;
constant VF: integer :=10;		--front porch
constant VB: integer :=33;		--back porch
constant VR: integer :=2;		
constant X_left1: std_logic_vector(9 downto 0):= "0000111100";--60
constant X_right1: std_logic_vector(9 downto 0) := "0100000100";--260
constant Y_up1:std_logic_vector(9 downto 0):= "0010001100";--140;
constant Y_end1:std_logic_vector(9 downto 0):="0101010100";--340

constant X_left2: std_logic_vector(9 downto 0):= "0101111100";--380
constant X_right2: std_logic_vector(9 downto 0) := "1001000100";--580
constant Y_up2:std_logic_vector(9 downto 0):= "0010001100";--140;
constant Y_end2:std_logic_vector(9 downto 0):="0101010100";--340

signal cnt_flag1, cnt_flag2: STD_LOGIC;
signal area1, area2: STD_LOGIC;
signal addra_reg1,addra_next1,addra_reg2,addra_next2 : STD_LOGIC_VECTOR(15 DOWNTO 0):=(others=>'0');


begin

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
                                      y<=vCnt;
                                   end if;
                                   Vcnt <= Vcnt+1;
                           end if;
			     else
                           if hcnt = 640-1 then--160                            
                              activeArea <= '0'; 
                           elsif hcnt < 640-1 then 
                              x<=hcnt;
                           end if;
					       Hcnt <= Hcnt + 1;
				 end if;
				  addra_reg1<=addra_next1;
				  addra_reg2<=addra_next2;
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
--Nsync <= '1';
video <= '1' when (Hcnt < 640) and (Vcnt < 480)			-- c'est pour utiliser la r閟olution compl鑤e 640 x 480	
	      else '0';
--Nblank <= video;
--clkout <= CLK25;
area1<='1' when hcnt>=X_left1 and hcnt<X_right1 and Vcnt>=y_up1 and Vcnt<y_end1 else
        '0';  
cnt_flag1<='1' when addra_reg1>="1001110000111111" else
            '0';    

addra_next1<=addra_reg1+1 when area1='1' else
              (OTHERS => '0') when cnt_flag1='1' else
              addra_reg1;
area2<='1' when hcnt>=X_left2 and hcnt<X_right2 and Vcnt>=y_up2 and Vcnt<y_end2 else
        '0';  
cnt_flag2<='1' when addra_reg2>="1001110000111111" else
            '0';    

addra_next2<=addra_reg2+1 when area2='1' else
              (OTHERS => '0') when cnt_flag2='1' else
              addra_reg2;     
--img_area<= area2;                      
addr<=addra_reg1 when area1='1' else
      addra_reg2 when area2='1' else
      addra_reg1;		
end Behavioral;

