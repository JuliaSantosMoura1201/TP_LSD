library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

entity contador_tb is
end contador_tb;

architecture teste of contador_tb is

	component contador is
		port(
			clk, reset, load: in std_logic;
			saida: out integer range 0 to 15
		);
	end component;
	
	signal CLK, RESET, LOAD: std_logic;
	signal SAIDA: integer range 0 to 15;

	begin
	
		instancia_contador: contador port map(clk => CLK, reset => RESET, load => LOAD, saida => SAIDA);
		
		CLK <= '0', '1' after 10 ns, '0' after 20 ns, '1' after 30 ns, '0' after 40 ns, '1' after 50 ns, '0' after 60 ns, '1' after 70 ns, '0' after 80 ns, '1' after 90 ns, '0' after 100 ns, '1' after 110 ns, '0' after 120 ns, '1' after 130 ns, '0' after 140 ns, '1' after 150 ns, '0' after 160 ns, '1' after 170 ns, '0' after 180 ns, '1' after 190 ns, '0' after 200 ns;
		LOAD <= '0', '1' after 50 ns;
		RESET <= '0', '1' after 150 ns;

end teste;