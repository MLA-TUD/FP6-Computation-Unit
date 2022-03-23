library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity counter is	
    generic (
        bitSize : integer := 8                              --Maximum size of counter vector
    );
	port (		
        clk : in std_logic;                                 --Clocksignal
        rst : in std_logic;                                 --Asynchronous reset active HIGH
		en : in std_logic;                                  --Counter enable active HIGH
		q : out std_logic_vector((bitSize - 1) downto 0)	--Current counter value as bitvector
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
			if en = '1' then
                tmp <= std_logic_vector(to_unsigned(to_integer(unsigned( tmp )) + 1, bitSize));
				q <= std_logic_vector(to_unsigned(to_integer(unsigned( tmp )) + 1, bitSize));
			end if;
        end if;
	end process;
	
end behavior;
