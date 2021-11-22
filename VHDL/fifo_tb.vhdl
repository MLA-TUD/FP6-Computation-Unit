library ieee;
use ieee.std_logic_1164.all;

entity fifo_tb is -- first-in first-out testbench (parallel-in parallel-out)
end fifo_tb;

architecture test of fifo_tb is
	component fifo is -- first-in first-out (parallel-in parallel-out)
		port ( -- c: clock; r: reset
			a : in std_logic_vector(7 downto 0);
			c : in std_logic;
			r : in std_logic;
			b : out std_logic_vector(7 downto 0)
		);
	end component fifo;
	
	-- ?
begin
	fi_fo: fifo port map( ? );
	
	process begin
		-- ?
		wait;
	end process;
end test;