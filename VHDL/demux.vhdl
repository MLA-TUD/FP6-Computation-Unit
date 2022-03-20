library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity demux is	
    generic (
        bitSize : integer := 8
    );
	port (		
        x : in std_logic;
		s : in std_logic_vector((bitSize - 1) downto 0);	
		q : out std_logic_vector((2**bitSize - 1) downto 0)	
	);
end demux;

architecture behavior of demux is
begin
	
	process(x,s) begin
		q <= (others => '0');
        q(to_integer(unsigned(s))) <= '1';
	end process;
	
end behavior;
