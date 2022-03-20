library work;
use work.array_vector_package.all;

library ieee;
use ieee.std_logic_1164.all;

entity stack_tb is
end stack_tb;

architecture test of stack_tb is
	component stack is
        generic (
        	stackSize : integer := 8;
        	bitSize : integer := 8
    	);
	port (		
		d : in std_logic_vector((bitSize - 1) downto 0);	
		push : in std_logic;
		pop : in std_logic;	
		n_reset : in std_logic;
        	empty : out std_logic;
		full : out std_logic;
		q : out std_logic_vector((bitSize - 1) downto 0)	
	);
    	end component stack;
    
	signal d,q: std_logic_vector(7 downto 0)  ;
	signal push, pop, n_reset, empty, full: std_logic;
	
begin
    stack1: stack generic map(stackSize=>4, bitSize=>8)port map(d => d, push => push, pop => pop, n_reset => n_reset, empty => empty, full => full, q => q);
    
	process begin
		n_reset <= '0';
		push <= '0';
		pop <= '0';
		d <= "00001111";
		wait for 10 ns;
		n_reset <= '1';
		wait for 10 ns;
		push <= '1';wait for 10 ns;push <= '0';wait for 10 ns;
		d <= "10101010";
		push <= '1';wait for 10 ns;push <= '0';wait for 10 ns;
		d <= "01010101";
		push <= '1';wait for 10 ns;push <= '0';wait for 10 ns;
		d <= "11110000";
		push <= '1';wait for 10 ns;push <= '0';wait for 10 ns;
		pop <= '1';wait for 10 ns;pop <= '0';wait for 10 ns;
		pop <= '1';wait for 10 ns;pop <= '0';wait for 10 ns;
		pop <= '1';wait for 10 ns;pop <= '0';wait for 10 ns;
		pop <= '1';wait for 10 ns;pop <= '0';wait for 10 ns;
		pop <= '1';wait for 10 ns;pop <= '0';wait for 10 ns;
	end process;
end test;
