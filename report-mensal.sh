#!/bin/bash

cd /tmp
#Versao 1.0 - Dezembro/2018 (criacao do script e de suas funcionalidades) - Gabriel Barban Rocha#
#Versao 1.1 - Dezembro/2018 (Melhorias: script completo rodando a cada 10 dias; dados sendo armazenados tbm em um txt dentro do servidor) - Gabriel Barban Rocha#
#Versao 1.2 - Dezembro/2018 (Melhorias: ultimos acessos no servidor, melhoria no layout das tabelas, rodape da iteris) - Gabriel Barban Rocha#
#Versao 2.0 - Dezembro/2018 (Melhorias: Pegando todos os dados do usuario e deixando o script utilizavel em qualquer servidor e permitindo seu uso por usuarios que nao entendam shell script)
#Informe abaixo as informacoes antes de gerar o script
TAMANHO_APLICACAO=''
TAMANHO_BD=''


echo "Informe o nome do servidor: "
read NOME_SERVIDOR
echo "Informe o nome da Instituicao em que trabalha: "
read EMPRESA


echo "### RELATORIO COMPLETO SERVIDOR ###" >> report.txt
echo "Desenvolvido por: Gabriel Barban Rocha - barbangabriel@gmail.com" >> report.txt
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

echo "Relatorio deve informar o tamanho da aplicacao? (1-sim/2-nao) "
read opcao1
    case $opcao1 in
        "1")
            echo "Informe o diretorio completo da aplicacao (exemplo: /var/www/meuapp): "
            read DIRETORIO_APLICACAO
            echo "- Tamanho da aplicacao" >> report.txt
	    du -sh $DIRETORIO_APLICACAO >> report.txt
            echo " " >> report.txt
            echo " " >> report.txt
	    break
            ;;
        "2")
            break
            ;;
        *) echo invalid option;;
    esac

echo "Relatorio deve informar o tamanho da base de dados? (1-sim/2-nao) "
read opcao2
    case $opcao2 in
        "1")
            echo "Informe o host da base de dados (exemplo: localhost): "
            read host;
            echo "Informe o nome da base de dados: "
            read bd;
            echo "Informe o usuario do banco de dados (exemplo: root): "
            read usuario;
            echo "Informe a senha do banco de dados: "
            read senha;
            mysqldump -u$usuario -p$senha -h$host $bd > /tmp/dump_$bd.sql
            echo "- Tamanho da base de dados" >> report.txt
            du -sh /tmp/dump_$bd.sql >> report.txt
            echo " " >> report.txt
            echo " " >> report.txt
	    rm /tmp/dump_$bd.sql
            break
            ;;
        "2")
            break
            ;;
        *) echo invalid option;;
    esac



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

#cat /tmp/report.txt | mail -s "Relatorio completo Servidor Recovery - $(/bin/date +%d-%m-%Y)" gabriel.rocha@iteris.com.br,sergio.gomes@iteris.com.br,adenilson.santos@iteris.com.br,gabriel.chantre@iteris.com.br,leonard.albert@iteris.com.br,catarina.bernardino@iteris.com.br,marcella.sotto@iteris.com.br,guilherme.moura@iteris.com.br
#cp /tmp/report.txt /home/ubuntu/reports/report_"$(/bin/date +%d-%m-%Y)".txt
