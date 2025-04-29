import 'package:flutter/material.dart';

void main() => runApp(MyApp()); //inicio do código

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) { //builder para a AppBar
    return MaterialApp(
      title: 'Gerenciador de Tarefas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: TextTheme(
          bodyLarge: TextStyle(fontFamily: 'Roboto', fontSize: 16),
          bodyMedium: TextStyle(fontFamily: 'Roboto', fontSize: 14),
        ),
        scaffoldBackgroundColor: Colors.grey[100], // Deixa o fundo mais suave
      ),
      home: TaskScreen(),
    );
  }
}

class TeladeTarefas extends StatefulWidget {
  const TeladeTarefas({super.key});

  @override
  _TeladeTarefasState createState() => _TeladeTarefasState();
}

class _TeladeTarefasState extends State<TeladeTarefas> with SingleTickerProviderStateMixin {
  int _selectedIndex = 0; // Índice do item selecionado na navegação inferior
  late TabController _tabController; // Controlador do TabBar

  // Listas de tarefas
  List<String> tarefasPendentes = ['Comprar pão', 'Estudar', 'Ligar para o João'];
  List<String> tarefasConcluidas = ['Refazer estudos', 'Levar o cachorro no veterinário'];

  // Inicializa o TabController
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  // Função chamada ao selecionar um item no BottomNavigationBar
  void _onBottomNavTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Função para adicionar uma nova tarefa
  void _adicionarTarefa() {
    showDialog(
      context: context,
      builder: (context) {
        TextEditingController tarefaController = TextEditingController();
        return AlertDialog(
          title: Text('Adicionar Nova Tarefa'), // caixa de texto mostrando onde será digitado

          content: TextField(
            controller: tarefaController,
            decoration: InputDecoration(hintText: 'Digite a tarefa'), // caixa de texto para digitar a tarefa
          ),
          actions: [
            TextButton( // botão para adicionar novas tarefas
              onPressed: () {
                setState(() {
                  tarefasPendentes.add(tarefaController.text);
                });
                Navigator.pop(context);
              },
              child: Text('Adicionar'),
            ),
            TextButton( // botão para cancelar a adição da tarefa
              onPressed: () => Navigator.pop(context),
              child: Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }

  // Função para excluir uma tarefa
  void _excluirTarefa(int index, bool isPendentes) {
    setState(() {
      if (isPendentes) {
        tarefasPendentes.removeAt(index); // se a tarefa for pendente pode ser removida para houver alteração
      } else {
        tarefasConcluidas.removeAt(index); //mas se ela for concluida será removida 
      }
    });
  }

  // Função para construir as abas de tarefas
  Widget buildTarefasTabView() {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.blueAccent,
          tabs: const [
            Tab(text: 'Pendentes'),
            Tab(text: 'Concluídas'),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              // Lista de Tarefas Pendentes
              ListView.builder(
                itemCount: tarefasPendentes.length,
                itemBuilder: (context, index) {
                  return Card( // faz um retorno mostrandos os cards das tarefas
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile( // mostra quais tarefas estão pendentes
                      contentPadding: EdgeInsets.all(16),
                      title: Text(
                        tarefasPendentes[index],
                        style: TextStyle(fontSize: 18),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red), // icone para deletar tarefas
                        onPressed: () => _excluirTarefa(index, true), // Exclui a tarefa pendente
                      ),
                    ),
                  );
                },
              ),
              // Lista de Tarefas Concluídas
              ListView.builder(
                itemCount: tarefasConcluidas.length,
                itemBuilder: (context, index) { // builder para mostrar cards das tarefas concluidas
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(16), // layout para tarefas concluidas
                      title: Text(
                        tarefasConcluidas[index],
                        style: TextStyle(fontSize: 18, color: Colors.green),
                      ),
                      leading: Icon(Icons.check_circle, color: Colors.green),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red), // icone de excluir e com cor quando vermelha
                        onPressed: () => _excluirTarefa(index, false), // Exclui a tarefa concluída
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) { // builder para o AppBar 
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerenciador de Tarefas'), //titulo
        backgroundColor: Colors.blueAccent,
        actions: [ // define a ação da interação 
          IconButton(
            icon: const Icon(Icons.notifications), //icone que vai ser mostrado
            onPressed: () { // interaçõa definida para o icone
            },
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            // Cabeçalho do Drawer
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.only(bottomRight: Radius.circular(50)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Menu', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            // Itens do Drawer
            ListTile(
              leading: Icon(Icons.dashboard, color: Colors.blueAccent), //items usados para o dashboard e estilização
              title: Text('Dashboard', style: TextStyle(fontSize: 18)),
            ),
            ListTile(
              leading: Icon(Icons.settings, color: Colors.blueAccent),  // items usados para as configurações no drawer
              title: Text('Configurações', style: TextStyle(fontSize: 18)),
            ),
            ListTile(
              leading: Icon(Icons.help, color: Colors.blueAccent), // items usados para a opção ajuda 
              title: Text('Ajuda', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
      body: _selectedIndex == 0 ? buildTarefasTabView() : Center(child: Text('Configurações')),
      floatingActionButton: FloatingActionButton(
        onPressed: _adicionarTarefa, // quando for feita a interação adiciona uma nova tarefa
        child: Icon(Icons.add),
        backgroundColor: Colors.blueAccent,
      ),
      bottomNavigationBar: BottomNavigationBar( //layout dos itens do bottonNavBar
        currentIndex: _selectedIndex, //qual é o index selecionado atualmente
        onTap: _onBottomNavTapped,
        backgroundColor: Colors.blueAccent, 
        selectedItemColor: Colors.white, // cor para item selecionado
        unselectedItemColor: Colors.grey, // remove a cor quando não esiver mais selecionado
        items: const [
          BottomNavigationBarItem( // "layout" definido para os icones do botton
            icon: Icon(Icons.list),
            label: 'Tarefas',
          ),
          BottomNavigationBarItem( // "Layout para configurações"
            icon: Icon(Icons.settings),
            label: 'Configurações',
          ),
        ],
      ),
    );
  }
}