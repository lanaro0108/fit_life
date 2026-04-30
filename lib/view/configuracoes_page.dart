import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fit_life/controller/app_state.dart';

class ConfiguracoesPage extends StatefulWidget {
  const ConfiguracoesPage({super.key});

  @override
  State<ConfiguracoesPage> createState() => _ConfiguracoesPageState();
}

class _ConfiguracoesPageState extends State<ConfiguracoesPage> {
  late final TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final appState = context.read<AppState>();
    if (_nameController.text.isEmpty) {
      _nameController.text = appState.userName;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();

    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView(
        children: [
          const Text(
            'Configurações',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          SwitchListTile(
            title: const Text('Modo escuro'),
            value: appState.isDarkMode,
            onChanged: appState.setDarkMode,
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Nome do usuário',
              border: OutlineInputBorder(),
            ),
            onChanged: appState.setUserName,
          ),
          const SizedBox(height: 16),
          Text(
            'Meta semanal: ${appState.weeklyGoal} atividades',
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          Slider(
            min: 1,
            max: 12,
            divisions: 11,
            label: '${appState.weeklyGoal}',
            value: appState.weeklyGoal.toDouble(),
            onChanged: (value) => appState.setWeeklyGoal(value.round()),
          ),
          const SizedBox(height: 16),
          SwitchListTile(
            title: const Text('Notificações'),
            value: appState.notificationsEnabled,
            onChanged: appState.setNotificationsEnabled,
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: appState.resetProgress,
            icon: const Icon(Icons.refresh),
            label: const Text('Redefinir progresso'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00A79D),
              minimumSize: const Size.fromHeight(50),
            ),
          ),
        ],
      ),
    );
  }
}
