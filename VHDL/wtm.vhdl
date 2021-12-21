library ieee;
use ieee.std_logic_1164.all;

entity wtm is -- wallace-tree multiplier
	port ( -- p: product
		a : in std_logic_vector(7 downto 0);
		b : in std_logic_vector(7 downto 0);
		p : out std_logic_vector(15 downto 0)
	);
end wtm;

architecture behavior of wtm is
	component ha is -- half adder
		port ( -- s: sum; c: carry
			a : in std_logic;
			b : in std_logic;
			s : out std_logic;
			c : out std_logic
		);
	end component ha;
	
	component fa is -- full adder
		port ( -- s: sum; c: carry
			a : in std_logic;
			b : in std_logic;
			c_in : in std_logic;
			s : out std_logic;
			c_out : out std_logic
		);
	end component fa;
	-- 2D-Array?
	signal s00,s01,s02,s03,s04,s05,s06,s07,s10,s11,s12,s13,s14,s15,s16,s17,s20,s21,s22,s23,s24,s25,s26,s27,s30,s31,s32,s33,s34,s35,s36,s37,s40,s41,s42,s43,s44,s45,s46,s47,s50,s51,s52,s53,s54,s55,s56,s57,s60,s61,s62,s63,s64,s65,s66,s67,s70,s71,s72,s73,s74,s75,s76,s77:std_logic;
    signal k01,k02,k03,k04,k05,k06,k07,k08,k09,k10,k11,k12,k13,k14,k15,k16,k17,k18,k19,k20,k21,k22,k23,k24,k25,k26,k27,k28,k29,k30,k31,k32,k33,k34,k35,k36,k37,k38,k39,k40,k41,k42,k43,k44,k45,k46,k47,k48,k49,k50,k51,k52,k53,k54,k55,k56,k57,k58,k59,k60,k61,k62,k63,k64,k65,k66,k67,k68:std_logic;
    signal c01,c02,c03,c04,c05,c06,c07,c08,c09,c10,c11,c12,c13,c14,c15,c16,c17,c18,c19,c20,c21,c22,c23,c24,c25,c26,c27,c28,c29,c30,c31,c32,c33,c34,c35,c36,c37,c38,c39,c40,c41,c42,c43,c44,c45,c46,c47,c48,c49,c50,c51,c52,c53,c54,c55,c56,c57,c58,c59,c60,c61,c62,c63,c64,c65,c66,c67,c68:std_logic;

begin
    -- Loop over s
    s00 <= a(0) and b(0);
    s10 <= a(1) and b(0);
    s20 <= a(2) and b(0);
    s30 <= a(3) and b(0);
    s40 <= a(4) and b(0);
    s50 <= a(5) and b(0);
    s60 <= a(6) and b(0);
    s70 <= a(7) and b(0);
    s01 <= a(0) and b(1);
    s11 <= a(1) and b(1);
    s21 <= a(2) and b(1);
    s31 <= a(3) and b(1);
    s41 <= a(4) and b(1);
    s51 <= a(5) and b(1);
    s61 <= a(6) and b(1);
    s71 <= a(7) and b(1);
    s02 <= a(0) and b(2);
    s12 <= a(1) and b(2);
    s22 <= a(2) and b(2);
    s32 <= a(3) and b(2);
    s42 <= a(4) and b(2);
    s52 <= a(5) and b(2);
    s62 <= a(6) and b(2);
    s72 <= a(7) and b(2);
    s03 <= a(0) and b(3);
    s13 <= a(1) and b(3);
    s23 <= a(2) and b(3);
    s33 <= a(3) and b(3);
    s43 <= a(4) and b(3);
    s53 <= a(5) and b(3);
    s63 <= a(6) and b(3);
    s73 <= a(7) and b(3);
    s04 <= a(0) and b(4);
    s14 <= a(1) and b(4);
    s24 <= a(2) and b(4);
    s34 <= a(3) and b(4);
    s44 <= a(4) and b(4);
    s54 <= a(5) and b(4);
    s64 <= a(6) and b(4);
    s74 <= a(7) and b(4);
    s05 <= a(0) and b(5);
    s15 <= a(1) and b(5);
    s25 <= a(2) and b(5);
    s35 <= a(3) and b(5);
    s45 <= a(4) and b(5);
    s55 <= a(5) and b(5);
    s65 <= a(6) and b(5);
    s75 <= a(7) and b(5);
    s06 <= a(0) and b(6);
    s16 <= a(1) and b(6);
    s26 <= a(2) and b(6);
    s36 <= a(3) and b(6);
    s46 <= a(4) and b(6);
    s56 <= a(5) and b(6);
    s66 <= a(6) and b(6);
    s76 <= a(7) and b(6);
    s07 <= a(0) and b(7);
    s17 <= a(1) and b(7);
    s27 <= a(2) and b(7);
    s37 <= a(3) and b(7);
    s47 <= a(4) and b(7);
    s57 <= a(5) and b(7);
    s67 <= a(6) and b(7);
    s77 <= a(7) and b(7);

    ha00: ha port map(s01,s10,k01,c01);
    fa00: fa port map(s20,s02,s11,k02,c02);
    fa01: fa port map(s30,s21,s12,k03,c03);
    fa02: fa port map(s40,s31,s22,k04,c04);
    ha01: fa port map(s13,s04,k05,c05);
    fa03: fa port map(s50,s41,s32,k06,c06);
    fa04: fa port map(s23,s14,s05,k07,c07);
    fa05: fa port map(s60,s51,s42,k08,c08);
    fa06: fa port map(s33,s24,s15,k09,c09);
    fa07: fa port map(s70,s61,s52,k10,c10);
    fa08: fa port map(s43,s34,s25,k11,c11);
    ha02: ha port map(s16,s07,k12,c12);
    fa09: fa port map(s71,s62,s53,k13,c13);
    fa90: fa port map(s44,s35,s26,k14,c14);
    fa31: fa port map(s72,s63,s54,k15,c15);
    fa32: fa port map(s45,s36,s27,k16,c16);
    fa33: fa port map(s73,s64,s55,k17,c17);
    ha03: fa port map(s46,s37,k18,c18);
    fa34: fa port map(s74,s65,s56,k19,c19);
    fa35: fa port map(s75,s66,s57,k20,c20);
    ha04: ha port map(s76,s67,k21,c21);

    ha10: ha port map(k02,c01,k22,c22);
    fa10: fa port map(s03,c02,k03,k23,c23);
    fa11: fa port map(k04,k05,c03,k24,c24);
    fa12: fa port map(k06,k07,c04,k25,c25);
    fa13: fa port map(k08,k09,s06,k26,c26);
    ha11: ha port map(c06,c07,k27,c27);
    fa14: fa port map(k10,k11,k12,k28,c28);
    ha12: ha port map(c08,c09,k29,c29);
    fa15: fa port map(k13,k14,s17,k30,c30);
    fa16: fa port map(c10,c11,c12,k31,c31);
    fa17: fa port map(k15,k16,c13,k32,c32);
    fa18: fa port map(k17,k18,c15,k33,c33);
    fa19: fa port map(k19,c17,c18,k34,c34);
    ha13: ha port map(k20,c19,k35,c35);
    ha14: ha port map(k21,c20,k36,c36);
    
    ha40: ha port map(k23,c22,k37,c37);
    ha41: ha port map(c23,k24,k38,c38);
    fa40: fa port map(c24,k25,c05,k39,c39);
    fa41: fa port map(c25,k26,k27,k40,c40);
    fa42: fa port map(c26,c27,k28,k41,c41);
    fa43: fa port map(c28,c29,k30,k42,c42);
    fa44: fa port map(c30,c31,k32,k43,c43);
    fa45: fa port map(c32,c16,k33,k44,c44);
    fa46: fa port map(c33,s47,k34,k45,c45);
    ha42: ha port map(k35,c34,k46,c46);
    ha43: ha port map(c35,k36,k47,c47);
    fa47: fa port map(s77,c21,c36,k48,c48);
    
    ha50: ha port map(c37,k38,k49,c49);
    fa50: fa port map(k39,c38,c49,k50,c50);
    fa51: fa port map(k40,c39,c50,k51,c51);
    fa52: fa port map(c40,k41,k29,k52,c52);
    fa53: fa port map(c41,k31,k42,k53,c53);
    fa54: fa port map(c14,c42,k43,k54,c54);
    fa55: fa port map(k44,c43,c54,k55,c55);
    fa56: fa port map(c44,k45,c55,k56,c56);
    fa57: fa port map(k46,c45,c56,k57,c57);
    fa58: fa port map(c46,k47,c57,k58,c58);
    fa59: fa port map(k48,c47,c58,k59,c59);
    
    ha70: ha port map(c51,k52,k60,c60);
    fa70: fa port map(c52,k53,c60,k61,c61);
    fa71: fa port map(c53,k54,c61,k62,c62);
    ha71: ha port map(k55,c62,k63,c63);
    ha72: ha port map(k56,c63,k64,c64);
    ha73: ha port map(k57,c64,k65,c65);
    ha74: ha port map(k58,c65,k66,c66);
    ha75: ha port map(k59,c66,k67,c67);
    fa81: fa port map(c48,c59,c67,k68,c68);
    
    
    p(0) <= s00;
    p(1) <= k01;
    p(2) <= k22;
    p(3) <= k37;
    p(4) <= k49;
    p(5) <= k50;
    p(6) <= k51;
    p(7) <= k60;
    p(8) <= k61;
    p(9) <= k62;
    p(10) <= k63;
    p(11) <= k64;
    p(12) <= k65;
    p(13) <= k66;
    p(14) <= k67;
    p(15) <= k68 or c68;
    
end behavior;
