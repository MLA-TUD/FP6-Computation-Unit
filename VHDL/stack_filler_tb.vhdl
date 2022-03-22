library work;
use work.array_vector_package.all;

library ieee;
use ieee.std_logic_1164.all;

entity stack_filler_tb is		
end stack_filler_tb;

architecture test of stack_filler_tb is
	component stack_filler is -- systolic array
        generic(
		bitSize:integer := 8;
		counterSize:integer := 24;
		stackSize:integer :=8
	);
	port(
		valIn : in std_logic_vector((bitSize-1) downto 0);
		clk : in std_logic;
		rst : in std_logic;
		en : in std_logic;
		rd : in std_logic;
		numVals : in std_logic_vector((counterSize-1) downto 0);
		numZeros : in std_logic_vector((counterSize-1) downto 0);
		enNxt : out std_logic;
		valOut : out std_logic_vector((bitSize-1) downto 0);
		rdy : out std_logic
	);
    	end component stack_filler;

signal valIn, valOut:std_logic_vector(7 downto 0);
signal numVals, numZeros:std_logic_vector(3 downto 0);
signal clk, rst, en, rd, enNxt, rdy : std_logic;
begin
    stack_filler1: stack_filler generic map(bitSize=>8, counterSize=>4, stackSize=>8)port map(valIn=>valIn, clk=>clk, rst=>rst, en=>en, rd=>rd, numVals=>numVals, numZeros=>numZeros, enNxt=>enNxt, valOut=>valOut, rdy=>rdy);
    	process begin
		valIn <= "00000000";
		clk <= '0';
		rst <='1';
		en <='0';
		rd <='0';
		numVals <= "0010";
		numZeros<= "0010";
		
		wait for 10 ns;
		rst <= '0';
		en <= '1';
		wait for 10 ns;
		valIn <= "00000001";
		wait for 10 ns;
		clk <= '1';wait for 10 ns;clk <= '0';wait for 10 ns;
		valIn <= "00000010";
		wait for 10 ns;
		clk <= '1';wait for 10 ns;clk <= '0';wait for 10 ns;
		valIn <= "00000011";
		wait for 10 ns;
		clk <= '1';wait for 10 ns;clk <= '0';wait for 10 ns;
		valIn <= "00000100";
		wait for 10 ns;
		clk <= '1';wait for 10 ns;clk <= '0';wait for 10 ns;
		valIn <= "00000101";
		wait for 10 ns;
		clk <= '1';wait for 10 ns;clk <= '0';wait for 10 ns;
		rd <= '1';
		en <= '0';
		wait for 10 ns;
		clk <= '1';wait for 10 ns;clk <= '0';wait for 10 ns;
		wait for 10 ns;
		clk <= '1';wait for 10 ns;clk <= '0';wait for 10 ns;
		wait for 10 ns;
		clk <= '1';wait for 10 ns;clk <= '0';wait for 10 ns;
		wait for 10 ns;
		clk <= '1';wait for 10 ns;clk <= '0';wait for 10 ns;
		
		wait;		
			
	end process;
end test;
