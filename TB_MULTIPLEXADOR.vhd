library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity TB_MULTIPLEXADOR is 
end TB_MULTIPLEXADOR;

architecture test of TB_MULTIPLEXADOR is

component MULTIPLEXADOR is

port(
	 PORCENTAGEM: in std_logic_vector(15 downto 0);
	 SET_MUX: in std_logic;
	 PORCENTAGEM_FINAL: out std_logic_vector(15 downto 0)
);

end component;

signal porcentagem, porcentagem_final: std_logic_vector(15 downto 0);
signal set_mux: std_logic;

begin
	INSTANCIA_MULTIPLEXADOR: MULTIPLEXADOR port  map( PORCENTAGEM => porcentagem, SET_MUX => set_mux, PORCENTAGEM_FINAL => porcentagem_final);
	porcentagem <= x"00C8", x"006E" after 50 ns, x"0082" after 100 ns, x"0082" after 150 ns;
	set_mux <= '1', '0' after 50 ns, '1' after 100 ns, '0' after 150 ns;

end test;