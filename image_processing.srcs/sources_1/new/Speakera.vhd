LIBRARY IEEE ; --���ط�Ƶ�����෢����
USE IEEE.STD_LOGIC_1164.ALL ;
ENTITY Speakera IS
 PORT ( clk : IN STD_LOGIC ; --����Ƶʱ��
 Tone : IN INTEGER RANGE 0 TO 16#7FF# ;--��ƵԤ��������
 SpkS : OUT STD_LOGIC ) ; --�������
END ;
ARCHITECTURE one OF Speakera IS
 SIGNAL PreCLK : STD_LOGIC ;
 SIGNAL FullSpkS : STD_LOGIC ;
BEGIN
 DivideCLK : PROCESS(clk)
 VARIABLE Count4 : INTEGER RANGE 0 TO 15 ;
 BEGIN
 PreCLK <= '0' ;
 -- �� CLK ���� 11 ��Ƶ PreCLK Ϊ CLK �� 11 ��Ƶ
 IF Count4 > 11 THEN PreCLK <= '1' ; Count4 := 0;
 ELSIF clk'EVENT AND clk='1' THEN Count4 := Count4 + 1;
 END IF;
 END PROCESS ;
 GenSpkS : PROCESS(PreCLK, Tone)
 VARIABLE Count11 : INTEGER RANGE 0 TO 16#7FF# ;
 BEGIN
 IF PreCLK'EVENT AND PreCLK = '1' THEN -- 11 λ��Ԥ�ü�����
 IF Count11 = 16#7FF# THEN
 Count11 := Tone; --���������� ��ʱ�ӵ������� ��Ԥ������
 FullSpkS <= '1'; --11 λ������ ��ʹ FullSpkS ����ߵ�ƽ
 ELSE Count11 := Count11 + 1; --����������� ����͵�ƽ
 FullSpkS <= '0' ; END IF;
 END IF;
 END PROCESS;
 DelaySpkS : PROCESS(FullSpkS) --�����������Ƶ����
 VARIABLE Count2 : STD_LOGIC ;
BEGIN -- ������ٽ��ж���Ƶ ������չ�� ��ʹ���������㹻���ʷ���
 IF FullSpkS'EVENT AND FullSpkS = '1' THEN
 Count2 := NOT Count2 ;
 IF Count2 = '1' THEN SpkS <= '1';
 ELSE SpkS <= '0' ; END IF;
 END IF ;
 END PROCESS ;
END ;