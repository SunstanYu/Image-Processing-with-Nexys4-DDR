
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top_design is
    Port ( clk100          : in  STD_LOGIC;  --100mhz
           btn             : in  STD_LOGIC;  
           config_finished : out STD_LOGIC;
           vga_hsync : out  STD_LOGIC;
           vga_vsync : out  STD_LOGIC;
           vga_r     : out  STD_LOGIC_vector(3 downto 0);
           vga_g     : out  STD_LOGIC_vector(3 downto 0);
           vga_b     : out  STD_LOGIC_vector(3 downto 0);
           mode : in STD_LOGIC;
           SPKOUT : OUT STD_LOGIC;
           method:in STD_LOGIC_VECTOR(2 downto 0);
--           start_process : in STD_LOGIC;
           is_processing: out STD_LOGIC;
           write_enable: out std_logic;
           pclk  : in  STD_LOGIC;
           xclk  : out STD_LOGIC;
           vsync_t : in  STD_LOGIC;
           href  : in  STD_LOGIC;
           data  : in  STD_LOGIC_vector(7 downto 0);
           sioc  : out STD_LOGIC;
           siod  : inout STD_LOGIC;
           pwdn  : out STD_LOGIC;
           reset : out STD_LOGIC
           );
end top_design;

architecture Behavioral of top_design is
	component   audio IS -- 次顶层设计
   PORT ( CLK12MHZ : IN STD_LOGIC;
   INDEX1 : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
   SPKOUT : OUT STD_LOGIC );
   END component;    
   
--    component processing_unit is
--    Port (
--      clock : in STD_LOGIC;
--      reset : in STD_LOGIC;
----      mode: in std_logic;
--      start_process : in STD_LOGIC;
--      selected_kernel : in STD_LOGIC_VECTOR(2 downto 0);
----      x: in STD_LOGIC_VECTOR(9 downto 0);
----	  y: in STD_LOGIC_VECTOR(9 downto 0);
--      rgb_in : in STD_LOGIC_VECTOR(11 downto 0);
----      adr_out : out STD_LOGIC_VECTOR(19 downto 0);
--      rgb_out : out STD_LOGIC_VECTOR(11 downto 0);
      
--      is_processing: out STD_LOGIC;
--      write_enable : out STD_LOGIC
--   );
--   end component;
   
   component processing is
   Port (
    clock : in STD_LOGIC;
    method : in STD_LOGIC_VECTOR (2 downto 0);
    rgb_in : in STD_LOGIC_VECTOR (11 downto 0);
    red_out : out STD_LOGIC_VECTOR (3 downto 0);
    green_out : out STD_LOGIC_VECTOR (3 downto 0);
    blue_out : out STD_LOGIC_VECTOR (3 downto 0)
    );
   end component;

	COMPONENT camera_controller
	PORT(
		clk : IN std_logic;
		resend : IN std_logic;    
		siod : INOUT std_logic;      
		config_finished : OUT std_logic;
		sioc : OUT std_logic;
		reset : OUT std_logic;
		pwdn : OUT std_logic;
		xclk : OUT std_logic
		);
	END COMPONENT;

	COMPONENT debounce
	PORT(
		clk : IN std_logic;
		i : IN std_logic;          
		o : OUT std_logic
		);
	END COMPONENT;

	COMPONENT blk_mem_gen_0
	PORT(
		 clka : IN STD_LOGIC;
       wea : IN STD_LOGIC;
       addra : IN STD_LOGIC_VECTOR(18 DOWNTO 0);
       dina : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
       clkb : IN STD_LOGIC;
       addrb : IN STD_LOGIC_VECTOR(18 DOWNTO 0);
       doutb : OUT STD_LOGIC_VECTOR(11 DOWNTO 0)
		);
	END COMPONENT;

	COMPONENT camera_capture
	PORT(
		pclk : IN std_logic;
		rez_160x120 : IN std_logic;
        rez_320x240 : IN std_logic;
		vsync : IN std_logic;
		href : IN std_logic;
		d : IN std_logic_vector(7 downto 0);          
		addr : OUT std_logic_vector(18 downto 0);
		dout : OUT std_logic_vector(11 downto 0);
		we : OUT std_logic
		);
	END COMPONENT;
    
    COMPONENT rgb_controller
	PORT(
		CLK25 : IN std_logic;    
		Hsync : OUT std_logic;
		Vsync : OUT std_logic;
		mode: in std_logic;
		Nblank : OUT std_logic;      
		clkout : OUT std_logic;
		img_area: out std_logic;
		activeArea : OUT std_logic;
		addr: out STD_LOGIC_VECTOR(15 DOWNTO 0);								 
        x: out STD_LOGIC_VECTOR(9 downto 0);
		y: out STD_LOGIC_VECTOR(9 downto 0);
		Nsync : OUT std_logic
		);
	END COMPONENT;
	
	COMPONENT rgb_generator
	PORT(
		Din : IN std_logic_vector(11 downto 0);
		Din_ori: in	STD_LOGIC_VECTOR (11 downto 0);	
		Nblank : IN std_logic;      
		realtime: in STD_LOGIC;
		mode : in STD_LOGIC_VECTOR (2 downto 0);
		x: in STD_LOGIC_VECTOR(9 downto 0);
		y: in STD_LOGIC_VECTOR(9 downto 0);	    
		R : OUT std_logic_vector(3 downto 0);
		G : OUT std_logic_vector(3 downto 0);
		B : OUT std_logic_vector(3 downto 0)
		);
	END COMPONENT;
    
    component blk_mem_gen_1 IS
  PORT (
    clka : IN STD_LOGIC;
    addra : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(11 DOWNTO 0)
  );
END component;

	COMPONENT Adress_Generator
	PORT(
		CLK25 : IN std_logic;
		enable : IN std_logic;       
        vsync  : in  	STD_LOGIC;
		adress : INOUT std_logic_vector(18 downto 0)
		);
	END COMPONENT;
    
--    COMPONENT memory
--	PORT(
--	clka : IN STD_LOGIC;
--    wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
--    addra : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
--    dina : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
--    clkb : IN STD_LOGIC;
--    enb : IN STD_LOGIC;
--    addrb : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
--    doutb : OUT STD_LOGIC_VECTOR(11 DOWNTO 0)
--		);
--	END COMPONENT;


   signal clk_camera : std_logic;
   signal clk_vga    : std_logic;
   signal wren       : STD_LOGIC;
   signal resend     : std_logic;
   signal nBlank     : std_logic;
   signal vSync      : std_logic;
   signal nSync      : std_logic;
   signal image_addr:  STD_LOGIC_VECTOR(15 DOWNTO 0);							
   signal wraddress  : std_logic_vector(18 downto 0);
   signal wrdata     : std_logic_vector(11 downto 0);
   signal row, column :std_logic_vector(9 downto 0);
   signal rdaddress  : std_logic_vector(18 downto 0);
   signal rddata     : std_logic_vector(11 downto 0);
   signal out_rgb     : std_logic_vector(11 downto 0);
   signal image_data   :std_logic_vector(11 downto 0);
   signal image_rgb   :std_logic_vector(11 downto 0);
   signal display_rgb :std_logic_vector(11 downto 0);
  -- signal d_o      : std_logic_vector(11 downto 0);
--   signal we :  std_logic;
  -- signal addr: STD_LOGIC_VECTOR(19 downto 0);
  -- signal red,green,blue : std_logic_vector(7 downto 0);
   signal activeArea : std_logic;
   signal image_area : std_logic;
--   signal start:std_logic;
   signal clk_50 : std_logic;
   signal clk_25 : std_logic;
   signal clk_12 : std_logic;
begin
   
   vga_vsync <= vsync;

	btn_debounce: debounce PORT MAP(
		clk => clk_50,
		i   => btn,
		o   => resend
	);



	camera_control: camera_controller PORT MAP(
		clk             => clk_50,
		resend          => resend,
		config_finished => config_finished,
		sioc            => sioc,
		siod            => siod,
		reset           => reset,
		pwdn            => pwdn,
		xclk            => xclk
	);
	
	Image_buffer: blk_mem_gen_0 PORT MAP(
          clka  => pclk,   
          wea   => wren,
          addra => wraddress(18 downto 0),
          dina  => wrdata,
          clkb => clk_25,
          addrb => rdaddress,
          doutb => rddata
        );
	
	
   
	image_capture: camera_capture PORT MAP(
		pclk  => pclk,
		rez_160x120  => '0',
        rez_320x240 =>'0',
		vsync => vsync_t,
		href  => href,
		d     => data,
		addr  => wraddress,
		dout  => wrdata,
		we    => wren
	);
 
image_reader: blk_mem_gen_1 PORT map(
    clka=>clk_25,
    addra=>image_addr,
    douta=>image_data
  ); 
  
rgb_control: rgb_controller PORT MAP(
		CLK25      =>clk_25,-- clk_25,
		clkout     => open,
		mode       => mode,
		Hsync      => vga_hsync,
		Vsync      => vsync,
		Nblank     => nBlank,
		addr       =>image_addr, 
		x          => column,
		y          => row, 
		Nsync      => nsync,
      activeArea => activeArea,
      img_area =>image_area
	);

	rgb_generat: rgb_generator PORT MAP(
		Din => out_rgb,
		Din_ori=>image_rgb,
		Nblank => activeArea,
		realtime => mode,
		mode=>method,
		x=> column,
		y=>row,
		R => vga_r,
		G => vga_g,
		B => vga_b
	);

   	Camera_Adress: Adress_Generator PORT MAP(
		CLK25 => clk_25,
		enable => activeArea,
        vsync  => vsync,
		adress => rdaddress
	);
    
--    ram_memory: memory port map(
--    clka => clk_50,
--    wea => we,
--    addra => addr,
--    dina => out_rgb,
--    clkb => clk_50,
--    enb => '1',
--    addrb => vga_driver_R_address,
--    doutb => d_o
--    );

--    processing_image: processing_unit port map(
--      clock =>clk_25,
--      reset =>resend,
----      mode=>mode,
----      x=> column,
----	  y=> row,
--      start_process=>'1',
--      selected_kernel=>method,      
--      rgb_in=>image_rgb,
--      rgb_out=>out_rgb,      
--      is_processing=>is_processing,
--      write_enable=>write_enable
--    );
    
     processing_image: processing port map(
      clock =>clk_25,
--      reset =>resend,
--      mode=>mode,
--      x=> column,
--	  y=> row,
--      start_process=>'1',
      method=>method,      
      rgb_in=>image_rgb,
--      rgb_out=>out_rgb(11 downto 9),
      red_out=> out_rgb(11 downto 8),
      green_out=> out_rgb(7 downto 4),
      blue_out=> out_rgb(3 downto 0)     
--      is_processing=>is_processing,
--      write_enable=>write_enable
    );
    
    sound: audio PORT map( 
    CLK12MHZ => clk_12,
    INDEX1=>method, 
    SPKOUT=>SPKOUT);
     
 process(clk100)  ---二分频
      begin
         if rising_edge(clk100) then
            clk_50 <= not clk_50;
         end if;
      end process;
     
        
          process(clk_50)  ---二分频
                 begin
                    if rising_edge(clk_50) then
                       clk_25 <= not clk_25;
                    end if;
                 end process;
                 
           process(clk_25)  ---二分频
                 begin
                    if rising_edge(clk_25) then
                       clk_12 <= not clk_12;
                    end if;
                 end process;
        
        image_rgb<=image_data when mode='0' else 
                     rddata when mode='1';  
--        start<=  image_area when mode='0' else
--                 activeArea when mode='1';     
end Behavioral;

