LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

ENTITY light IS
	PORT(
		s1, s2 : IN  STD_LOGIC   ;
		f		: OUT STD_LOGIC
		) ;
END light ;

ARCHITECTURE LogicFunction OF light IS
BEGIN
	f <= (s1 AND NOT s2) OR (NOT s1 and s2) ;
END LogicFunction ;