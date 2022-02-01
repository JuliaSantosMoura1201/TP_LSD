library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity divisaoPorcentagem is

    port
    (
    velocidade: in std_logic_vector(15 downto 0);
    velocidadeSetada: in std_logic_vector(15 downto 0);
    porcentagem : out std_logic_vector (15 downto 0)
    );

end entity;

architecture rtl of divisaoPorcentagem is
signal resultado : std_logic_vector (31 downto 0);
begin
resultado <= std_logic_vector(unsigned(velocidade)*100/ unsigned(std_logic_vector(velocidadeSetada)));
porcentagem <= std_logic_vector(resize(unsigned(resultado), porcentagem'length));
end rtl;