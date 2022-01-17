library ieee;
use ieee.std_logic_1164.all;

entity pipo is -- parallel-in parallel-out (8-Bit Register)
	port ( -- c: clock; r: reset
		a : in std_logic_vector(7 downto 0);
		c : in std_logic;
		r : in std_logic;
		b : out std_logic_vector(7 downto 0)
	);
end pipo;

architecture behavior of pipo is
	-- m: memory
	signal m : std_logic_vector(7 downto 0);
begin
	reset: process(r)
		if r = '1' then
			m = "00000000";
			b <= m;
		end if;
	end process reset;
	
	save: process begin(c, a)
		if c'event and c = '1' then
			m <= a;
			b <= m;
		end if;
	end process save;
end behavior;