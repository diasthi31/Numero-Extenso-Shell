#!/bin/bash

function converterNumero {
    unidades=("zero" "um" "dois" "três" "quatro" "cinco" "seis" "sete" "oito" "nove")
    decimais=("dez" "onze" "doze" "treze" "quatorze" "quinze" "dezesseis" "dezessete" "dezoito" "dezenove")
    dezenas=("vinte" "trinta" "quarenta" "cinquenta" "sessenta" "setenta" "oitenta" "noventa")
    centenas=("cento" "duzentos" "trezentos" "quatrocentos" "quinhentos" "seiscentos" "setecentos" "oitocentos" "novecentos")

    numero=$1
  
    if [ -f "$1" ]; then
        numero=`cat $1`
    fi

    if (( numero == 0 )); then
        extenso="zero"
    elif (( numero == 100 )); then
        extenso="cem"
    elif (( numero < 10 )); then
        extenso=${unidades[numero]}
    elif (( numero < 20 )); then
        extenso=${decimais[numero-10]}
    elif (( numero < 100 )); then
        dezena=$(( numero / 10 ))
        unidade=$(( numero % 10 ))
        extenso=${dezenas[dezena-2]}
        if (( unidade > 0 )); then
            extenso+=" e ${unidades[unidade]}"
        fi
    elif (( numero < 1000 )); then
        centena=$(( numero / 100 ))
        resto=$(( numero % 100 ))
        extenso=${centenas[centena-1]}
        if (( resto > 0 )); then
            extenso+=" e $(converterNumero $resto)"
        fi
    else
        extenso="Número inválido."
    fi

    echo $extenso
}

echo -n "Digite um número[0-999] ou arquivo[.txt] para converter [ou "sair" para sair]: "
read entrada

while [ $entrada != 'sair' ]
do
if [ -f "$entrada" ]; then
    extenso=$(converterNumero $entrada)
    echo "O número no arquivo [$entrada] por extenso é: $extenso"
else
    extenso=$(converterNumero $entrada)
    echo "O número [$entrada] por extenso é: $extenso"
fi

echo

echo -n "Digite um número[0-999] ou arquivo[.txt] para converter [ou "sair" para sair]: "
read entrada

done