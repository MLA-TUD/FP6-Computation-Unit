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
		fifoIn : in std_logic_vector((bitSize-1) downto 0);
		clk : in std_logic;
		rst : in std_logic;
		en : in std_logic;
		rd : in std_logic;
		regSize : in std_logic_vector((counterSize-1) downto 0);
		numZeros : in std_logic_vector((counterSize-1) downto 0);
		enNxt : out std_logic;
		saIn : out std_logic_vector((bitSize-1) downto 0);
		rdy : out std_logic
	);
    	end component stack_filler;


begin
    stack_filler1: stack_filler generic map(bitSize=>8, counterSize=>4, stackSize=>8)port map(regSize=>regSize,clk=>clk,r_bar_w=>r_bar_w,rst=>rst,fifoOut=>fifoOut,rinc=>rinc,rdy=>rdy,saIn=>saIn);
    
	process begin
		wait;		
			
	end process;
end test;
