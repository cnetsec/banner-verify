#!/bin/bash
input="insert-domains-here"
NOW="$(date)"
echo ""
echo ""
echo "---------------Verificação Iniciada $NOW-----------------"
while IFS= read -r line
do
echo "[RESULTADOS $line]:"
WEBSITEHTTP=$(echo "http://$line")
WEBSITEHTTPS=$(echo "https://$line")
RESULTSERVERHTTP=$(echo | curl -s -I $WEBSITEHTTP --connect-timeout 2 | grep -e "Server: ")
RESULTSERVERHTTPS=$(echo | curl -s -I $WEBSITEHTTPS --connect-timeout 2| grep -e "Server: ")
if [ -z "$RESULTSERVERHTTP" ];
then
        false
else
        echo " Resultado de acesso em Http  $RESULTSERVERHTTP "
fi
if [ -z "$RESULTSERVERHTTPS" ];
then
        false
else
        echo " Resultado de acesso em Https $RESULTSERVERHTTPS"
fi
echo ""
done <"$input"
