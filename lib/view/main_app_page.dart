import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fit_life/controller/app_state.dart';
import 'package:fit_life/view/atividades_page_impl.dart';
import 'package:fit_life/view/dashboard_page.dart';
import 'package:fit_life/view/configuracoes_page.dart';

class MainAppPage extends StatelessWidget {
  const MainAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();

    final screens = <Widget>[
      const DashboardPage(),
      const AtividadesPageImpl(),
      const ConfiguracoesPage(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Fit Life'),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Icon(Icons.fitness_center),
          ),
        ],
      ),
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.self_improvement,
                        color: Color(0xFF00A79D),
                        size: 36,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Olá, ${appState.userName}',
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Meta semanal: ${appState.weeklyGoal} atividades',
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),
              _drawerItem(context, Icons.dashboard, 'Dashboard', 0),
              _drawerItem(context, Icons.fitness_center, 'Atividades', 1),
              _drawerItem(context, Icons.settings, 'Configurações', 2),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.help_outline),
                title: const Text('Ajuda'),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Acesse a seção de ajuda para mais detalhes.',
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      body: screens[appState.currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: appState.currentIndex,
        onTap: appState.setCurrentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: 'Atividades',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Configurações',
          ),
        ],
      ),
    );
  }

  Widget _drawerItem(
    BuildContext context,
    IconData icon,
    String title,
    int index,
  ) {
    final appState = context.watch<AppState>();
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      selected: appState.currentIndex == index,
      onTap: () {
        context.read<AppState>().setCurrentIndex(index);
        Navigator.pop(context);
      },
    );
  }
}
