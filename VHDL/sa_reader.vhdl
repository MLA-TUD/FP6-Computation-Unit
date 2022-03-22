library work;
use work.array_vector_package.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sa_reader is
	generic (
		systolicArraySize:integer := 8;	-- for setting the size of the calculation matrix
		bitSize:integer := 8;			-- fixed to 8 for this project
		counterSize : integer := 8		-- how large is the matrix that was calculated
	);    
	port (
		readMatrixToFifo : in std_logic;															-- control signal if this devics should work (='1')
		readMatrix : in std_2d_vector_array(0 to systolicArraySize-1, 0 to systolicArraySize-1);	-- 2D data input (of: std_logic_vector(bitSize-1 downto 0) )
		wFullFIFO : in std_logic;
		wDataToFIFO : out std_logic_vector(bitSize-1 downto 0);
		wClkFIFO, wIncFIFO, wRstFIFO : out std_logic;
		finished : out std_logic	-- reqired: "readMatrixToFifo <= '1'; wait until finished = '1'; readMatrixToFifo <= '0';"
	);
end sa_reader;

architecture behavior of sa_reader is
	
begin
	process begin
		if readMatrixToFifo /= '1' then
			assert false report "Waiting for: readMatrixToFIFO";
			wait until readMatrixToFifo = '1';
		end if;
		
		-- initialize FIFO
		wIncFIFO <= '1';
		wait for 1 ns;
		wClkFIFO <= '0';
		wait for 1 ns;
		wRstFIFO <= '0';	-- resets on 0
		wait for 1 ns;
		wClkFIFO <= '1';	-- reset here
		wait for 1 ns;
		wRstFIFO <= '1';	-- do not reset anymore
		wait for 1 ns;
		wIncFIFO <= '1';	-- increment pointer when writing
		wait for 1 ns;
		
		-- loop through 2D Data (of: std_logic_vector(bitSize-1 downto 0) ) (in row (then column) order)
		for j in 0 to counterSize-1 loop
			for i in 0 to counterSize-1 loop
				wClkFIFO <= '0';
				wait for 1 ns;
				
				if wFullFIFO /= '0' then	-- wait for FIFO to be writeable
					assert false report "Waiting for: wFullFIFO";
					wait until wFullFIFO = '0';
				end if;
				
				wDataToFIFO <= readMatrix(i, j);	-- serialize data to FIFO
				wait for 1 ns;
				
				wClkFIFO <= '1';	-- rising clock edge for FIFO -> write data
				wait for 1 ns;
			end loop;
		end loop;
		
		finished <= '1';	-- it is required to: "readMatrixToFifo <= '1'; wait until finished = '1'; readMatrixToFifo <= '0';"
		wait for 1 ns;
		finished <= '0';
	end process;
end behavior;
