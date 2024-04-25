# Consulta de CEP

Este projeto consiste em um cliente Delphi para consulta de CEP utilizando a API do ViaCEP. Ele permite consultar informações de endereços a partir de um CEP ou combinação de UF, Cidade e Endereço.

## Arquitetura e Padrões Utilizados

O projeto segue uma arquitetura modular, dividido em unidades distintas que representam camadas lógicas e funcionais:

- `CEPClient`: Contém a lógica para realizar consultas de CEP e endereço utilizando a API do ViaCEP.
- `CEPData`: Define os tipos de dados utilizados para representar as informações de CEP e endereço.
- `ICEPClient`: Define a interface que o cliente de consulta de CEP deve implementar.

Foram aplicados os seguintes padrões de design:

- **Strategy**: Utilizado para definir diferentes estratégias de formatação de resposta (JSON, XML).
- **Factory Method**: Utilizado para criar instâncias de objetos `ICEPClient` de acordo com o formato de resposta desejado.
- **Dependency Injection**: Utilizado para injetar a dependência do cliente de consulta de CEP no ponto de entrada da aplicação.

## Como Executar a Aplicação

Para executar o aplicativo de exemplo, siga estas etapas:

1. Clone o repositório para o seu ambiente local.
2. Realize a importação da estrutura da base no SGBD PostgreSQL conforme o arquivo `base.sql`.
3. Realize a instalação do componente `CEPClient`, localizado na pasta `componente`.
4. Abra o projeto no Delphi e compile.
5. Execute o projeto.
6. Utilize a interface do aplicativo para realizar consultas de CEP e endereço.

## Configuração da Aplicação com o Banco de Dados

O projeto utiliza um banco de dados PostgreSQL para armazenar os dados dos CEPs consultados. Certifique-se de configurar corretamente as informações de conexão com o banco de dados no arquivo `softplan.ini`. Veja um exemplo de configuração abaixo:

```ini
[BASE]
DriverID=PG              ; Identificador do driver do PostgreSQL
User_Name=seu_usuario    ; Nome de usuário do banco de dados
Server=127.0.0.1         ; Endereço do servidor do banco de dados
Port=5432                ; Porta de conexão do servidor do banco de dados
Password=sua_senha       ; Senha do banco de dados
Database=nome_do_banco   ; Nome do banco de dados
```
