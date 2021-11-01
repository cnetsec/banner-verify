#!/bin/bash
#Carregado a Lista de dominios
input="insert-domains-here"
NOW="$(date)"
echo ""
echo ""
echo "---------------Verificação Iniciada $NOW-----------------"
#Analise linha por linha para identficar os banners
while IFS= read -r line
do
echo "[RESULTADOS $line]"
WEBSITEHTTP=$(echo "http://$line")
WEBSITEHTTPS=$(echo "https://$line")
RESULTHTTP_SERVER=$(echo | curl -s -I $WEBSITEHTTP --connect-timeout 2 | grep -e "Server: ")
RESULTHTTPS_SERVER=$(echo | curl -s -I $WEBSITEHTTPS --connect-timeout 2| grep -e "Server: ")
RESULTSHTTP_XPOWEREDBY=$(echo | curl -s -I $WEBSITEHTTP --connect-timeout 2 | grep -e "X-Powered-By: ")
RESULTHTTPS_XPOWEREDBY=$(echo | curl -s -I $WEBSITEHTTPS --connect-timeout 2| grep -e "X-Powered-By: ")
#Resultados apresentados em tela e salvos em uma lista BANNER-LIST.txt
if [ -z "$RESULTHTTP_SERVER" ];
then
        false
else
        echo " Resultado de acesso em Http  $RESULTHTTP_SERVER "
        echo $WEBSITEHTTP "-" $RESULTHTTP_SERVER >> BANNER-LIST.txt
fi
if [ -z "$RESULTHTTPS_SERVER" ];
then
        false
else
        echo " Resultado de acesso em Https $RESULTHTTPS_SERVER"
        echo $WEBSITEHTTPS "-" $RESULTHTTPS_SERVER >> BANNER-LIST.txt
fi
if [ -z "$RESULTSHTTP_XPOWEREDBY" ];
then
        false
else
        echo " Resultado de acesso em Http  $RESULTSHTTP_XPOWEREDBY "
        echo $WEBSITEHTTP "-" $RESULTSHTTP_XPOWEREDBY >> BANNER-LIST.txt
fi
if [ -z "$RESULTHTTPS_XPOWEREDBY" ];
then
        false
else
        echo " Resultado de acesso em Https $RESULTHTTPS_XPOWEREDBY"
        echo $WEBSITEHTTPS "-" RESULTHTTPS_XPOWEREDBY >> BANNER-LIST.txt
fi
echo ""
done <"$input"
