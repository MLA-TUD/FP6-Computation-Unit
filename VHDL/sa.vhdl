library work;
use work.array_vector_package.all;

library ieee;
use ieee.std_logic_1164.all;

entity sa is -- systolic array
	generic ( -- size: of the array Hier bitte einen eindeutigen Namen geben z.B. SystolicArraySize da noch mehr generics dazu kommen werden
		size : positive := 8
	);
	port ( -- c: clock; r: reset
		a : in std_1d_vector_array; -- upper side
		b : in std_1d_vector_array; -- left side
		c : in std_logic;
		r : in std_logic;
		d : out std_2d_vector_array
	);
end sa;

architecture behavior of sa is
	component mac is -- multiply-accumulate unit
		port ( -- c: clock; r: reset
			a : in std_logic_vector(7 downto 0); --eingang 1
			b : in std_logic_vector(7 downto 0); --eingang 2
			c : in std_logic; 
			r : in std_logic;
			d : out std_logic_vector(7 downto 0); --output mac 
			e : out std_logic_vector(7 downto 0); -- right out
            f : out std_logic_vector(7 downto 0) --bottom out
		);
	end component mac;
	
	signal hor : std_2d_vector_array_length9;
	signal ver : std_2d_vector_array_length9;
	
begin
    
    
   gen1 : FOR i IN 0 TO size-1 GENERATE
    --fill first lines
    hor(0, i) <= a(i);
    ver(i, 0) <= b(i);
      gen2 : FOR j IN 0 TO size-1 GENERATE
        mac1 : mac port map(a => hor(i, j), b => ver(i,j), c => c, r => r, d => d(i, j), e => hor(i+1, j+1), f => ver(i+1, j+1) );
      END GENERATE;  
   END GENERATE;
    
	-- ?
end behavior;
