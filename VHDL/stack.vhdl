library work;
use work.array_vector_package.all;

library ieee;
use ieee.std_logic_1164.all;

entity stack is	
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
end stack;

architecture behavior of stack is
type stackMem is array(0 to stackSize) of std_logic_vector(bitSize-1 downto 0);
signal addr:integer :=0;
signal memory:stackMem;
begin
	process(pop,push,n_reset) begin
		if(n_reset='0')then
			addr<=0;
		end if;
		if rising_edge(pop) then
			if addr=0 then
				q <= (others => '0');	
			else 
				q <= memory(addr);
				addr <= addr-1;
				if addr = 0 then
					empty <= '1';
				end if;
			end if;
			full <= '0';
		end if;
		if rising_edge(push) then
			if addr<stackSize then
				addr <= addr+1;
				memory(addr) <= d;
				if addr = stackSize then
					full <= '1';
				end if;
			end if;
			empty <= '0';
		end if;
	end process;
	
end behavior;
