library work;
use work.array_vector_package.all;

library ieee;
use ieee.std_logic_1164.all;

entity stack_tb is
end stack_tb;

architecture test of stack_tb is
	component stack is
        generic(
        	bitSize : integer := 8;
        	stackSize : integer := 4
    	);
    	port(
        	d  : in  std_logic_vector(bitSize - 1 downto 0); 
        	q  : out std_logic_vector(bitSize - 1 downto 0);
        	bar_push_pop : in  std_logic; 
        	full  : out std_logic; 
        	empty : out std_logic; 
		en 	: in std_logic;
        	clk     : in  std_logic;
        	rst     : in  std_logic
    	);
    	end component stack;
    
	signal d,q: std_logic_vector(7 downto 0)  ;
	signal bar_push_pop, rst, clk, en, empty, full: std_logic;
	
begin
    stack1: stack generic map(stackSize=>4, bitSize=>8)port map(d => d, q => q, bar_push_pop => bar_push_pop, full => full, empty => empty, en=>en, clk => clk, rst => rst);
    
	process begin
		en <= '1';
		clk <= '0';
		bar_push_pop <= '0';
		rst <= '1';
		d <= "00001111";
		wait for 10 ns;
		rst <= '0';
		wait for 10 ns;
		bar_push_pop <= '0';
		
		wait for 10 ns;
		clk <= '1';wait for 10 ns;clk <= '0';wait for 10 ns;
		d <= "10101010";
		clk <= '1';wait for 10 ns;clk <= '0';wait for 10 ns;
		d <= "01010101";
		clk <= '1';wait for 10 ns;clk <= '0';wait for 10 ns;
		--d <= "11110000";
		--clk <= '1';wait for 10 ns;clk <= '0';wait for 10 ns;
		bar_push_pop <= '1';
		clk <= '1';wait for 10 ns;clk <= '0';wait for 10 ns;
		clk <= '1';wait for 10 ns;clk <= '0';wait for 10 ns;
		clk <= '1';wait for 10 ns;clk <= '0';wait for 10 ns;
		clk <= '1';wait for 10 ns;clk <= '0';wait for 10 ns;
		clk <= '1';wait for 10 ns;clk <= '0';wait for 10 ns;
		wait;
	end process;
end test;
