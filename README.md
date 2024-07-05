
# Jobs

Desafio técnico para empresa Landtech, visando a criação de um job board!


#### Requisitos

- [ruby-3.1.4](https://www.ruby-lang.org/en/news/2022/04/12/ruby-2-7-6-released/)
- [postgresql](https://www.postgresql.org/download/)
- [Docker 25.0.1](https://docs.docker.com/engine/release-notes/25.0/)
- [Redis](https://redis.io/)

### Executando o projeto:

Antes de rodar os comandos abaixo, é necessario duplicar o .env.development.
E alterar o nome para: .env

```ruby
bundle install
rails db:migrate
rails db:seed
bundle install
rails server
```

### Alternativa utilizando docker:
Foi configurado um Makefile com os alias para facilitar o setup, só rodar no terminal os comandos listados abaixo na ordem declarada.

```docker
make setup
make start
```
Depois só acessar localhost:3000
OBS: caso tenha problemas com o DB, é só alterar o .env.development
trocar
PG_HOST para: localhost

### Rodando testes:
só rodar o comando, e o mesmo já vai executar todos os testes.
```ruby
rspec
```
### Rodando testes com docker:
```
docker compose run --rm jobs rspec
```

### Collection do postman para executar as chamadas da API:

- [Landtech Postman collection](https://lunar-zodiac-31726.postman.co/workspace/New-Team-Workspace~75db2381-4eca-4296-a26b-25992cbd1047/folder/1813371-ea0acb72-f2d8-493a-ac1b-cdaff20a0f29?ctx=documentation)
