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
RESULTSERVERHTTP=$(echo | curl -s -I $WEBSITEHTTP --connect-timeout 2 | grep -e "Server: ")
RESULTSERVERHTTPS=$(echo | curl -s -I $WEBSITEHTTPS --connect-timeout 2| grep -e "Server: ")
#Resultados apresentados em tela e salvos em uma lista BANNER-LIST.txt
if [ -z "$RESULTSERVERHTTP" ];
then
        false
else
        echo " Resultado de acesso em Http  $RESULTSERVERHTTP "
        echo $WEBSITEHTTP "-" $RESULTSERVERHTTP >> BANNER-LIST.txt
fi
if [ -z "$RESULTSERVERHTTPS" ];
then
        false
else
        echo " Resultado de acesso em Https $RESULTSERVERHTTPS"
        echo $WEBSITEHTTPS "-" $RESULTSERVERHTTP >> BANNER-LIST.txt
fi
echo ""
done <"$input"
