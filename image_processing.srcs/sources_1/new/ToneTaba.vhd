LIBRARY IEEE ; --�����������Ӧ�ķ�ƵԤ��������·
USE IEEE.STD_LOGIC_1164.ALL ;
ENTITY ToneTaba IS
 PORT (Index : IN INTEGER RANGE 0 TO 7 ; --���״�������
 Tone : OUT INTEGER RANGE 0 TO 16#7FF# );-- ����ļ������� --ֵ ����ƵԤ��ֵ���
END ;
ARCHITECTURE one OF ToneTaba IS
BEGIN
 Search : PROCESS(Index)
 BEGIN
 CASE Index IS -- �����· ��ƵԤ��ֵ����������������Ԥ����
 --ͬʱ�� CODE �����ʾ��Ӧ�ļ����� �� HIGH �����ʾ�����ߵ�
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