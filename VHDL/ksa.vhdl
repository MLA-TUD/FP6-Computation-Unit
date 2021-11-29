library ieee;
use ieee.std_logic_1164.all;

entity ksa is -- kogge-stone adder
	port ( -- s: sum
		a : in std_logic_vector(7 downto 0);
		b : in std_logic_vector(7 downto 0);
		s : out std_logic_vector(7 downto 0)
	);
end ksa;

architecture behavior of ksa is
	signal propagate_0, propagate_1, propagate_2, propagate_3, propagate_4 : std_logic_vector(7 downto 0);
	signal generate_0, generate_1, generate_2, generate_3, generate_4 : std_logic_vector(7 downto 0);
	signal carries : std_logic_vector(7 downto 0);
	
begin
	process begin
		-- row_0:
		propagate_0 <= a xor b;
		generate_0 <= a and b;
		
		wait for 0 ns;
		-- row_1
		row_1: for i in 7 downto 1 loop
			propagate_1(i) <= propagate_0(i) and propagate_0(i - 1);
			generate_1(i) <= (propagate_0(i) and generate_0(i - 1)) or generate_0(i);
		end loop row_1;
		propagate_1(0) <= propagate_0(0);
		generate_1(0) <= generate_0(0);
		
		wait for 0 ns;
		-- row_2:
		row_2_1: for i in 7 downto 2 loop
			propagate_2(i) <= propagate_1(i) and propagate_1(i - 2);
			generate_2(i) <= (propagate_1(i) and generate_1(i - 2)) or generate_1(i);
		end loop row_2_1;
		row_2_2: for i in 1 downto 0 loop
			propagate_2(i) <= propagate_1(i);
			generate_2(i) <= generate_1(i);
		end loop row_2_2;
		
		wait for 0 ns;
		-- row_3:
		row_3_1: for i in 7 downto 4 loop
			propagate_3(i) <= propagate_2(i) and propagate_2(i - 4);
			generate_3(i) <= (propagate_2(i) and generate_2(i - 4)) or generate_2(i);
		end loop row_3_1;
		row_3_2: for i in 3 downto 0 loop
			propagate_3(i) <= propagate_2(i);
			generate_3(i) <= generate_2(i);
		end loop row_3_2;
		
		wait for 0 ns;
		-- row_3:
		propagate_4(7) <= propagate_3(7) and propagate_3(0);
		generate_4(7) <= (propagate_3(7) and generate_3(0)) or generate_3(7);
		row_4_2: for i in 6 downto 0 loop
			propagate_4(i) <= propagate_3(i);
			generate_4(i) <= generate_3(i);
		end loop row_4_2;
		
		wait for 0 ns;
		
		-- Carries:
		carries <= generate_4;
		
		wait for 0 ns;
		
		-- Sum:
		sum: for i in 7 downto 1 loop
			s(i) <= propagate_0(i) xor carries(i - 1);
		end loop sum;
		s(0) <= propagate_0(0); -- carries(-1) = 0, da wir keinen carry-input haben
		wait;
	end process;
end behavior;