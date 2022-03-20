library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity counter is	
    generic (
        bitSize : integer := 8
    );
	port (		
        clk : in std_logic;
        n_r : in std_logic;
		q : out std_logic_vector((bitSize - 1) downto 0)	
	);
end counter;

architecture behavior of counter is
signal tmp : std_logic_vector((bitSize - 1) downto 0) := (others => '0');
begin
	
	process(clk) begin
		if rising_edge(clk) then
            if n_r='0' then
			    q <= (others => '0');	-- reset (if r='0') (synchronous)
            else
                tmp <= std_logic_vector(to_unsigned(to_integer(unsigned( tmp )) + 1, bitSize));
			    q <= tmp;
            end if;
		end if;
	end process;
	
end behavior;
