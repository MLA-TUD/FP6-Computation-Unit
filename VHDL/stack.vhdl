library ieee;
use ieee.std_logic_1164.all;

entity stack is	
    generic (
        stackSize : integer := 8;
        bitSize : integer := 8
    );
	port (		
		d : in std_logic_vector((bitSize - 1) downto 0);	
		clk : in std_logic;	
        empty : out std_logic;
		q : out std_logic_vector((bitSize - 1) downto 0)	
	);
end stack;

architecture behavior of stack is
signal addr:integer := 0;
signal memory:
begin
	
	
end behavior;
