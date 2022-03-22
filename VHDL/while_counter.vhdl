library work;
use work.array_vector_package.all;

library ieee;
use ieee.std_logic_1164.all;

entity while_counter is
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
end while_counter;

architecture behaviour of while_counter is
---------------------------------------
	component counter is
	generic (
        	bitSize : integer := 8
    	);
	port (		
        	clk : in std_logic;
        	rst : in std_logic;
		en : in std_logic;
		q : out std_logic_vector((bitSize - 1) downto 0)	
	);
	end component counter;
---------------------------------------
	component comparator is
	generic (
        	bitSize : integer := 8
    	);
	port (		
        	a : in std_logic_vector((bitSize - 1) downto 0);	
		b : in std_logic_vector((bitSize - 1) downto 0);	
        	eq : out std_logic
	);
	end component comparator;
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
signal andOut, notOut, comparatorOut:std_logic;
signal counterOut : std_logic_vector((counterSize-1) downto 0);
begin
	and1 : and_gate_two port map(a=>notOut,b=>clk,o=>andOut);
	not1 : not_gate port map(a=>comparatorOut,o=>notOut);
	counter1 : counter generic map(bitSize=>counterSize) port map(clk=>andOut,rst=>rst,en=>en,q=>counterOut);
	comparator1 : comparator generic map(bitSize=>counterSize) port map(a=>counterOut,b=>countUntil,eq=>comparatorOut);
	stopped <= comparatorOut;
	not_stopped <= notOut;

end behaviour;
