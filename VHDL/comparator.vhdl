library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity comparator is	
    generic (
        bitSize : integer := 8                              --Size of bitvectors that are compared
    );
	port (		
        a : in std_logic_vector((bitSize - 1) downto 0);	--First bitvector
		b : in std_logic_vector((bitSize - 1) downto 0);	--First bitvector
        eq : out std_logic                                  --Output: HIGH when  a = b
	);
end comparator;

architecture behavior of comparator is
begin
	eq <= '1' when a = b else '0';	
end behavior;
