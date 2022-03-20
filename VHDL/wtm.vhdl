library ieee;
use ieee.std_logic_1164.all;

entity wtm is	-- wallace-tree multiplier (twos complement (2k) correct, 8-Bit (not 16-bit) (shortened) product)
	port (
		a : in std_logic_vector(7 downto 0);	-- input 1: 8-bit signed (2k) data
		b : in std_logic_vector(7 downto 0);	-- input 2: 8-bit signed (2k) data
		p : out std_logic_vector(7 downto 0)	-- output product: 8-bit signed (2k) data
	);
end wtm;

architecture behavior of wtm is
	component ha is		-- half adder
		port (
			a : in std_logic;	-- input 1: bit
			b : in std_logic;	-- input 2: bit
			s : out std_logic;	-- output sum: bit
			c : out std_logic	-- output carry: bit
		);
	end component ha;
	
	component fa is		-- full adder
		port (
			a : in std_logic;		-- input 1: bit
			b : in std_logic;		-- input 2: bit
			c_in : in std_logic;	-- input (carry) 3: bit
			s : out std_logic;		-- output sum: bit
			c_out : out std_logic	-- output carry: bit
		);
	end component fa;
	
	component ksa is	-- kogge-stone adder (twos complement (2k) correct)
		port (
			a : in std_logic_vector(7 downto 0);	-- input 1: 8-bit signed (2k) data
			b : in std_logic_vector(7 downto 0);	-- input 2: 8-bit signed (2k) data
			s : out std_logic_vector(7 downto 0)	-- output sum: 8-bit data (twos complement correct)
		);
	end component ksa;
	
	component ksa_oo is		-- kogge-stone adder (unsigned and without overflow-detection)
		port (
			a : in std_logic_vector(7 downto 0);	-- input 1: 8-bit unsigned data
			b : in std_logic_vector(7 downto 0);	-- input 2: 8-bit unsigned data
			s : out std_logic_vector(7 downto 0)	-- output sum: 8-bit unsigned data
		);
	end component ksa_oo;
	
	signal ksa_a, ksa_b, a_x, b_x, a_u, b_u, a_s, b_s, ksa_sk, ksa_sx, p_ksa, ksa_s : std_logic_vector(7 downto 0);		-- u: unsigned
	signal p_s : std_logic;
	
	-- s: sum; c: carry	(per Stage)
	signal s00, s01, s02, s03, s04, s05, s06, s07, s12, s13, s31 : std_logic_vector(7 downto 0);
	signal s10, s11, s21 : std_logic_vector(9 downto 0);
	signal s20 : std_logic_vector(12 downto 0);
	signal s30, s40 : std_logic_vector(14 downto 0);
	signal c10, c11, c20, c21 : std_logic_vector(7 downto 0);
	signal c30 : std_logic_vector(9 downto 0);
	signal c40 : std_logic_vector(10 downto 0);
	
begin
	-- get unsigned 8-bit values from 8-bit 2k values (a and b)
	ksa1: ksa_oo port map(a, "11111111", ksa_a);	-- -1
	a_x <= ksa_a xor"11111111";						-- complement
	a_u <=											-- choose by sign
		'0' & a(6 downto 0) when a(7) = '0' else
		a_x;
	
	ksa2: ksa_oo port map(b, "11111111", ksa_b);	-- -1
	b_x <= ksa_b xor"11111111";						-- complement
	b_u <=											-- choose by sign
		'0' & b(6 downto 0) when b(7) = '0' else
		b_x;
	
	
    -- Stage 1:		(Multiplication  ->  Additions)
	row_0: for i in 0 to 7 generate
		s00(i) <= a_u(i) and b_u(0);
		s01(i) <= a_u(i) and b_u(1);
		s02(i) <= a_u(i) and b_u(2);
		s03(i) <= a_u(i) and b_u(3);
		s04(i) <= a_u(i) and b_u(4);
		s05(i) <= a_u(i) and b_u(5);
		s06(i) <= a_u(i) and b_u(6);
		s07(i) <= a_u(i) and b_u(7);
	end generate row_0;
	
	-- Stage 2.?	(8 rows  ->  2 rows)
	-- 1:
	s10(0) <= s00(0);
    ha00: ha port map(s00(1), s01(0), s10(1), c10(0));
    fa00: fa port map(s00(2), s01(1), s02(0), s10(2), c10(1));
    fa01: fa port map(s00(3), s01(2), s02(1), s10(3), c10(2));
    fa02: fa port map(s00(4), s01(3), s02(2), s10(4), c10(3));
    fa03: fa port map(s00(5), s01(4), s02(3), s10(5), c10(4));
    fa04: fa port map(s00(6), s01(5), s02(4), s10(6), c10(5));
    fa05: fa port map(s00(7), s01(6), s02(5), s10(7), c10(6));
    ha01: ha port map(s01(7), s02(6), s10(8), c10(7));
	s10(9) <= s02(7);
	
	s11(0) <= s03(0);
    ha02: ha port map(s03(1), s04(0), s11(1), c11(0));
    fa06: fa port map(s03(2), s04(1), s05(0), s11(2), c11(1));
    fa07: fa port map(s03(3), s04(2), s05(1), s11(3), c11(2));
    fa08: fa port map(s03(4), s04(3), s05(2), s11(4), c11(3));
    fa09: fa port map(s03(5), s04(4), s05(3), s11(5), c11(4));
    fa10: fa port map(s03(6), s04(5), s05(4), s11(6), c11(5));
    fa11: fa port map(s03(7), s04(6), s05(5), s11(7), c11(6));
    ha03: ha port map(s04(7), s05(6), s11(8), c11(7));
	s11(9) <= s05(7);
	
	s12 <= s06;
	
	s13 <= s07;
	
	-- 2:
	s20(0) <= s10(0);
	s20(1) <= s10(1);
	ha04: ha port map(s10(2), c10(0), s20(2), c20(0));
	fa12: fa port map(s10(3), c10(1), s11(0), s20(3), c20(1));
	fa13: fa port map(s10(4), c10(2), s11(1), s20(4), c20(2));
	fa14: fa port map(s10(5), c10(3), s11(2), s20(5), c20(3));
	fa15: fa port map(s10(6), c10(4), s11(3), s20(6), c20(4));
	fa16: fa port map(s10(7), c10(5), s11(4), s20(7), c20(5));
	fa17: fa port map(s10(8), c10(6), s11(5), s20(8), c20(6));
	fa18: fa port map(s10(9), c10(7), s11(6), s20(9), c20(7));
	s20(10) <= s11(7);
	s20(11) <= s11(8);
	s20(12) <= s11(9);
	
	s21(0) <= c11(0);
	ha05: ha port map(c11(1), s12(0), s21(1), c21(0));
	fa19: fa port map(c11(2), s12(1), s13(0), s21(2), c21(1));
	fa20: fa port map(c11(3), s12(2), s13(1), s21(3), c21(2));
	fa21: fa port map(c11(4), s12(3), s13(2), s21(4), c21(3));
	fa22: fa port map(c11(5), s12(4), s13(3), s21(5), c21(4));
	fa23: fa port map(c11(6), s12(5), s13(4), s21(6), c21(5));
	fa24: fa port map(c11(7), s12(6), s13(5), s21(7), c21(6));
	ha06: ha port map(s12(7), s13(6), s21(8), c21(7));
	s21(9) <= s13(7);
	
	-- 3:
	s30(0) <= s20(0);
	s30(1) <= s20(1);
	s30(2) <= s20(2);
	ha07: ha port map(s20(3), c20(0), s30(3), c30(0));
	ha08: ha port map(s20(4), c20(1), s30(4), c30(1));
	fa25: fa port map(s20(5), c20(2), s21(0), s30(5), c30(2));
	fa26: fa port map(s20(6), c20(3), s21(1), s30(6), c30(3));
	fa27: fa port map(s20(7), c20(4), s21(2), s30(7), c30(4));
	fa28: fa port map(s20(8), c20(5), s21(3), s30(8), c30(5));
	fa29: fa port map(s20(9), c20(6), s21(4), s30(9), c30(6));
	fa30: fa port map(s20(10), c20(7), s21(5), s30(10), c30(7));
	ha09: ha port map(s20(11), s21(6), s30(11), c30(8));
	ha10: ha port map(s20(12), s21(7), s30(12), c30(9));
	s30(13) <= s21(8);
	s30(14) <= s21(9);
	
	s31 <= c21;
	
	-- 4:
	s40(0) <= s30(0);
	s40(1) <= s30(1);
	s40(2) <= s30(2);
	s40(3) <= s30(3);
	ha11: ha port map(s30(4), c30(0), s40(4), c40(0));
	ha12: ha port map(s30(5), c30(1), s40(5), c40(1));
	ha13: ha port map(s30(6), c30(2), s40(6), c40(2));
	fa31: fa port map(s30(7), c30(3), s31(0), s40(7), c40(3));
	fa32: fa port map(s30(8), c30(4), s31(1), s40(8), c40(4));
	fa33: fa port map(s30(9), c30(5), s31(2), s40(9), c40(5));
	fa34: fa port map(s30(10), c30(6), s31(3), s40(10), c40(6));
	fa35: fa port map(s30(11), c30(7), s31(4), s40(11), c40(7));
	fa36: fa port map(s30(12), c30(8), s31(5), s40(12), c40(8));
	fa37: fa port map(s30(13), c30(9), s31(6), s40(13), c40(9));
	ha14: ha port map(s30(14), s31(7), s40(14), c40(10));
    
    -- Stage 3:		(ksa: 8-Bit (shortened))
	a_s <= '0' & s40(6 downto 0);
	b_s <= '0' & c40(1 downto 0) & "00000";
	ksa0: ksa port map(a_s, b_s, ksa_s);	-- add up last two (remaining) rows (unsigned values) (shortened -> only need 7-bit value)
	
	-- Sign:
	p_s <=
		a(7) xor b(7) when (a_u /= "00000000") and (b_u /= "00000000") else	-- 0 can only be represented as a positive value
		'0';
	p(7) <= p_s;
	
	ksa_sk <= ksa_s xor "11111111";						-- complement
	ksa3: ksa port map(ksa_sk, "00000001", ksa_sx);		-- +1
	p_ksa <=											-- choose by sign
		ksa_s when p_s = '0' else
		ksa_sx;
	
	-- Overflow Check:
	p(6 downto 0) <=
		p_ksa(6 downto 0) 	when '0' = (s40(14) or s40(13) or s40(12) or s40(11) or s40(10) or s40(9) or s40(8) or s40(7) or c40(10) or c40(9) or c40(8) or c40(7) or c40(6) or c40(5) or c40(4) or c40(3) or c40(2)) 	else	-- no overflow
		"1111111" 			when p_s = '0' 																																												else	-- positive overflow; 	p <= max positive (127)
		"0000000" 			when p_s = '1';																																														-- negative overflow; 	p <= max negative (-128)
end behavior;

library ieee;
use ieee.std_logic_1164.all;

entity ksa_oo is	-- kogge-stone adder (unsigned and without overflow-detection)	(only needed for unsigned-2k conversion in this wtm)
	port (			-- like the normal ksa, but without: 2k over- and underflow checks
		a : in std_logic_vector(7 downto 0);	-- input 1: 8-bit unsigned data
		b : in std_logic_vector(7 downto 0);	-- input 2: 8-bit unsigned data
		s : out std_logic_vector(7 downto 0)	-- output sum: 8-bit unsigned data
	);
end ksa_oo;

architecture behavior of ksa_oo is
	signal propagate_0, propagate_1, propagate_2, propagate_3, propagate_4 : std_logic_vector(7 downto 0);	-- proparate per row:	P_{i+1} = P_i AND P_{i_prev}
	signal generate_0, generate_1, generate_2, generate_3, generate_4 : std_logic_vector(7 downto 0);		-- generate per row:	G_{i+1} = (P_i AND G_{i_prev}) OR G_i
	signal carries : std_logic_vector(7 downto 0);	-- that are generated by the calculation
	signal ksa_s : std_logic_vector(7 downto 0);	-- calculated sum of "a + b"
	
begin
	-- row 0:
	row_0: for i in 7 downto 0 generate
		propagate_0(i) <= a(i) xor b(i);	-- sum per digit place
		generate_0(i) <= a(i) and b(i);		-- carry per digit place
	end generate row_0;
	
	-- row 1
	row_1: for i in 7 downto 1 generate
		propagate_1(i) <= propagate_0(i) and propagate_0(i - 1);
		generate_1(i) <= (propagate_0(i) and generate_0(i - 1)) or generate_0(i);
	end generate row_1;
	propagate_1(0) <= propagate_0(0);
	generate_1(0) <= generate_0(0);
	
	-- row 2:
	row_2_1: for i in 7 downto 2 generate
		propagate_2(i) <= propagate_1(i) and propagate_1(i - 2);
		generate_2(i) <= (propagate_1(i) and generate_1(i - 2)) or generate_1(i);
	end generate row_2_1;
	row_2_2: for i in 1 downto 0 generate
		propagate_2(i) <= propagate_1(i);
		generate_2(i) <= generate_1(i);
	end generate row_2_2;
	
	-- row 3:
	row_3_1: for i in 7 downto 4 generate
		propagate_3(i) <= propagate_2(i) and propagate_2(i - 4);
		generate_3(i) <= (propagate_2(i) and generate_2(i - 4)) or generate_2(i);
	end generate row_3_1;
	row_3_2: for i in 3 downto 0 generate
		propagate_3(i) <= propagate_2(i);
		generate_3(i) <= generate_2(i);
	end generate row_3_2;
	
	-- row 4:
	propagate_4(7) <= propagate_3(7) and propagate_3(0);
	generate_4(7) <= (propagate_3(7) and generate_3(0)) or generate_3(7);
	row_4_2: for i in 6 downto 0 generate
		propagate_4(i) <= propagate_3(i);
		generate_4(i) <= generate_3(i);
	end generate row_4_2;
	
	-- Carries:
	carries <= generate_4;
	
	-- Sum:
	sum: for i in 7 downto 1 generate
		ksa_s(i) <= propagate_0(i) xor carries(i - 1);
	end generate sum;
	ksa_s(0) <= propagate_0(0);
	
	s <= ksa_s;
end behavior;
