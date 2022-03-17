library ieee;
use ieee.std_logic_1164.all;

entity pipo is	-- parallel-in parallel-out (8-Bit Register; rising clock)
	port (		-- c: clock; r: reset
		a : in std_logic_vector(7 downto 0);	-- input: 8-bit data (to save)
		c : in std_logic;						-- clock
		r : in std_logic;						-- reset (to "00000000")
		b : out std_logic_vector(7 downto 0)	-- output: saved 8-bit data
	);
end pipo;

architecture behavior of pipo is
	signal m : std_logic_vector(7 downto 0) := "00000000";	-- m: memory
begin
	
	process(c, r) begin
		if r = '1' then
			m <= (others => '0');	-- reset (if r='1') (asynchronous)
			b <= m;					-- output is m = "00000000" (= reset 8-bit data)
		elsif rising_edge(c) then
			m <= a;					-- save a to m (on a rising clock)
			b <= m;					-- output is m (= saved 8-bit data)
		end if;
	end process;
	
end behavior;
