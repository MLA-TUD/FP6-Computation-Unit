library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity wtm_tb is	-- wallace-tree multiplier testbench
end wtm_tb;

architecture test of wtm_tb is
	component wtm is	-- wallace-tree multiplier (twos complement (2k) correct, 8-Bit (not 16-bit) (shortened) product)
		port (
			a : in std_logic_vector(7 downto 0);	-- input 1: 8-bit signed (2k) data
			b : in std_logic_vector(7 downto 0);	-- input 2: 8-bit signed (2k) data
			p : out std_logic_vector(7 downto 0)	-- output product: 8-bit signed (2k) data
		);
	end component wtm;
	
	signal a, b : std_logic_vector(7 downto 0);
	signal p : std_logic_vector(7 downto 0);
begin
	wallace_tree_multiplier: wtm port map(a, b, p);
	
	process begin
		for i in 0 to 255 loop		-- loop through all possible 8-bit 2k numbers for a
			a <= std_logic_vector(to_unsigned(i, 8));
			
			for j in 0 to 255 loop	-- loop through all possible 8-bit 2k numbers for b
				b <=std_logic_vector(to_unsigned(j, 8));
			
				wait for 20 ns;		-- watch out for: over- and underflows and that the product is (shortened and) in [-128, 127]	(tip: in gtkwave: set number format: to signed Decimal)
			end loop;
		end loop;
		wait;
	end process;
end test;
