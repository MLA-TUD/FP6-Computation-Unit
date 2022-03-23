library work;
use work.array_vector_package.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.math_real.all;
use IEEE.NUMERIC_STD.ALL;
--prepares the serial coming data for systolic array to perform a matrix multiplication
entity sa_filler is
	generic (
		systolicArraySize : integer := 8;                           --Maximum size of systolic array
		bitSize : integer := 8;                                     --Bitvectorsize of values from FiFo
		counterSize : integer := 24                                 --Size of counter for comparision 
	);
	port (
		numVals : in std_logic_vector ((counterSize-1) downto 0);   --Size of matrix to be multiplied (can be smaller than maximum systolic array size)
		clk : in std_logic;                                         --Clock
		r_bar_w : in std_logic;                                     --Active HIGH read and active LOW write (write to stacks and read out values from the stacks)
		rst : in std_logic;                                         --Active HIGH reset, resets all counters and stacks
		fifoOut : in std_logic_vector((bitSize-1) downto 0);        --Inputvector from FiFo
		rinc : out std_logic;                                       --Indicates that the next value can be read
		rdy : out std_logic;                                        --Active HIGH when last row is fully filled
		saIn : out std_1d_vector_array(0 to systolicArraySize-1)    --Outputvector to systolic array
	);
end sa_filler;

architecture behaviour of sa_filler is
function To_Std_Logic(L: BOOLEAN) return std_ulogic is
	begin
		if L then
			return('1');
		else
			return('0');
		end if;
	end function To_Std_Logic;
---------------------------------------
	component stack_filler is
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
---------------------------------------
	component and_gate_two is
	port (		
        	a,b : in std_logic;
        	o : out std_logic	
	);
	end component and_gate_two;
---------------------------------------
	component not_gate is
	port (		
        	a : in std_logic;
        	o : out std_logic	
	);
	end component not_gate;
---------------------------------------
type array_std_logic_vector is array(0 to systolicArraySize-1) of std_logic_vector((counterSize-1) downto 0);
signal rdys,en,enNxt : std_logic_vector(0 to (systolicArraySize-1));
signal addressSize:integer;
signal numZeros : array_std_logic_vector;
signal tmpRdy:std_logic;
begin
	addressSize <= integer(ceil(log2(real(systolicArraySize**2))));
	en(0) <= not r_bar_w;
	gen1 : FOR i IN 0 TO systolicArraySize-1 GENERATE
		numZeros(i)<=std_logic_vector(to_unsigned(i+1, counterSize));
		lower_bit: if i/=0 generate
	      		en(i)<=enNxt(i-1) and To_Std_Logic((i)<to_integer(unsigned(numVals)));
    		end generate lower_bit;
		stack_filler1 : stack_filler generic map(bitSize=>bitSize,counterSize=>counterSize,stackSize=>(2*systolicArraySize)-1) port map(valIn=>fifoOut,clk=>clk,rst=>rst,en=>en(i),rd=>r_bar_w,numVals=>numVals,numZeros=>numZeros(i),enNxt=>enNxt(i),valOut=>saIn(i),rdy=>rdys(i));
	END GENERATE;
	rdy <= rdys(to_integer(unsigned(numVals)-1));
	rinc <= (not enNxt(to_integer(unsigned(numVals)-1))) and (not r_bar_w);

end behaviour;
