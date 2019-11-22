# dsl-parser

Trabalho da matéria MATA77 - Programação Funcional do Departamento de Ciência da Computação do Instituto de Matemática e Estatistica da Universidade Federal da Bahia, ministrada pelo professor Manoel Mendonça.

## Parte 1

Criar o RBF (Readable BF), seguindo essas duas etapas:
1. Legibilizar a linguagem BF: 
    * Trocar ```>``` por ```fwd```
    * Trocar ```<``` por ```rwd```
    * Trocar ```+``` por ```inc```
    * Trocar ```-``` por ```dec```
    * Trocar ```[``` por ```begin```
    * Trocar ```]``` por ```end```
    * Trocar ```,``` por ```read```
    * Trocar ```.``` por ```write```
2. Adicionar os comandos a seguir:
    * ```inc N```, onde a posição atual será acrescida ```N``` bytes.
    * ```dec N```, onde a posição atual será decrescida ```N``` bytes.
    * ```fwd N```, onde o apontador será avançado ```N``` vezes na fita.
    * ```rwd N```, onde o apontador será recuado ```N``` vezes na fita.
    
> É necessária a reescrita de alguns programas em BF, em RBF
