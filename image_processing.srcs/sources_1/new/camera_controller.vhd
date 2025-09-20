
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity camera_controller is
    Port ( clk   : in    STD_LOGIC;
		   resend :in    STD_LOGIC;
		   config_finished : out std_logic;
           sioc  : out   STD_LOGIC;
           siod  : inout STD_LOGIC;
           reset : out   STD_LOGIC;
           pwdn  : out   STD_LOGIC;
			  xclk  : out   STD_LOGIC
);
end camera_controller;

architecture Behavioral of camera_controller is
	COMPONENT camera_register
	PORT(
		clk      : IN std_logic;
		advance  : IN std_logic;          
		resend   : in STD_LOGIC;
		command  : OUT std_logic_vector(15 downto 0);
		finished : OUT std_logic
		);
	END COMPONENT;

	COMPONENT i2c_driver
	PORT(
		clk   : IN std_logic;
		send  : IN std_logic;
		taken : out std_logic;
		id    : IN std_logic_vector(7 downto 0);
		reg   : IN std_logic_vector(7 downto 0);
		value : IN std_logic_vector(7 downto 0);    
		siod  : INOUT std_logic;      
		sioc  : OUT std_logic
		);
	END COMPONENT;

	signal sys_clk  : std_logic := '0';	
	signal command  : std_logic_vector(15 downto 0);
	signal finished : std_logic := '0';
	signal taken    : std_logic := '0';
	signal send     : std_logic;

	constant camera_address : std_logic_vector(7 downto 0) := x"42"; --  Device write ID 
begin
   config_finished <= finished;
	
	send <= not finished;
	i2c_drive: i2c_driver PORT MAP(
		clk   => clk,
		taken => taken,
		siod  => siod,
		sioc  => sioc,
		send  => send,
		id    => camera_address,
		reg   => command(15 downto 8),
		value => command(7 downto 0)
	);

	reset <= '1'; 						-- Normal mode
	pwdn  <= '0'; 						-- Power device up
	xclk  <= sys_clk;
	
	ov7670_register: camera_register PORT MAP(
		clk      => clk,
		advance  => taken,
		command  => command,
		finished => finished,
		resend   => resend
	);

	process(clk)
	begin
		if rising_edge(clk) then
			sys_clk <= not sys_clk;
		end if;
	end process;
end Behavioral;

