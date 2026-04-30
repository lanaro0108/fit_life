import 'package:flutter/material.dart';

class MenuLateral extends StatelessWidget {
  const MenuLateral({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Define a largura como 70% da tela
      width: MediaQuery.of(context).size.width * 0.7, 
      child: SafeArea(
        child: Column(
          children: [
            // Botão para fechar o menu
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios, size: 25, color: Color(0xFF00A79D)),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            
            const SizedBox(height: 10),

            // Itens do Menu
            _buildMenuItem(Icons.dashboard, "Dashboard", context),
            _buildMenuItem(Icons.fitness_center_outlined, "Atividades", context),
            _buildMenuItem(Icons.settings_outlined, "Configurações", context),
            _buildMenuItem(Icons.help_outline, "Ajuda", context),
            
            const Spacer(), // Empurra o botão de sair para o final
            
            _buildMenuItem(Icons.logout, "Sair", context, color: Colors.black),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Função auxiliar para evitar repetição de código
  Widget _buildMenuItem(IconData icon, String title, BuildContext context, {Color color = Colors.black87}) {
    return ListTile(
      leading: Icon(icon, color: color), // O erro estava aqui: era 'leading'
      title: Text(
        title,
        style: TextStyle(color: color, fontWeight: FontWeight.w500),
      ),
      onTap: () {
        // Lógica de navegação aqui
        Navigator.pop(context);
      },
    );
  }
}