
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity camera_register is
    Port ( clk      : in  STD_LOGIC;
           resend   : in  STD_LOGIC;
           advance  : in  STD_LOGIC;
           command  : out  std_logic_vector(15 downto 0);
           finished : out  STD_LOGIC);
end camera_register;

architecture Behavioral of camera_register is
   signal output   : std_logic_vector(15 downto 0);
   signal address : std_logic_vector(7 downto 0) := (others => '0');
begin
   command <= output;
   with output select finished  <= '1' when x"FFFF", '0' when others;
   
   process(clk)
   begin
      if rising_edge(clk) then
         if resend = '1' then 
            address <= (others => '0');
         elsif advance = '1' then
            address <= std_logic_vector(unsigned(address)+1);
         end if;

         case address is
            when x"00" => output <= x"1280"; -- COM7   Reset      register 12   set as -> 80
            when x"01" => output <= x"1280"; -- COM7   Reset
            when x"02" => output <= x"1204"; -- COM7   Size & RGB output
            when x"03" => output <= x"1100"; -- CLKRC  Prescaler - Fin/(1+1)
            when x"04" => output <= x"0C00"; -- COM3   Lots of stuff, enable scaling, all others off
            when x"05" => output <= x"3E08"; -- COM14  PCLK scaling off  3e00
            
            when x"06" => output <= x"8C00"; -- RGB444 Set RGB format
            when x"07" => output <= x"0400"; -- COM1   no CCIR601
             when x"08" => output <= x"4010"; -- COM15  Full 0-255 output, RGB 565
            when x"09" => output <= x"3a05"; -- TSLB   Set UV ordering,  do not auto-reset window 3a04
            when x"0A" => output <= x"1438"; -- COM9  - AGC Celling
            when x"0B" => output <= x"4f40"; --x"4fb3"; -- MTX1  - colour conversion matrix
            when x"0C" => output <= x"5034"; --x"50b3"; -- MTX2  - colour conversion matrix
            when x"0D" => output <= x"510C"; --x"5100"; -- MTX3  - colour conversion matrix
            when x"0E" => output <= x"5217"; --x"523d"; -- MTX4  - colour conversion matrix
            when x"0F" => output <= x"5329"; --x"53a7"; -- MTX5  - colour conversion matrix
            when x"10" => output <= x"5440"; --x"54e4"; -- MTX6  - colour conversion matrix
            when x"11" => output <= x"581e"; --x"589e"; -- MTXS  - Matrix sign and auto contrast
            when x"12" => output <= x"3dc0"; -- COM13 - Turn on GAMMA and UV Auto adjust
            when x"13" => output <= x"1100"; -- CLKRC  Prescaler - Fin/(1+1)
            
            when x"14" => output <= x"1711"; -- HSTART HREF start (high 8 bits)
            when x"15" => output <= x"1861"; -- HSTOP  HREF stop (high 8 bits)
            when x"16" => output <= x"32A4"; -- HREF   Edge offset and low 3 bits of HSTART and HSTOP
            
            when x"17" => output <= x"1903"; -- VSTART VSYNC start (high 8 bits)
            when x"18" => output <= x"1A7b"; -- VSTOP  VSYNC stop (high 8 bits) 
            when x"19" => output <= x"030a"; -- VREF   VSYNC low two bits
            
            when x"1A" => output <= x"0e61"; -- COM5(0x0E) 0x61
            when x"1B" => output <= x"0f4b"; -- COM6(0x0F) 0x4B 
            
            when x"1C" => output <= x"1602"; --
            when x"1D" => output <= x"1e37"; -- MVFP (0x1E) 0x07  -- FLIP AND MIRROR IMAGE 0x3x

            when x"1E" => output <= x"2102";
            when x"1F" => output <= x"2291";
            
            when x"20" => output <= x"2907";
            when x"21" => output <= x"330b";
                                  
            when x"22" => output <= x"350b";
            when x"23" => output <= x"371d";
                                  
            when x"24" => output <= x"3871";
            when x"25" => output <= x"392a";
                                   
            when x"26" => output <= x"3c78"; -- COM12 (0x3C) 0x78
            when x"27" => output <= x"4d40"; 
                                  
            when x"28" => output <= x"4e20";
            when x"29" => output <= x"6900"; -- GFIX (0x69) 0x00
                                   
            when x"2A" => output <= x"6b4a";
            when x"2B" => output <= x"7410";
                                  
            when x"2C" => output <= x"8d4f";
            when x"2D" => output <= x"8e00";
                                   
            when x"2E" => output <= x"8f00";
            when x"2F" => output <= x"9000";
                                  
            when x"30" => output <= x"9100";
            when x"31" => output <= x"9600";
                                  
            when x"32" => output <= x"9a00";
            when x"33" => output <= x"b084";
                                  
            when x"34" => output <= x"b10c";
            when x"35" => output <= x"b20e";
                                  
            when x"36" => output <= x"b382";
            when x"37" => output <= x"b80a";
            
            when others => output <= x"ffff";
         end case;
      end if;
   end process;
end Behavioral;