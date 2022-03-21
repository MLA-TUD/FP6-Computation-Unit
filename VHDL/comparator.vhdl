library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity comparator is	
    	generic (
        	bitSize : integer := 8
    	);
	port (		
        	a : in std_logic_vector((bitSize - 1) downto 0);	
		b : in std_logic_vector((bitSize - 1) downto 0);	
        	eq : out std_logic
	);
end comparator;

architecture behavior of comparator is
signal tmp : std_logic;
begin
	process(a,b) begin
        tmp <= '1';
		for i in 0 to (bitSize - 1) loop
		    if a(i) /= b(i) then --They are different
                tmp <= '0';
            end if;
	    end loop;
	    eq <= tmp;
	end process;
	
end behavior;
