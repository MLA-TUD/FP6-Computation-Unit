library ieee;
use ieee.std_logic_1164.all;

entity pipo is	-- parallel-in parallel-out (8-Bit Register; rising clock)
	port (
		a : in std_logic_vector(7 downto 0);	-- input: 8-bit data (to save)
		c : in std_logic;						-- clock
		r : in std_logic;						-- reset (to "00000000")
		b : out std_logic_vector(7 downto 0)	-- output: saved 8-bit data
	);
end pipo;

architecture behavior of pipo is
	
begin
	
	process(c, r) begin			-- pipo needs to be reseted before use!
		if r = '1' then
			b <= "00000000";	-- output is "00000000" (= reset 8-bit data) (asynchronous reset)
		elsif rising_edge(c) then
			b <= a;				-- output is a (on rising clock)
		end if;
	end process;
end behavior;
