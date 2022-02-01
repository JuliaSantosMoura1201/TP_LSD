library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;


entity contador is

port(
		clk, reset, load: in std_logic;
		saida: out integer range 0 to 15
);

end entity;

architecture comportamental of contador is
	signal saida_tempo: integer range 0 to 15;

	begin
		process (clk, reset) is
			begin
				if(reset = '1') then
					saida_tempo <= 0;
				elsif(rising_edge(clk)) then
					if(load = '1') then
						saida_tempo <= saida_tempo + 1;
						saida <= saida_tempo;
					else
						saida_tempo <= 0;
					end if;
				end if;
			saida <= saida_tempo;
		end process;
end comportamental;