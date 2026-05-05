import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/atividades_controller.dart';
import '../theme/app_theme.dart';

/// Tela de Configurações — usa Provider para todas as alterações
class ConfigPage extends StatefulWidget {
  const ConfigPage({super.key});

  @override
  State<ConfigPage> createState() => _ConfigScreenState();
}

class _ConfigScreenState extends State<ConfigPage> {
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    final name = context.read<AtividadesController>().userName;
    _nameController = TextEditingController(text: name);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AtividadesController>();

    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        _SectionHeader(title: 'Perfil'),
        Card(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Nome do usuário',
                    style: Theme.of(context).textTheme.bodyMedium),
                SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _nameController,
                        textCapitalization: TextCapitalization.words,
                        decoration: InputDecoration(
                          hintText: 'Seu nome',
                          prefixIcon: Icon(Icons.person_outline),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        provider.updateUserName(_nameController.text);
                        _showSnack(context, 'Nome atualizado! ✅');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryGreen,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      ),
                      child: Text('Salvar'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        SizedBox(height: 16),

        _SectionHeader(title: 'Aparência'),
        Card(
          child: SwitchListTile(
            secondary: Icon(
              provider.darkMode ? Icons.dark_mode : Icons.light_mode,
              color: provider.darkMode
                  ? AppTheme.primaryGreen
                  : AppTheme.accentOrange,
            ),
            title: Text('Modo Escuro'),
            subtitle: Text(provider.darkMode ? 'Ativado' : 'Desativado'),
            value: provider.darkMode,
            activeColor: AppTheme.primaryGreen,
            // Usa Provider para alternar o tema em tempo real
            onChanged: (_) => provider.toggleDarkMode(),
          ),
        ),

        SizedBox(height: 16),

        _SectionHeader(title: 'Metas'),
        Card(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Meta semanal',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontSize: 16,
                          ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryGreen.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '${provider.weeklyGoal} ativ./semana',
                        style: TextStyle(
                          color: AppTheme.primaryGreen,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [3, 5, 7, 10].map((goal) {
                    final isSelected = provider.weeklyGoal == goal;
                    return _GoalChip(
                      value: goal,
                      isSelected: isSelected,
                      onTap: () {
                        provider.updateWeeklyGoal(goal);
                        _showSnack(context,
                            'Meta atualizada para $goal atividades/semana 🎯');
                      },
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),

        SizedBox(height: 24),
        Center(
          child: Column(
            children: [
              Text('⚡', style: TextStyle(fontSize: 28)),
              SizedBox(height: 6),
              Text(
                'FitLife v1.0.0',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                'Feito com Flutter',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontSize: 12),
              ),
            ],
          ),
        ),

        SizedBox(height: 24),
      ],
    );
  }


  void _showSnack(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}


class _SectionHeader extends StatelessWidget {
  final String title;
  _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8, left: 4),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: AppTheme.primaryGreen,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}

class _GoalChip extends StatelessWidget {
  final int value;
  final bool isSelected;
  final VoidCallback onTap;

  _GoalChip({
    required this.value,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          color: isSelected
              ? AppTheme.primaryGreen
              : AppTheme.primaryGreen.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? AppTheme.primaryGreen
                : AppTheme.primaryGreen.withOpacity(0.3),
            width: 1.5,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$value',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: isSelected ? Colors.white : AppTheme.primaryGreen,
              ),
            ),
            Text(
              'dias',
              style: TextStyle(
                fontSize: 10,
                color: isSelected
                    ? Colors.white70
                    : AppTheme.primaryGreen.withOpacity(0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
