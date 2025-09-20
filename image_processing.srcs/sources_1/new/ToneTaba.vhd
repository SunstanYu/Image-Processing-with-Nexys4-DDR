LIBRARY IEEE ; --乐曲简谱码对应的分频预置数查表电路
USE IEEE.STD_LOGIC_1164.ALL ;
ENTITY ToneTaba IS
 PORT (Index : IN INTEGER RANGE 0 TO 7 ; --简谱代码输入
 Tone : OUT INTEGER RANGE 0 TO 16#7FF# );-- 输入的简谱码查表 --值 即分频预置值输出
END ;
ARCHITECTURE one OF ToneTaba IS
BEGIN
 Search : PROCESS(Index)
 BEGIN
 CASE Index IS -- 译码电路 分频预置值查表并输出控制音调的预置数
 --同时由 CODE 输出显示对应的简谱码 由 HIGH 输出显示音调高低
 WHEN 0 => Tone <= 2047 ;
 WHEN 1 => Tone <= 773 ;
 WHEN 2 => Tone <= 912 ;
 WHEN 3 => Tone <= 1036 ;
 WHEN 5 => Tone <= 1197 ;
 WHEN 6 => Tone <= 1290 ;
 WHEN 7 => Tone <= 1372 ;
 WHEN OTHERS => NULL ;
 END CASE ;
 END PROCESS ;
END ;