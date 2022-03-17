library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Package Declaration Section
package array_vector_package is
 
  constant bit_size : integer := 8;
  constant array_size : integer := 8;
  
  type std_1d_vector_array is array(natural range <>) of std_logic_vector(bit_size-1 downto 0); 
  type std_2d_vector_array is array(natural range <>, natural range <>) of std_logic_vector(bit_size-1 downto 0);
 
 function getVectored (i_vector : in std_1d_vector_array) -- you just got vectored!!1!
    return std_logic_vector;
    
 function getVectored2D (i_vector : in std_2d_vector_array; i : in integer; j : in integer) -- you just got vectored!!1!
    return std_logic_vector;
   
   
end package array_vector_package;
 
-- Package Body Section
package body array_vector_package is

    function getVectored (i_vector : in std_1d_vector_array)
    return std_logic_vector is 
  begin
    return i_vector(0);
  end;
  
  function getVectored2D (i_vector : in std_2d_vector_array; i : in integer; j : in integer)
    return std_logic_vector is
  begin
    return i_vector(i, j);
  end;
 
end package body array_vector_package;
