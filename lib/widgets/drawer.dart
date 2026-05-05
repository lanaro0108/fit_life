import '../controller/atividades_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
                icon: const Icon(Icons.arrow_back_ios,
                    size: 25, color: Color(0xFF00A79D)),
                onPressed: () => Navigator.pop(context),
              ),
            ),

            const SizedBox(height: 10),

            _buildMenuItem(
              Icons.dashboard_outlined,
              'Dashboard',
              () {
                context.read<AtividadesController>().setCurrentIndex(0);
                Navigator.pop(context);
              },
            ),
            _buildMenuItem(
              Icons.fitness_center_outlined,
              'Atividades',
              () {
                context.read<AtividadesController>().setCurrentIndex(1);
                Navigator.pop(context);
              },
            ),
            _buildMenuItem(
              Icons.settings_outlined,
              'Configurações',
              () {
                context.read<AtividadesController>().setCurrentIndex(2);
                Navigator.pop(context);
              },
            ),
            _buildMenuItem(
              Icons.help_outline,
              'Ajuda',
              () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Ajuda em breve!')),
                );
              },
            ),

            const Spacer(),

            _buildMenuItem(
              Icons.logout,
              'Sair',
              () => Navigator.pop(context),
              color: Colors.black87,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, VoidCallback onTap,
      {Color color = Colors.black87}) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(
        title,
        style: TextStyle(color: color, fontWeight: FontWeight.w500),
      ),
      onTap: onTap,
    );
  }
}
