#!/bin/bash

#Versao 1.0 - Dezembro/2018 (criacao do script e de suas funcionalidades nativas) - Gabriel Barban Rocha#
#Versao 1.1 - Dezembro/2018 (Melhorias: script completo rodando a cada 10 dias; dados sendo armazenados tbm em um txt dentro do servidor) - Gabriel Barban Rocha#
#Versao 1.2 - Dezembro/2018 (Melhorias: ultimos acessos no servidor, melhoria no layout das tabelas, rodape) - Gabriel Barban Rocha#
#Versao 2.0 - Dezembro/2018 (Melhorias: Pegando todos os dados do usuario e deixando o script utilizavel em qualquer servidor e permitindo seu uso por usuarios que nao entendam shell script)  - Gabriel Barban Rocha#
#Versao 2.1 - Dezembro/2018 (Melhorias: verificacao do arquivo /var/log/wtmp, mais informacoes para o usuario, fim mais enxuto) - Gabriel Barban Rocha#
#Versao 2.2 - Abril/2019 (Melhorias: mais informações sobre os discos montados, adição de informações sobre a versao, distribuição, etc)

echo "Report Linux 2.2"
echo " "
echo " "
echo " "
read -p "Qual seu nome? " usuario
echo " "
echo " "
echo " "
echo "(Caso escolha SIM, lembre-se que deve estar como SUDO)"
read -p "Deseja verificar as dependencias? (1-Sim/2-Não): " opcaod

case $opcaod in
        "1")
            echo "Instalando..."
	    apt-get update
            apt-get -y install mailutils

	    echo "Verificando se o arquivo /var/log/wtmp existe..."
	    FILE=/var/log/wtmp
	    if [ -e $FILE ]
            then
		echo "Ok, existe!"
	    else
		touch /var/log/wtmp
		chmod 777 /var/log/wtmp
		echo "Arquivo criado!"
	    fi
            break
            ;;
        "2")
	    echo "Sem verificacao..."
            break
            ;;
        *) echo invalid option;;
esac


#Informe abaixo as informacoes antes de gerar o script
cd /tmp
echo " "
read -p "Informe o nome do servidor: " NOME_SERVIDOR
read -p "Informe o nome da Instituicao em que trabalha: " EMPRESA
read -p "Informe o email para onde o relatorio deve ser enviado (separando por virgula se for mais de um): " emails

echo "### RELATORIO COMPLETO SERVIDOR ###" >> report.txt
echo "Desenvolvido por: Gabriel Barban Rocha - barbangabriel@gmail.com" >> report.txt
echo "Extraído por: $usuario, em $(/bin/date +%d-%m-%Y) $(/bin/date +%H-%M-%S)" >> report.txt
echo " " >> report.txt
echo " " >> report.txt
echo " " >> report.txt

echo "- Versao SO" >> report.txt
cat /etc/*-release >> report.txt
echo " " >> report.txt
echo " " >> report.txt

echo "- Armazenamento dos discos" >> report.txt
df -h -a >> report.txt
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

read -p "Relatorio deve informar o tamanho da aplicacao? (1-sim/2-nao): " opcao1
    case $opcao1 in
        "1")
            read -p "Informe o diretorio completo da aplicacao (exemplo: /var/www/meuapp): " DIRETORIO_APLICACAO
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

read -p "Relatorio deve informar o tamanho da base de dados? (1-sim/2-nao) " opcao2
    case $opcao2 in
        "1")
            read -p "Informe o host da base de dados (exemplo: localhost): " host
            read -p "Informe o nome da base de dados: " bd
            read -p "Informe o usuario do banco de dados (exemplo: root): " usuario
            read -p "Informe a senha do banco de dados: " senha
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

echo $EMPRESA >> report.txt
echo "### FIM DO RELATORIO ###" >> report.txt
echo " " >> report.txt

cat /tmp/report.txt | mail -s "Relatorio completo Servidor $NOME_SERVIDOR - $(/bin/date +%d-%m-%Y)" $emails
#rm /tmp/report.txt

echo " "
echo " "
echo "Relatório enviado para: $emails"
echo " "
echo "
########################
## _____              ##
## |     | |\      /| ##
## |     | | \    / | ##
## |---- | |  \  /  | ##
## |     | |   \/   | ##
## |     | |        | ##
##                    ##
########################
     "
echo " "
echo " "
echo " "
echo " -------------------------------------------------- "
echo "Desenvolvido por: Gabriel Barban Rocha - barbangabriel@gmail.com"
echo " "
