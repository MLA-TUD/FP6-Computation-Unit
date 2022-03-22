library work;
use work.array_vector_package.all;

library ieee;
use ieee.std_logic_1164.all;

entity stack_filler is
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
end stack_filler;

architecture behaviour of stack_filler is
---------------------------------------
	component while_counter is
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
---------------------------------------
	component n_bit_mux_two_one is
	generic (
		bitSize : integer := 8	
	);	
	port (		
        	a,b : in std_logic_vector(bitSize-1 downto 0);
		s : in std_logic;
        	o : out std_logic_vector(bitSize-1 downto 0)	
	);
	end component n_bit_mux_two_one;
---------------------------------------
	component or_gate_three is
	port (		
        	a,b,c : in std_logic;
        	o : out std_logic	
	);
	end component or_gate_three;
---------------------------------------
	component and_gate_two is
	port (		
        	a,b : in std_logic;
        	o : out std_logic	
	);
	end component and_gate_two;
---------------------------------------
	component and_gate_three is
	port (		
        	a,b,c : in std_logic;
        	o : out std_logic	
	);
	end component and_gate_three;
---------------------------------------
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
        	clk     : in  std_logic;
        	rst     : in  std_logic
   	);
	end component;
	
signal counter1Stopped, counter1NotStopped, counter2Stopped, counter2NotStopped, orOut, andOut1,andOut2,andOut3, stackEmpty, stackFull:std_logic;
signal zeros:std_logic_vector((bitSize-1) downto 0) := (others => '0');
signal muxOut:std_logic_vector((bitSize-1) downto 0);

begin
	while_counter1 : while_counter generic map(counterSize=>counterSize) port map(clk=>clk,en=>en,rst=>rst,countUntil=>numVals,stopped=>counter1Stopped,not_stopped=>counter1NotStopped);
	while_counter2 : while_counter generic map(counterSize=>counterSize) port map(clk=>clk,en=>counter1Stopped,rst=>rst,countUntil=>numZeros,stopped=>counter2Stopped,not_stopped=>counter2NotStopped);
	mux1 : n_bit_mux_two_one generic map(bitSize=>bitSize) port map(a=>valIn,b=>zeros,s=>counter1Stopped,o=>muxOut);
	
	and1 : and_gate_two port map(a=>clk,b=>rd,o=>andOut1);
	and2 : and_gate_three port map(a=>clk,b=>counter1NotStopped,c=>en,o=>andOut2);
	and3 : and_gate_three port map(a=>clk,b=>counter2NotStopped,c=>en,o=>andOut3);
	or1 : or_gate_three port map(a=>andOut1,b=>andOut2,c=>andOut3,o=>orOut);
	stack1 : stack generic map(bitSize=>bitSize,stackSize=>stackSize) port map(d=>muxOut,q=>valOut,bar_push_pop=>rd,full=>stackFull,empty=>stackEmpty,clk=>orOut,rst=>rst);
	enNxt <= counter1Stopped;
	rdy <=	counter2Stopped and counter1Stopped;

end behaviour;








