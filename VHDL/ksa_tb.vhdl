library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ksa_tb is	-- kogge-stone adder testbench
end ksa_tb;

architecture test of ksa_tb is
	component ksa is	-- kogge-stone adder (twos complement correct)
		port (			-- s: sum
			a : in std_logic_vector(7 downto 0);	-- input: 1: 8-bit signed (2k) data
			b : in std_logic_vector(7 downto 0);	-- input: 2: 8-bit signed (2k) data
			s : out std_logic_vector(7 downto 0)	-- output: sum 8-bit data (twos complement correct)
		);
	end component ksa;
	
	signal a, b, s : std_logic_vector(7 downto 0);
	
begin
	kogge_stone_adder: ksa port map(a, b, s);
	
	process begin
		for i in 0 to 255 loop		-- loop through all possible 8-bit 2k numbers for a
			a <= std_logic_vector(to_unsigned(i, 8));
			
			for j in 0 to 255 loop	-- loop through all possible 8-bit 2k numbers for b
				b <=std_logic_vector(to_unsigned(j, 8));
				
				wait for 20 ns;		-- watch out for: over- and underflows and that the sum is in [-128, 127]	(tip: in gtkwave: set number format: to signed Decimal)
			end loop;
		end loop;
		wait;
	end process;
end test;
