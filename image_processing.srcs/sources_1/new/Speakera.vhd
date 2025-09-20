LIBRARY IEEE ; --数控分频与演奏发生器
USE IEEE.STD_LOGIC_1164.ALL ;
ENTITY Speakera IS
 PORT ( clk : IN STD_LOGIC ; --待分频时钟
 Tone : IN INTEGER RANGE 0 TO 16#7FF# ;--分频预置数输入
 SpkS : OUT STD_LOGIC ) ; --发声输出
END ;
ARCHITECTURE one OF Speakera IS
 SIGNAL PreCLK : STD_LOGIC ;
 SIGNAL FullSpkS : STD_LOGIC ;
BEGIN
 DivideCLK : PROCESS(clk)
 VARIABLE Count4 : INTEGER RANGE 0 TO 15 ;
 BEGIN
 PreCLK <= '0' ;
 -- 将 CLK 进行 11 分频 PreCLK 为 CLK 的 11 分频
 IF Count4 > 11 THEN PreCLK <= '1' ; Count4 := 0;
 ELSIF clk'EVENT AND clk='1' THEN Count4 := Count4 + 1;
 END IF;
 END PROCESS ;
 GenSpkS : PROCESS(PreCLK, Tone)
 VARIABLE Count11 : INTEGER RANGE 0 TO 16#7FF# ;
 BEGIN
 IF PreCLK'EVENT AND PreCLK = '1' THEN -- 11 位可预置计数器
 IF Count11 = 16#7FF# THEN
 Count11 := Tone; --若计数已满 在时钟的上升沿 将预数锁入
 FullSpkS <= '1'; --11 位计数器 并使 FullSpkS 输出高电平
 ELSE Count11 := Count11 + 1; --否则继续计数 输出低电平
 FullSpkS <= '0' ; END IF;
 END IF;
 END PROCESS;
 DelaySpkS : PROCESS(FullSpkS) --发音输出二分频进程
 VARIABLE Count2 : STD_LOGIC ;
BEGIN -- 将输出再进行二分频 将脉冲展宽 以使扬声器有足够功率发音
 IF FullSpkS'EVENT AND FullSpkS = '1' THEN
 Count2 := NOT Count2 ;
 IF Count2 = '1' THEN SpkS <= '1';
 ELSE SpkS <= '0' ; END IF;
 END IF ;
 END PROCESS ;
END ;