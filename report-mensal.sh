#!/bin/bash

cd /tmp
#Versao 1.0 - Dezembro/2018 (criacao do script e de suas funcionalidades) - Gabriel Barban Rocha GRC#
#Versao 1.1 - Dezembro/2018 (Melhorias: script completo rodando a cada 10 dias; dados sendo armazenados tbm em um txt dentro do servidor) - Gabriel Barban Rocha GRC#
#Versao 1.2 - Dezembro/2018 (Melhorias: ultimos acessos no servidor, melhoria no layout das tabelas, rodape da iteris) - Gabriel Barban Rocha GRC#
echo "### RELATORIO COMPLETO SERVIDOR ###" >> report.txt
echo "GRC - gabriel.rocha@iteris.com.br" >> report.txt
echo "Extraído em: $(/bin/date +%d-%m-%Y) $(/bin/date +%H-%M-%S)" >> report.txt
echo " " >> report.txt
echo " " >> report.txt
echo " " >> report.txt

echo "- Armazenamento dos discos" >> report.txt
df -h >> report.txt
echo " " >> report.txt
echo " " >> report.txt

echo "- Teste de Conexão" >> report.txt
ping 8.8.8.8 -c5 >> report.txt
echo " " >> report.txt
echo " " >> report.txt

echo "- Informações de REDE" >> report.txt
ifconfig >> report.txt
echo " " >> report.txt
echo " " >> report.txt

echo "- Tamanho da aplicacao" >> report.txt
du -sh /var/www/recovery-multi/ >> report.txt
echo " " >> report.txt
echo " " >> report.txt

echo "- Tamanho da base de dados" >> report.txt
mysqldump -uroot -p'recovery9090' recovery_multi > /tmp/dump_recovery.sql
du -sh /tmp/dump_recovery.sql >> report.txt
echo " " >> report.txt
echo " " >> report.txt
rm /tmp/dump_recovery.sql

echo "- Memoria RAM utilizada" >> report.txt
free -m -t >> report.txt
echo " " >> report.txt
echo " " >> report.txt

echo "- Principais processos ativos" >> report.txt
ps -eo user,pid,%mem,%cpu,command >> report.txt
echo " " >> report.txt
echo " " >> report.txt

echo "- Ultimos acessos do servidor" >> report.txt
echo "usuario   long          ip origem            data                         tempo" >> report.txt
last >> report.txt
echo " " >> report.txt
echo " " >> report.txt
echo " " >> report.txt

echo "Iteris Consultoria e Software LTDA" >> report.txt
echo "### FIM DO RELATORIO ###" >> report.txt
echo " " >> report.txt

cat /tmp/report.txt | mail -s "Relatorio completo Servidor Recovery - $(/bin/date +%d-%m-%Y)" gabriel.rocha@iteris.com.br,sergio.gomes@iteris.com.br,adenilson.santos@iteris.com.br,gabriel.chantre@iteris.com.br,leonard.albert@iteris.com.br,catarina.bernardino@iteris.com.br,marcella.sotto@iteris.com.br,guilherme.moura@iteris.com.br
cp /tmp/report.txt /home/ubuntu/reports/report_"$(/bin/date +%d-%m-%Y)".txt
rm /tmp/report.txt
