import 'package:flutter/material.dart'; //importa o pacote do flutter, com todos os widgets de interface como o TextField, ElevatedButton e etc...

class Tela1 extends StatelessWidget { //criei uma nova tela (chamada Tela1). Ela é Stateless, ou seja, ela não muda. 
  const Tela1({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController(); //Cria um controlador que vai guardar o que a pessoa digita no campo de e-mail. O TextEdi... Serve para você acessar o texto depois (quando clicar no botão, por exemplo).
    final senhaController = TextEditingController(); //mesma coisa, só muda a senha

    return Scaffold( //O Scaffold é a estrutura da base da tela. Ele dá suporte a coisas como AppBar, corpo da tela, etc.
      appBar: AppBar(title: const Text('Login')), //Aqui está adicionando uma barra superior com o título "Login".
      body: Padding( //O conteúdo da tela vai dentro do body
        padding: const EdgeInsets.all(16), //adiciona espaçamento interno, pra não deixar os campos colados nas bordas
        child: Column( //Organiza os widgets um embaixo do outro (Em coluna).
          mainAxisAlignment: MainAxisAlignment.center, //centraliza tudo verticalmente
          children: [
            TextField( //É o campo onde a pessoa digita algo
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Gmail'), //O primeiro TextField é o Gmail.
            ),
            const SizedBox(height: 12),
            TextField(
              controller: senhaController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Senha'), //O segundo TextField é o da Senha.
            ),
            const SizedBox(height: 20),
            ElevatedButton( //
              onPressed: () {
                final email = emailController.text;
                final senha = senhaController.text;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Email: $email | Senha: $senha')), //faz aparecer uma linha temporária na parte de baixo da tela. exemplo : "laiza@gmail2729". a mensagem é o gmail e senha que você digitou.
                );
              },
              child: const Text('Cadastrar'), //Botão Cadastrar
            ),
          ],
        ),
      ),
    );
  }
}
