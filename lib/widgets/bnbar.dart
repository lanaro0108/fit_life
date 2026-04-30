import 'package:flutter/material.dart';

class Bnbar extends StatefulWidget {
  @override
  _BnbState createState() => _BnbState();
}

class _BnbState extends State<Bnbar> {
  int _indice = 0;

  final List<Widget> _telas = [
    AtividadesPage(),
    DashboardPage(),
    ConfiguracoesPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _telas[_indice],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _indice,
        onTap: (int novoIndice) {
          setState(() {
            _indice = novoIndice;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Busca'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
      ),
    );
  }
}

class AtividadesPage extends StatelessWidget {
  const AtividadesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}

class ConfiguracoesPage extends StatelessWidget {
  const ConfiguracoesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
