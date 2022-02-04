library ieee;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;
use ieee.numeric_bit.rising_edge;

entity calculadoraDeMulta is
port(
	 tempo_a: in std_logic_vector(15 downto 0);
    tempo_b: in std_logic_vector(15 downto 0);
    velocidade_permitida : in std_logic_vector(15 downto 0);
	 bit_a: in std_logic;
	 bit_b: in std_logic;
	 bit_v: in std_logic;
	 clk: in std_logic;
	 clr: in std_logic;
	 velocidade : out std_logic_vector(15 downto 0);
    multa : out std_logic_vector(31 downto 0);
	 led_verde: out std_logic;
	 led_vermelho: out std_logic;
	 led_amarelo: out std_logic
	 );
end entity;
architecture arch of calculadoraDeMulta is

signal sC_01, sC_03, sReset: std_logic;
signal sSr_a, sSr_b, sSr_v, sSr_vc, sSr_m, sSet_mux, sSet_count, sClear: std_logic;
component controladora is
port(
	bit_a: in std_logic;
	bit_b: in std_logic;
	bit_v: in std_logic;
	clk: in std_logic;
	clr: in std_logic;
	led_verde: out std_logic;
	led_vermelho: out std_logic;
	led_amarelo: out std_logic;
	
	-- Sinais do/para o caminho de dados
	
	c_01: in std_logic;
	c_03: in std_logic;
	reset: in std_logic;
	sr_a: out std_logic;
	sr_b: out std_logic;
	sr_v: out std_logic;
	sr_vc: out std_logic;
	sr_m: out std_logic;
	set_mux: out std_logic;
	set_count: out std_logic;
	clear: out std_logic
);
end component;

component CAMINHO_DE_DADOS is
    port ( 
		tempo_a: in std_logic_vector(15 downto 0);
	   tempo_b: in std_logic_vector(15 downto 0);
	   clk: in std_logic;
	   velocidade_permitida : in std_logic_vector(15 downto 0);
	   velocidade : out std_logic_vector(15 downto 0);
	   multa : out std_logic_vector(31 downto 0);
	  
	   -- Sinais da/para controladora
	   sr_a: in std_logic;
	   sr_b: in std_logic;
	   sr_v: in std_logic;
	   sr_vc: in std_logic;
	   sr_m: in std_logic;
	   set_mux: in std_logic;
	   set_count: in std_logic;
	   c_01: out std_logic;
	   c_03: out std_logic;
	   clear: in std_logic;
	   reset: out std_logic
    );
end component;

begin
a1: controladora port map(
	bit_a => bit_a,
	bit_b => bit_b,
	bit_v => bit_v,
	clk => clk,
	clr => clr,
	led_verde => led_verde,
	led_vermelho => led_vermelho,
	led_amarelo => led_amarelo,
	
	-- Sinais do/para o caminho de dados
	
	c_01 => sC_01,
	c_03 => sC_03,
	reset => sReset,
	sr_a => sSr_a,
	sr_b => sSr_b,
	sr_v => sSr_v,
	sr_vc => sSr_vc,
	sr_m => sSr_m,
	set_mux => sSet_mux,
	set_count => sSet_count,
	clear =>sClear
);

a2: CAMINHO_DE_DADOS port map ( 

	tempo_a => tempo_a,
   tempo_b => tempo_b,
   clk => clk,
   velocidade_permitida => velocidade_permitida,
   velocidade => velocidade,
   multa => multa,
	
   -- Sinais da/para controladora
   sr_a => sSr_a,
   sr_b => sSr_b,
   sr_v => sSr_v,
   sr_vc => sSr_vc,
   sr_m => sSr_m,
   set_mux => sSet_mux,
   set_count => sSet_count,
   c_01 => sC_01,
   c_03 => sC_03,
   clear => sClear,
   reset => sReset
);
end architecture;