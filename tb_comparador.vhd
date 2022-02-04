library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.ALL;

entity tb_comparador is 
end tb_comparador;

architecture teste of tb_comparador is

component COMPARADOR is 
port (
				PORCENTAGEM_VELOCIDADE : in std_logic_vector (15 downto 0);
				PORCENTAGEM: in std_logic_vector(15 downto 0);
				MENOR_IGUAL: out std_logic );
end component;

signal porcentagem_velocidade, porcentagem: std_logic_vector(15 downto 0);
signal menor_igual: std_logic;

begin INSTANCIA_COMPARADOR: COMPARADOR port map (PORCENTAGEM_VELOCIDADE => porcentagem_velocidade, PORCENTAGEM => porcentagem, MENOR_IGUAL => menor_igual);
	porcentagem_velocidade <=  x"0000", x"00C8" after 25ns, x"0080" after 75ns, x"00C7" after 100ns ;
	porcentagem <= x"0000", x"006E" after 25ns, x"0082" after 50ns ;
	
end teste;
 

