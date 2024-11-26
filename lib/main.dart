import 'package:flutter/material.dart';

void main() {
  runApp(const CalculadoraIMC());
}

class CalculadoraIMC extends StatelessWidget {
  const CalculadoraIMC({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => TelaCalculadoraIMC(),
        '/info': (context) => TelaCategoriasIMC(),
      },
    );
  }
}

// Monta a tela da calculadora
class TelaCalculadoraIMC extends StatefulWidget {
  @override
  _TelaCalculadoraIMCState createState() => _TelaCalculadoraIMCState();
}

class _TelaCalculadoraIMCState extends State<TelaCalculadoraIMC> {
  final TextEditingController pesoController = TextEditingController();
  final TextEditingController alturaController = TextEditingController();

  double? resultadoIMC;
  String categoriaIMC = "";
  String generoSelecionado = ""; // Variável para armazenar o gênero selecionado

  // metodo para calcular o IMC
  void calcularIMC() {
    try {
      final double peso = double.parse(pesoController.text);
      final double altura = double.parse(alturaController.text) / 100;
       // TESTE PARA VERIFICAR O IMC
      if (peso > 0 && altura > 0) {
        setState(() {
          resultadoIMC = peso / (altura * altura);

          if (resultadoIMC! < 18.5) {
            categoriaIMC = "Abaixo do peso";
          } else if (resultadoIMC! < 24.9) {
            categoriaIMC = "Peso normal";
          } else if (resultadoIMC! < 29.9) {
            categoriaIMC = "Sobrepeso";
          } else {
            categoriaIMC = "Obesidade";
          }
        });
      } else {
        setState(() {
          resultadoIMC = null;
          categoriaIMC = "Entrada inválida!";
        });
      }
    } catch (e) {
      setState(() {
        resultadoIMC = null;
        categoriaIMC = "Entrada inválida!";
      });
    }
  }
  // RESETA OS CAMPOS
  void reiniciarFormulario() {
    setState(() {
      resultadoIMC = null;
      categoriaIMC = "";
      pesoController.clear();
      alturaController.clear();
      generoSelecionado = ""; 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculadora de IMC"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () {
              Navigator.pushNamed(context, '/info');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      generoSelecionado = "masculino"; // Seleciona masculino
                    });
                  },
                  child: IconeGenero(
                    icone: Icons.male,
                    rotulo: "Masculino",
                    estaSelecionado: generoSelecionado == "masculino",
                  ),
                ),
                const SizedBox(width: 20),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      generoSelecionado = "feminino"; // Seleciona feminino
                    });
                  },
                  child: IconeGenero(
                    icone: Icons.female,
                    rotulo: "Feminino",
                    estaSelecionado: generoSelecionado == "feminino",
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            TextField(
              controller: pesoController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Seu peso (kg)",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: alturaController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Sua altura (cm)",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: calcularIMC,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
              ),
              child: const Text("Calcular IMC"),
            ),
            const SizedBox(height: 20),
            if (resultadoIMC != null)
              Column(
                children: [
                  Text(
                    "Seu IMC: ${resultadoIMC!.toStringAsFixed(1)}",
                    style: const TextStyle(fontSize: 24),
                  ),
                  Text(
                    categoriaIMC,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: reiniciarFormulario,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                    ),
                    child: const Text("Calcular novamente"),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
// monta o componente dos icones, fica em cinza antes de selecionar
class IconeGenero extends StatelessWidget {
  final IconData icone;
  final String rotulo;
  final bool estaSelecionado;

  const IconeGenero({
    required this.icone,
    required this.rotulo,
    required this.estaSelecionado,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icone,
          size: 100,
          color: estaSelecionado ? Colors.teal : Colors.grey,
        ),
        Text(
          rotulo,
          style: TextStyle(
            fontSize: 18,
            color: estaSelecionado ? Colors.teal : Colors.grey,
          ),
        ),
      ],
    );
  }
}


// mostra os tipos de imc
class TelaCategoriasIMC extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Categorias de IMC"),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Categorias de IMC",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              "• Menor que 18.5: Abaixo do peso",
              style: TextStyle(fontSize: 18),
            ),
            const Text(
              "• Entre 18.5 e 24.9: Peso normal",
              style: TextStyle(fontSize: 18),
            ),
            const Text(
              "• Entre 25 e 29.9: Sobrepeso",
              style: TextStyle(fontSize: 18),
            ),
            const Text(
              "• 30 ou mais: Obesidade",
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
