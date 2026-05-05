import 'package:fit_life/controller/atividades_controller.dart';
import 'package:fit_life/view/atividades_page.dart';
import 'package:fit_life/view/config_page.dart';
import 'package:fit_life/view/dashboard_page.dart';
import 'package:fit_life/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppShell extends StatelessWidget {
  const AppShell({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AtividadesController>();
    final currentIndex = provider.currentIndex;

    final pages = <Widget>[
      const DashboardPage(),
      const AtividadesPage(),
      const ConfigPage(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('FitLife'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            tooltip: 'Notificações',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('Notificações ainda não disponíveis.')),
              );
            },
          ),
        ],
      ),
      drawer: const MenuLateral(),
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: provider.setCurrentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center_outlined),
            label: 'Atividades',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: 'Configurações',
          ),
        ],
      ),
    );
  }
}
