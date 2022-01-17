library ieee;
use ieee.std_logic_1164.all;

entity pipo is -- parallel-in parallel-out (8-Bit Register)
	port ( -- c: clock; r: reset
		a : in std_logic_vector(7 downto 0);
		c : in std_logic;
		r : in std_logic;
		b : out std_logic_vector(7 downto 0)
	);
end pipo;

architecture behavior of pipo is
	-- m: memory
	signal m : std_logic_vector(7 downto 0);
begin
    
	process(c, r) begin
    if r = '1' then m <= (others => '0');
    elsif rising_edge(c) then
      m <= a;
    end if;
  	b <= m;
  end process;
  
end behavior;
