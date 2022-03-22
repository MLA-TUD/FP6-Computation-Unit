library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity counter is	
	generic (
        	bitSize : integer := 8
    	);
	port (		
        	clk : in std_logic;
        	rst : in std_logic;
		q : out std_logic_vector((bitSize - 1) downto 0)	
	);
end counter;

architecture behavior of counter is
signal tmp : std_logic_vector((bitSize - 1) downto 0) := (others => '0');
begin
	
	process(clk, rst) begin
		if rst = '1' then
			q <= (others => '0');
		end if;
		if rising_edge(clk) then
                	tmp <= std_logic_vector(to_unsigned(to_integer(unsigned( tmp )) + 1, bitSize));
			q <= std_logic_vector(to_unsigned(to_integer(unsigned( tmp )) + 1, bitSize));
            	end if;
	end process;
	
end behavior;
