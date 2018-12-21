REPORT LINUX 2.1


### Codigo feito em shell script para gerar um report com informacoes sobre o servidor. ###
### Importante: alem de algumas dependencias que eventualmente deverao ser instaladas no Ubuntu, para envio de emails e obrigatoria a ###
### instalacao do postfix  e mailutils. ###
### Alem disso o banco de dados compativel com o relatorio e o MySQL ###

### -------------------------- ###

#Versao 1.0 - Dezembro/2018 (criacao do script e de suas funcionalidades) - Gabriel Barban Rocha#
#Versao 1.1 - Dezembro/2018 (Melhorias: script completo rodando a cada 10 dias; dados sendo armazenados tbm em um txt dentro do servidor) - Gabriel Barban Rocha#
#Versao 1.2 - Dezembro/2018 (Melhorias: informacao mostrando os ultimos acessos no servidor, inclusao de nome nas colunas, inclusao do rodape da iteris) - Gabriel Barban Rocha#
#Versao 2.0 - Dezembro/2018 (Melhorias: Pegando todos os dados do usuario e deixando o script utilizavel em qualquer servidor e permitindo seu uso por usuarios que nao entendam shell script)
#Versao 2.1 - Dezembro/2018 (Melhorias: verificacao do arquivo /var/log/wtmp, mais informacoes para o usuario, fim mais enxuto) - Gabriel Barban Rocha#
