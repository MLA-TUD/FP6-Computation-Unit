library work;
use work.array_vector_package.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.math_real.all;
use IEEE.NUMERIC_STD.ALL;

entity sa_filler is
	generic (
		systolicArraySize : integer := 8;
		bitSize : integer := 8;
		counterSize : integer := 24
	);
	port (
		regSize : in std_logic_vector ((counterSize-1) downto 0);
		clk : in std_logic;
		r_bar_w : in std_logic;
		rst : in std_logic;
		fifoOut : in std_logic_vector((bitSize-1) downto 0);
		rinc : out std_logic;
		rdy : out std_logic;
		saIn : out std_1d_vector_array(0 to systolicArraySize-1)
	);
end sa_filler;

architecture behaviour of sa_filler is
---------------------------------------
	component stack_filler is
        generic(
		bitSize:integer := 8;
		counterSize:integer := 24;
		systolicArraySize:integer :=8
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
---------------------------------------
	component and_gate_two is
	port (		
        	a,b : in std_logic;
        	o : out std_logic	
	);
	end component and_gate_two;
---------------------------------------
type array_std_logic_vector is array(0 to systolicArraySize-1) of std_logic_vector((counterSize-1) downto 0);
signal rdys,en,enNxt : std_logic_vector(0 to (systolicArraySize-1));
signal addressSize:integer;
signal numZeros : array_std_logic_vector;
begin
	addressSize <= integer(ceil(log2(real(systolicArraySize**2))));
	en(0) <= not r_bar_w;
	and1 : and_gate_two port map(a=>en(0),b=>rdys(systolicArraySize-1),o=>rinc);
	gen1 : FOR i IN 0 TO systolicArraySize-1 GENERATE
		numZeros(i)<=std_logic_vector(to_unsigned(i, counterSize));
		lower_bit: if i/=0 generate
	      		en(i)<=enNxt(i-1);
    		end generate lower_bit;
		stack_filler1 : stack_filler generic map(bitSize=>bitSize,counterSize=>counterSize,systolicArraySize=>systolicArraySize) port map(fifoIn=>fifoOut,clk=>clk,rst=>rst,en=>en(i),rd=>r_bar_w,regSize=>regSize,numZeros=>numZeros(i),enNxt=>enNxt(i),saIn=>saIn(i),rdy=>rdys(i));
	END GENERATE;
	rdy<=rdys(systolicArraySize-1);

end behaviour;
