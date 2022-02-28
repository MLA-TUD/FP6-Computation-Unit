library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Package Declaration Section
package array_vector_package is
 
  constant size : integer := 7;
  
  type std_1d_vector_array is array(0 to size) of std_logic_vector(7 downto 0);
  type std_2d_vector_array is array(0 to size, 0 to size) of std_logic_vector(7 downto 0);
  type std_2d_vector_array_length9 is array(0 to size+1, 0 to size+1) of std_logic_vector(7 downto 0);
 
 function getVectored (i_vector : in std_1d_vector_array) -- you just got vectored!!1!
    return std_logic_vector;
    
 function getVectored2D (i_vector : in std_2d_vector_array) -- you just got vectored!!1!
    return std_logic_vector;
   
   
end package array_vector_package;
 
-- Package Body Section
package body array_vector_package is

    function getVectored (i_vector : in std_1d_vector_array)
    return std_logic_vector is 
  begin
    return i_vector(0);
  end;
  
  function getVectored2D (i_vector : in std_2d_vector_array)
    return std_logic_vector is 
  begin
    return i_vector(0, 1);
  end;
 
end package body array_vector_package;
