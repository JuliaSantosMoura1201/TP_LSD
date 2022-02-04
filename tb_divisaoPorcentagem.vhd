library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity tb_divisaoPorcentagem is
end tb_divisaoPorcentagem;

architecture teste of tb_divisaoPorcentagem is

component divisaoPorcentagem is
port
  (
    velocidade: in std_logic_vector(15 downto 0);
    velocidadeSetada: in std_logic_vector(15 downto 0);
    porcentagem : out std_logic_vector (15 downto 0)
  );
end component;

signal DIVISOR, DIVIDENDO: std_logic_vector (15 downto 0);
signal PORCENTAGEM: std_logic_vector (15 downto 0);
begin
instancia_divisaoPorcentagem: divisaoPorcentagem port map(velocidade=>DIVISOR, velocidadeSetada=>DIVIDENDO, porcentagem=>PORCENTAGEM);
DIVISOR <= x"0000", x"000A" after 9ns, x"0008" after 19ns;

DIVIDENDO <= x"0000", x"0005" after 9ns, x"0005" after 19ns;

end teste;