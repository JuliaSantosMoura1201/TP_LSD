library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;


entity contador is

port(
		clock, rst, load: in std_logic;
		saida: out std_logic
);

end entity;

architecture comportamental of contador is
	signal saida_tempo: integer range 0 to 15;

	begin
		process (clock, rst) is
			begin
				if(rst = '1') then
					saida_tempo <= 0;
				elsif(rising_edge(clock)) then
					if(load = '1') then
						saida_tempo <= saida_tempo + 1;
						if(saida_tempo = 14) then
							saida <= '1';
							saida_tempo <= 0;
						else
							saida <= '0';
						end if;
					else
						saida <= '0';
						saida_tempo <= 0;
					end if;
			 end if;
		end process;
end comportamental;