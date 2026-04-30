import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fit_life/controller/app_state.dart';

class AtividadesPage extends StatelessWidget {
  const AtividadesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();

    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          Container(
            color: Theme.of(context).colorScheme.surface,
            child: const TabBar(
              indicatorColor: Color(0xFF00A79D),
              labelColor: Color(0xFF00A79D),
              unselectedLabelColor: Colors.grey,
              tabs: [
                Tab(text: 'Pendentes'),
                Tab(text: 'Concluídas'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                _buildPendingList(appState),
                _buildCompletedList(appState),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPendingList(AppState appState) {
    final pending = appState.pendingActivities;
    if (pending.isEmpty) {
      return const Center(child: Text('Nenhuma atividade pendente.'));
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: pending.length,
      itemBuilder: (context, index) {
        final activity = pending[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: CheckboxListTile(
            title: Text(activity.title, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('${activity.calories} kcal · ${activity.durationMinutes} min'),
            value: activity.isCompleted,
            activeColor: const Color(0xFF00A79D),
            onChanged: (_) => appState.toggleActivityStatus(activity.id),
          ),
        );
      },
    );
  }

  Widget _buildCompletedList(AppState appState) {
    final completed = appState.completedActivities;
    if (completed.isEmpty) {
      return const Center(child: Text('Nenhuma atividade concluída ainda.'));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: completed.length,
      itemBuilder: (context, index) {
        final activity = completed[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          color: Colors.green.shade50,
          child: ListTile(
            leading: const Icon(Icons.check_circle, color: Color(0xFF00A79D)),
            title: Text(activity.title, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('${activity.calories} kcal · ${activity.durationMinutes} min'),
            trailing: IconButton(
              icon: const Icon(Icons.undo, color: Colors.black54),
              onPressed: () => appState.toggleActivityStatus(activity.id),
            ),
          ),
        );
      },
    );
  }
}
