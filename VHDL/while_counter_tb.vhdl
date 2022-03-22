library work;
use work.array_vector_package.all;

library ieee;
use ieee.std_logic_1164.all;

entity while_counter_tb is		
end while_counter_tb;

architecture test of while_counter_tb is
	component while_counter is -- systolic array
        generic(
		counterSize:integer := 24
	);
	port(
		clk : in std_logic;
		en : in std_logic;
		rst : in std_logic;
		countUntil : in std_logic_vector((counterSize-1) downto 0);
		stopped : out std_logic;
		not_stopped : out std_logic
	);
    	end component while_counter;

    
signal clk, en, rst, stopped, not_stopped:std_logic;
signal countUntil:std_logic_vector((8-1) downto 0);
begin
    while_counter1: while_counter generic map(counterSize=>8)port map(clk=>clk, en=>en, rst=>rst, countUntil=>countUntil, stopped=>stopped, not_stopped=>not_stopped);  
	process begin
		countUntil <= "00000100"; -- count until 4
		clk <= '0';
		en <= '0';
		rst <= '1';
		wait for 10 ns;
		en <= '1';
		rst <= '0';
		wait for 10 ns;
		clk <= '1';wait for 10 ns;clk <= '0';wait for 10 ns;
		clk <= '1';wait for 10 ns;clk <= '0';wait for 10 ns;
		clk <= '1';wait for 10 ns;clk <= '0';wait for 10 ns;
		clk <= '1';wait for 10 ns;clk <= '0';wait for 10 ns;
		clk <= '1';wait for 10 ns;clk <= '0';wait for 10 ns;
		clk <= '1';wait for 10 ns;clk <= '0';wait for 10 ns;
		wait;		
			
	end process;
end test;
