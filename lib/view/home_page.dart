import '../controller/atividades_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            children: [
              const SizedBox(height: 40),
              Text(
                'FitLife',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                'Seu treino diário em um só lugar',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.black54,
                      fontSize: 16,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Image.asset('assets/FitLife_LogoClaro.png', height: 180),
              const SizedBox(height: 24),

              const Spacer(),
              Image.asset('assets/Banner_Home.png'),

              const Spacer(),

              Container(
                width: double.infinity,
                height: 55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF8ED045), Color(0xFF00A79D)],
                  ),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/app');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Text(
                    'Começar',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20),

              Row(
                children: [
                  Expanded(child: Divider()),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text('ou', style: TextStyle(color: Colors.grey)),
                  ),
                  Expanded(child: Divider()),
                ],
              ),

              SizedBox(height: 20),

              // Botão "Já tem conta? Entrar"
              OutlinedButton(
                onPressed: () {
                  context.read<AtividadesController>().setCurrentIndex(1);
                  Navigator.pushReplacementNamed(context, '/app');
                },
                style: OutlinedButton.styleFrom(
                  fixedSize: const Size(double.maxFinite, 55),
                  side: const BorderSide(color: Color(0xFF00A79D)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.person_outline, color: Colors.black54),
                    SizedBox(width: 8),
                    Text(
                      'Já tem conta? ',
                      style: TextStyle(color: Colors.black54),
                    ),
                    Text(
                      'Entrar',
                      style: TextStyle(
                        color: Color(0xFF00A79D),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
