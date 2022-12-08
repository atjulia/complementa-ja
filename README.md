# Complementa já!
Aplicativo para gestão de horas complementares dos alunos do Centro Universitário Católica de Santa Catarina
<br>
<br>
📄 Quadro do projeto: https://github.com/users/Tekislla/projects/1
<br>
<br>
🧠 Repositório backend https://github.com/Tekislla/complementa-ja
<br>
<br>
**⚠ DESCRIÇÃO ⚠**
<br>
<br>
1️⃣ Requisitos:

    👉🏻 Android Studio
  
    👉🏻 Flutter
  
    👉🏻 Postman (para acessar os endpoints)
    
    👉🏻 Um dispositivo virtual Android para emular a aplicação (NÃO FUNCIONA RODANDO PELO CHROME, POR CONTA DA BIBLIOTECA DART.IO)
<br>
2️⃣ Instruções:
<br>
<br>

    👉🏻 Clonar o repositório
    
    👉🏻 Iniciar o dispositivo virtual
    
    👉🏻 Rodar a aplicação
    
    👉🏻 Realizar login com uma das credenciais abaixo:
    
      👉🏻 (ID = 1) joao.souza00@catolicasc.edu.br / joaopedro 
      
      👉🏻 (ID = 2) julia.atanazio@catolicasc.edu.br / juliakarolina 
      
      👉🏻 (ID = 3) luana.petters@catolicasc.edu.br / luanapetters
      
      👉🏻 (ID = 4) eduardo.schelbauer@catolicasc.edu.br / eduardoschelbauer 
<br>
3️⃣ Endpoints
<br>
<br>

    👉🏻 Ao enviar um documento, verificar no banco de dados o envio do documento, via postman:
    
      👉🏻 https://complementa-ja.herokuapp.com/complementaja/usuario/{{usuarioId}}
      ✍🏻 Esta é o endpoint de busca do aluno por ID
      
    👉🏻 Para realizar o aceite do documento:
    
      👉🏻 https://complementa-ja.herokuapp.com/complementaja/documento/aceitar/{{usuarioId}}/{{documentoId}}
      
    👉🏻 Para recusar o documento:
    
      👉🏻 https://complementa-ja.herokuapp.com/complementaja/documento/recusar/{{usuarioId}}/{{documentoId}}
    
    👉🏻 Para visualizar os documentos pendentes de aprovação/reprovação:
    
      👉🏻 https://complementa-ja.herokuapp.com/complementaja/documento/pendentes/{{usuarioId}}
    
    👉🏻 Para visualizar os documentos aprovados:
    
      👉🏻 https://complementa-ja.herokuapp.com/complementaja/documento/aceitos/{{usuarioId}}
    
    👉🏻 Para visualizar os documentos recusados:
    
      👉🏻 https://complementa-ja.herokuapp.com/complementaja/documento/recusados/{{usuarioId}}
      
    👉🏻 Para fazer o download de um documento:
    
      👉🏻 https://complementa-ja.herokuapp.com/complementaja/documento/download/{{documentoId}}
      ✍🏻 Este endpoint só funciona pelo navegador, pelo postman ele não faz o download
<br>
4️⃣ Tecnologias utilizadas:
<br>
<br>

    👉🏻 Flutter/Dart para a aplicação
    
    👉🏻 Java/Spring Boot para o backend/API
    
    👉🏻 PostgreSQL para o banco de dados
    
    👉🏻 Github para o controle do desenvolvimento
    
    👉🏻 Postman para o teste das APIs
    
    👉🏻 Heroku para hospedar o banco de dados e fazer deploy da API
<br>
5️⃣ O que faltou (não deu tempo de fazer...):
<br>
<br>    

    👉🏻 Central do administrador para aceitar/recusar os documentos
<br>
⚠ Qualquer dúvida, entrar em contato conosco
<br>
<br>
<br>
<br>
<br>
<p align="right">Equipe Devbar✍🏻</p>
