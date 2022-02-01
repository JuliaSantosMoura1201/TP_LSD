library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity COMPARADOR is 
	port (
				PORCENTAGEM_VELOCIDADE : in signed (6 downto 0);
				PORCENTAGEM: in signed(6 downto 0);
				MENOR_IGUAL: out std_logic );
end COMPARADOR;

architecture BEHAVIOR of COMPARADOR is

begin
	MENOR_IGUAL <= '1' when ((PORCENTAGEM_VELOCIDADE < PORCENTAGEM) or ( PORCENTAGEM_VELOCIDADE = PORCENTAGEM)) else '0';
end BEHAVIOR;
	