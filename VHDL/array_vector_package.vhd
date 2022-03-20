library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package array_vector_package is
	constant bit_size : integer := 8;		-- variable size of the data (for this project fixed to 8-bits signed (2k))
	constant array_size : integer := 8;		-- variable size of the matrix (-multiplication)

	
	type std_1d_vector_array is array(natural range <>) of std_logic_vector(bit_size-1 downto 0);					-- 1 dimensional Array of signed 8-bit (2k) data
	type std_2d_vector_array is array(natural range <>, natural range <>) of std_logic_vector(bit_size-1 downto 0);		-- 2 dimensional Array of signed 8-bit (2k) data
	
	function getVectored (i_vector : in std_1d_vector_array)
		return std_logic_vector;	-- for viewing in gtkwave
	
	function getVectored2D (i_vector : in std_2d_vector_array; i : in integer; j : in integer)
		return std_logic_vector;	-- for viewing in gtkwave
end package array_vector_package;

package body array_vector_package is
	function getVectored (i_vector : in std_1d_vector_array)
		return std_logic_vector is
			begin
				return i_vector(0);		-- for viewing in gtkwave (reducing dimensions)
			end;
	
	function getVectored2D (i_vector : in std_2d_vector_array; i : in integer; j : in integer)
		return std_logic_vector is
			begin
				return i_vector(i, j);	-- for viewing in gtkwave (reducing dimensions)
			end;
end package body array_vector_package;
