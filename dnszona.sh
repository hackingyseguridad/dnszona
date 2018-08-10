#!/bin/bash

cat << "INFO"
  _____  _   _  _____
 |  __ \| \ | |/ ____|
 | |  | |  \| | (___ _______  _ __   __ _
 | |  | | . ` |\___ \_  / _ \| '_ \ / _` |
 | |__| | |\  |____) / / (_) | | | | (_| |
 |_____/|_| \_|_____/___\___/|_| |_|\__,_|
                     hackingyseguridad.con

INFO
if [ -z "$1" ]; then
        echo
        echo "Test vulnerabilidad AXFR de trasferencia de zona DNS"
        echo "Uso: $0 <dominio.com>"
        exit 0
fi

NS="$(dig $1 ns | egrep '[[:space:]]NS[[:space:]]' | awk '{print $5}')"
echo
echo "==========================================="
echo "Servidores DNS autoritativos del dominio:" $1
echo $NS
echo "==========================================="
echo

for NSERVER in $NS
do
if dig @$NSERVER $1 axfr | grep '[[:space:]]NS[[:space:]]' > /dev/null 2>&1
                        then
                                echo $1 $NSERVER "Vulnerable a traferencia de zona DNS!"
                        else
                                echo $1 $NSERVER "No vulnerable!"
                        fi
        done
