library ieee;
use ieee.std_logic_1164.all;

entity reg is	
    generic (
        bitSize : integer := 8
    );
	port (		
		d : in std_logic_vector((bitSize - 1) downto 0);	
		clk : in std_logic;	
		q : out std_logic_vector((bitSize - 1) downto 0)	
	);
end reg;

architecture behavior of reg is
begin
	
	process(clk) begin
		if rising_edge(clk) then				
			q <= d;
		end if;
	end process;
	
end behavior;
