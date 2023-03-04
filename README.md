# lumiere

Aplicativo para agendar filmes ou series e salvar dados (**Offline-first**).


# 1. Funcionalidades

1. Autenticação o mais simples possível.
2. Cadastrar vários filmes/series diferentes.
3. remover ou reagendar filmes/series adicionados.
4. Edição de usuário autenticado.
5. Configuração de dispositivo.

## 1.1 Autenticação o mais simples possível

A autenticação é necessária para efetuar a sincronização e deve ser opcional, ou seja, solicitada quando o usuário executar manualmente a sincronização.
A aplicação deve dar suporte a Autenticação “sem-senha” (**Passwordless**) enviando o token por email para fazer o acesso. 

## 1.2 Agendar vários filmes/series diferentes.

O usuário poderá agendar diversos filmes/series para variados dias podendo definir um horário.

Os status de um filmes/series é em espera ou assistido.

O usuário poderá visualizar onde assisitir o filmes/series.


## 1.4 Sincronizar dados na nuvem.

Todas as listas e seus dados serão guardados localmente no dispositivo do usuário, sendo sincronizados posteriormente na nuvem. A sincronização deve ser automática e as tentativas de sincronização em caso de falha devem ser feito em um espaçamento de minutos. Esse último ponto é importante para economizar bateria em dispositivos móveis.

## 1.5 Edição de usuário autenticado.

Caso autenticado, o usuário deveria ter a possibilidade de alterar informações como Nome, Sobrenome.

## 1.6 Configuração de dispositivo.

O app deverá ter opções de controle de tema e remoção de cache.

# 3. Arquitetura

[Geral](ARCHITECTURE.md)
