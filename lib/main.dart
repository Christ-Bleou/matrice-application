// ignore_for_file: library_private_types_in_public_api, constant_identifier_names, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'about_page.dart';
import 'data/datasources/local_database_service.dart';
import 'theme/theme_notifier.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeNotifier(DatabaseService.instance)..loadTheme(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Matrice Application',
      theme: themeNotifier.themeData,
      home: const CalculatorApp(),
    );
  }
}

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});

  @override
  _CalculatorAppState createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> with TickerProviderStateMixin {

  late TabController mainTabController;
  late TabController calculationTabController;

  @override
  void initState() {
    super.initState();

    mainTabController = TabController(
      length: 2,
      vsync: this,
    );

    calculationTabController = TabController(
      length: 5,
      vsync: this,
    );
  }

  @override
  void dispose() {
    mainTabController.dispose();
    calculationTabController.dispose();

    number1Controller.dispose();
    number2Controller.dispose();

    super.dispose();
  }

  double result = 0.0;
  TextEditingController number1Controller = TextEditingController();
  TextEditingController number2Controller = TextEditingController();

  void calculate(Operation operation) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Entrez deux nombres'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: number1Controller,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Nombre 1'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: number2Controller,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Nombre 2'),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                double number1 = double.tryParse(number1Controller.text) ?? 0.0;
                double number2 = double.tryParse(number2Controller.text) ?? 0.0;

                switch (operation) {
                  case Operation.addition:
                    result = number1 + number2;
                    break;
                  case Operation.subtraction:
                    result = number1 - number2;
                    break;
                  case Operation.multiplication:
                    result = number1 * number2;
                    break;
                  case Operation.division:
                    if (number2 != 0) {
                      result = number1 / number2;
                    } else {
                      // Gestion de la division par zéro
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Erreur'),
                            content: const Text(
                                'La division par zéro n\'est pas autorisée.'),
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                      Navigator.of(context).pop();
                      return; // Arrête la fonction pour éviter de calculer le résultat
                    }
                    break;
                  case Operation.modulo:
                    result = number1 % number2;
                    break;
                }

                // Met à jour l'état pour reconstruire l'interface utilisateur avec le nouveau résultat
                setState(() {});

                //Aide à afficher le résultat
                Navigator.of(context).pop();

                // Affiche le résultat
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Résultat'),
                      content: Text('Le résultat est : $result'),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    );
                  },
                );

                // Navigator.of(context).pop();
              },
              child: const Text('Calculer'),
            ),
          ],
        );
      },
    );
  }

  // Procédure pour mettre à jour la couleur de fond (persistée via ThemeNotifier)
  void changeBackgroundColor(Color color) {
    final themeNotifier = Provider.of<ThemeNotifier>(context, listen: false);
    themeNotifier.updateBackgroundColor(color);
  }

  // Fonction pour afficher la boîte de dialogue pour choisir la couleur
  void _showColorPickerDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Choisir une couleur'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _colorRadioListTile(
                context,
                const Color.fromARGB(134, 33, 149, 243),
                'Bleu',
                Provider.of<ThemeNotifier>(context).scaffoldBackgroundColor,
                    (selectedColor) {
                  changeBackgroundColor(selectedColor);
                },
              ),
              _colorRadioListTile(
                context,
                Colors.black,
                'Noir',
                Provider.of<ThemeNotifier>(context).scaffoldBackgroundColor,
                    (selectedColor) {
                  changeBackgroundColor(selectedColor);
                },
              ),
              _colorRadioListTile(
                context,
                Colors.white,
                'Blanc',
                Provider.of<ThemeNotifier>(context).scaffoldBackgroundColor,
                    (selectedColor) {
                  changeBackgroundColor(selectedColor);
                },
              ),
              _colorRadioListTile(
                context,
                const Color.fromARGB(110, 233, 30, 145),
                'Rose',
                Provider.of<ThemeNotifier>(context).scaffoldBackgroundColor,
                    (selectedColor) {
                  changeBackgroundColor(selectedColor);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Provider.of<ThemeNotifier>(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Matrice Application'),
        centerTitle: true,
        bottom: TabBar(
          controller: mainTabController,
          tabs: const [
            Tab(
              icon: Icon(Icons.home_outlined),
              text: 'Accueil',
            ),
            Tab(
              icon: Icon(Icons.calculate_outlined),
              text: 'Calculs',
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green,
              ),
              child: Text(
                'Navigation Drawer',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: const Text('Option 1: \nAddition de deux matrices'),
              onTap: () {
                // Action à effectuer lorsque l'option 1 est sélectionnée
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MatrixCalculatorPage(
                        operationType: OperationType.Addition,
                      )),
                );
              },
            ),
            ListTile(
              title: const Text('Option 2: \nSoustraction de deux matrices'),
              onTap: () {
                // Action à effectuer lorsque l'option 2 est sélectionnée
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MatrixCalculatorPage(
                        operationType: OperationType.Soustraction,
                      )),
                );
              },
            ),
            ListTile(
              title: const Text('Option 3: \nProduit de deux matrices'),
              onTap: () {
                // Action à effectuer lorsque l'option 3 est sélectionnée
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MatrixProductPage()),
                );
              },
            ),
            ListTile(
              title: const Text('Option 4: \nTransposée d\'une matrice'),
              onTap: () {
                // Action à effectuer lorsque l'option 4 est sélectionnée
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MatrixTransPage()),
                );
              },
            ),
            ListTile(
              title: const Text('Option 5: Paramètre'),
              onTap: () {
                // Action à effectuer lorsque l'option 5 est sélectionnée
                _showColorPickerDialog();
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('À propos'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AboutPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: mainTabController,
        children: [

          // ONGLET 1 : ACCUEIL
          Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.grid_on_rounded,
                    size: 75,
                    color: Colors.green,
                  ),
                  SizedBox(height: 25),
                  Text(
                    'Bienvenue !',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Bienvenue sur Matrice Application.\n\n'
                    'Explorez nos outils de calcul et simplifiez '
                    'vos opérations mathématiques.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ONGLET 2 : CINQ OPÉRATIONS CLASSIQUES
          Column(
            children: [

              TabBar(
                controller: calculationTabController,
                isScrollable: true,
                tabs: const [
                  Tab(text: 'Addition'),
                  Tab(text: 'Soustraction'),
                  Tab(text: 'Multiplication'),
                  Tab(text: 'Division'),
                  Tab(text: 'Modulo'),
                ],
              ),

              Expanded(
                child: TabBarView(
                  controller: calculationTabController,
                  children: [

                    _calculationTab(
                      'Addition',
                      Icons.add,
                      Colors.green,
                      () => calculate(Operation.addition),
                    ),

                    _calculationTab(
                      'Soustraction',
                      Icons.remove,
                      Colors.red,
                      () => calculate(Operation.subtraction),
                    ),

                    _calculationTab(
                      'Multiplication',
                      Icons.close,
                      Colors.blue,
                      () => calculate(Operation.multiplication),
                    ),

                    _calculationTab(
                      'Division',
                      Icons.percent,
                      Colors.orange,
                      () => calculate(Operation.division),
                    ),

                    _calculationTab(
                      'Modulo',
                      Icons.functions,
                      Colors.purple,
                      () => calculate(Operation.modulo),
                    ),

                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget _calculationTab(
  String title,
  IconData icon,
  Color color,
  VoidCallback onPressed,
) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Icon(
            icon,
            size: 75,
            color: color,
          ),

          const SizedBox(height: 20),

          Text(
            title,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 25),

          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton.icon(
              onPressed: onPressed,
              icon: const Icon(Icons.calculate),
              label: Text('Effectuer une $title'),
              style: ElevatedButton.styleFrom(
                backgroundColor: color,
                foregroundColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _colorRadioListTile(BuildContext context, Color color, String label,
    Color currentColor, ValueChanged<Color> onChanged) {
  return ListTile(
    title: Text(label),
    leading: Radio<Color>(
      value: color,
      groupValue: currentColor,
      onChanged: (Color? newColor) {
        if (newColor != null) {
          onChanged(newColor);
          Navigator.of(context).pop();
        }
      },
      fillColor: WidgetStateProperty.all(color),
    ),
    onTap: () {
      onChanged(color);
      Navigator.of(context).pop();
    },
  );
}

/// Réutilisable: Scaffold pour les pages de calcul de matrices
class MatrixScaffold extends StatelessWidget {
  final Widget body;
  final String title;

  const MatrixScaffold({super.key, required this.body, this.title = 'Calcul des matrices'});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: body,
    );
  }
}

class MatrixProductPage extends StatefulWidget {
  const MatrixProductPage({super.key});

  @override
  _MatrixProductPageState createState() => _MatrixProductPageState();
}

class _MatrixProductPageState extends State<MatrixProductPage> {
  late int n;
  late int p;
  late int m;
  late int q;
  late List<List<int>> matrice1;
  late List<List<int>> matrice2;
  late List<List<int>> somme;
  bool isFirstMatrixEntered = false; //Déclaration
  bool isSecondMatrixEntered = false; //Déclaration

  @override
  Widget build(BuildContext context) {
    return MatrixScaffold(
      title: 'Calcul des matrices',
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Dimensions de la première matrice:',
              style: TextStyle(fontSize: 18),
            ),
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  n = int.parse(value);
                });
              },
              decoration: const InputDecoration(
                labelText: 'Nombre de lignes (n <= 5)',
              ),
            ),
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  p = int.parse(value);
                });
              },
              decoration: const InputDecoration(
                labelText: 'Nombre de colonnes (p <= 5)',
              ),
            ),
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  m = int.parse(value);
                });
              },
              decoration: const InputDecoration(
                labelText:
                'Nombre de lignes de la deuxième matrice (m <= 5) = p',
              ),
            ),
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  q = int.parse(value);
                });
              },
              decoration: const InputDecoration(
                labelText: 'Nombre de colonnes de la deuxième matrice (q <= 5)',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Implémentez la logique pour saisir les éléments de la première matrice
                enterMatrixElements(context);
              },
              child: const Text('Entrez les éléments de la première matrice'),
            ),
          ],
        ),
      ),
    );
  }

// Fonction pour saisir les éléments de la première matrice
  void enterMatrixElements(BuildContext context) {
    matrice1 = List.generate(n, (i) => List<int>.filled(p, 0));
    matrice2 = List.generate(m, (i) => List<int>.filled(q, 0));
    somme = List.generate(n, (i) => List<int>.filled(q, 0));

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Entrez les éléments de la première matrice'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              n,
                  (i) => Row(
                children: List.generate(
                  p,
                      (j) => Expanded(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        matrice1[i][j] = int.parse(value);
                      },
                      decoration: InputDecoration(
                        labelText: '(${i + 1}, ${j + 1})',
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  isFirstMatrixEntered = true;
                });
                Navigator.of(context).pop();
                enterSecondMatrixElements(context);
              },
              child: const Text('Entrez les éléments de la deuxième matrice'),
            ),
          ],
        );
      },
    );
  }

// Fonction pour saisir les éléments de la deuxième matrice
  void enterSecondMatrixElements(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Entrez les éléments de la deuxième matrice'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              m,
                  (i) => Row(
                children: List.generate(
                  q,
                      (j) => Expanded(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        matrice2[i][j] = int.parse(value);
                      },
                      decoration: InputDecoration(
                        labelText: '(${i + 1}, ${j + 1})',
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  isSecondMatrixEntered = true;
                  calculateProd(
                      context); // Changed method call to calculate product
                });
                Navigator.of(context).pop();
              },
              child: const Text('Résultat'),
            ),
          ],
        );
      },
    );
  }

// Fonction pour calculer le produit des matrices
  void calculateProd(BuildContext context) {
    // Logique pour la multiplication des matrices

    // Création des matrices résultantes
    List<List<int>> resultante1;
    List<List<int>> resultante2;

    // Vérification pour la multiplication de la première manière
    if (p == m) {
      resultante1 = List.generate(n, (_) => List<int>.filled(q, 0));
      for (int i = 0; i < n; i++) {
        for (int j = 0; j < q; j++) {
          resultante1[i][j] = 0;
          for (int k = 0; k < p; k++) {
            resultante1[i][j] += matrice1[i][k] * matrice2[k][j];
          }
        }
      }
      showProd(context, resultante1, "Résultante1 :");
    } else {
      showMessage(context,
          "Multiplication impossible pour Résultante1 : le nombre de colonnes de la matrice1 n'est pas égal au nombre de lignes de la matrice2.");
    }

    // Vérification pour la multiplication de la deuxième manière
    if (q == n) {
      resultante2 = List.generate(m, (_) => List<int>.filled(p, 0));
      for (int i = 0; i < m; i++) {
        for (int j = 0; j < p; j++) {
          resultante2[i][j] = 0;
          for (int k = 0; k < q; k++) {
            resultante2[i][j] += matrice2[i][k] * matrice1[k][j];
          }
        }
      }
      showProd(context, resultante2, "Résultante2");
    } else {
      showMessage(context,
          "Multiplication impossible pour Résultante2 : le nombre de colonnes de matrice2 n'est pas égal au nombre de lignes de la matrice1.");
    }
  }

  // Fonction pour afficher le produit des matrices à l'utilisateur
  void showProd(BuildContext context, List<List<int>> matrice, String title) {
    String sumText = '$title \n\n';

    sumText += '\nMatrice 1 :\n';
    for (int i = 0; i < n; i++) {
      sumText += '(';
      for (int j = 0; j < p; j++) {
        sumText += ' ${matrice1[i][j]} ';
      }
      sumText += ')\n';
    }

    sumText += '\nMatrice 2 :\n';
    for (int i = 0; i < m; i++) {
      sumText += '(';
      for (int j = 0; j < q; j++) {
        sumText += ' ${matrice2[i][j]} ';
      }
      sumText += ')\n';
    }

    sumText += '\nRésultat :\n';
    for (int i = 0; i < matrice.length; i++) {
      sumText += '(';
      for (int j = 0; j < matrice[i].length; j++) {
        sumText += ' ${matrice[i][j]} ';
      }
      sumText += ')\n';
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(sumText),
        duration: const Duration(seconds: 20),
      ),
    );
  }

  // Fonction pour afficher les messages d'erreur
  void showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 30),
      ),
    );
  }
}

class MatrixCalculatorPage extends StatefulWidget {
  final OperationType operationType;

  const MatrixCalculatorPage({super.key, required this.operationType});

  @override
  _MatrixCalculatorPageState createState() => _MatrixCalculatorPageState();
}

class _MatrixCalculatorPageState extends State<MatrixCalculatorPage> {
  late int n;
  late int p;
  late List<List<int>> matrice1;
  late List<List<int>> matrice2;
  late List<List<int>> somme;
  bool isFirstMatrixEntered = false; //Déclaration
  bool isSecondMatrixEntered = false; //Déclaration

  _MatrixCalculatorPageState() {
    isFirstMatrixEntered = false; //initialisation
    isSecondMatrixEntered = false; //initialisation
  }

  @override
  Widget build(BuildContext context) {
    return MatrixScaffold(
      title: 'Calcul des matrices',
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Dimensions de la première matrice:',
              style: TextStyle(fontSize: 18),
            ),
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  n = int.parse(value);
                });
              },
              decoration: const InputDecoration(
                labelText: 'Nombre de lignes (n <= 5)',
              ),
            ),
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  p = int.parse(value);
                });
              },
              decoration: const InputDecoration(
                labelText: 'Nombre de colonnes (p <= 5)',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Implémentez la logique pour saisir les éléments de la première matrice
                enterMatrixElements();
              },
              child: const Text('Entrez les éléments de la première matrice'),
            ),
          ],
        ),
      ),
    );
  }

  // Fonction pour saisir les éléments de la première matrice
  void enterMatrixElements() {
    matrice1 = List.generate(n, (i) => List<int>.filled(p, 0));
    matrice2 = List.generate(n, (i) => List<int>.filled(p, 0));
    somme = List.generate(n, (i) => List<int>.filled(p, 0));

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Entrez les éléments de la première matrice'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              n,
                  (i) => Row(
                children: List.generate(
                  p,
                      (j) => Expanded(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        matrice1[i][j] = int.parse(value);
                      },
                      decoration: InputDecoration(
                        labelText: '(${i + 1}, ${j + 1})',
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  isFirstMatrixEntered = true;
                });
                Navigator.of(context).pop();
                enterSecondMatrixElements();
              },
              child: const Text('Entrez les éléments de la deuxième matrice'),
            ),
          ],
        );
      },
    );
  }

  // Fonction pour saisir les éléments de la deuxième matrice
  void enterSecondMatrixElements() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Entrez les éléments de la deuxième matrice'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              n,
                  (i) => Row(
                children: List.generate(
                  p,
                      (j) => Expanded(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        matrice2[i][j] = int.parse(value);
                      },
                      decoration: InputDecoration(
                        labelText: '(${i + 1}, ${j + 1})',
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  isSecondMatrixEntered = true;
                  calculateSum();
                });
                Navigator.of(context).pop();
              },
              child: const Text('Résultat'),
            ),
          ],
        );
      },
    );
  }

  // Fonction pour calculer le résultat des matrices
  void calculateSum() {
    if (widget.operationType == OperationType.Addition) {
      // Logique pour l'addition des matrices
      for (int i = 0; i < n; i++) {
        for (int j = 0; j < p; j++) {
          somme[i][j] = matrice1[i][j] + matrice2[i][j];
        }
      }
    } else if (widget.operationType == OperationType.Soustraction) {
      // Logique pour la soustraction des matrices
      for (int i = 0; i < n; i++) {
        for (int j = 0; j < p; j++) {
          somme[i][j] = matrice1[i][j] - matrice2[i][j];
        }
      }
    }
    showSum(); // Appel de la méthode pour afficher le résultat
  }

// Fonction pour afficher la somme des matrices à l'utilisateur
  void showSum() {
    String sumText = 'Le résultat des deux matrices est :\n\n';
    sumText += 'Matrice 1 :\n';
    for (int i = 0; i < n; i++) {
      sumText += '(';
      for (int j = 0; j < p; j++) {
        sumText += ' ${matrice1[i][j]} ';
      }
      sumText += ')\n';
    }

    sumText += '\nMatrice 2 :\n';
    for (int i = 0; i < n; i++) {
      sumText += '(';
      for (int j = 0; j < p; j++) {
        sumText += ' ${matrice2[i][j]} ';
      }
      sumText += ')\n';
    }

    sumText += '\nRésultat :\n';
    for (int i = 0; i < n; i++) {
      sumText += '(';
      for (int j = 0; j < p; j++) {
        sumText += ' ${somme[i][j]} ';
      }
      sumText += ')\n';
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(sumText),
        duration: const Duration(
            seconds: 60), // Facultatif : spécifie la durée du SnackBar
      ),
    );
  }
}

class MatrixTransPage extends StatefulWidget {
  const MatrixTransPage({super.key});

  @override
  _MatrixTransPageState createState() => _MatrixTransPageState();
}

class _MatrixTransPageState extends State<MatrixTransPage> {
  late int n;
  late int p;
  late List<List<int>> matrice1;
  late List<List<int>> somme;
  bool isFirstMatrixEntered = false;

  @override
  Widget build(BuildContext context) {
    return MatrixScaffold(
      title: 'Calcul des matrices',
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Dimensions de la matrice:',
              style: TextStyle(fontSize: 18),
            ),
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  n = int.parse(value);
                });
              },
              decoration: const InputDecoration(
                labelText: 'Nombre de lignes (n <= 5)',
              ),
            ),
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  p = int.parse(value);
                });
              },
              decoration: const InputDecoration(
                labelText: 'Nombre de colonnes (p <= 5)',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                enterMatrixElements();
              },
              child: const Text('Entrez les éléments de la matrice'),
            ),
          ],
        ),
      ),
    );
  }

  void enterMatrixElements() {
    matrice1 = List.generate(n, (i) => List<int>.filled(p, 0));
    somme = List.generate(n, (i) => List<int>.filled(p, 0));

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Entrez les éléments de la matrice'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              n,
                  (i) => Row(
                children: List.generate(
                  p,
                      (j) => Expanded(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        matrice1[i][j] = int.parse(value);
                      },
                      decoration: InputDecoration(
                        labelText: '(${i + 1}, ${j + 1})',
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  isFirstMatrixEntered = true;
                });
                showSum();
              },
              child: const Text("Résultat :"),
            ),
          ],
        );
      },
    );
  }

  void showSum() {
    String sumText = 'La transposée de la matrice est :\n\n';
    sumText += 'Matrice :\n';
    for (int i = 0; i < n; i++) {
      sumText += '(';
      for (int j = 0; j < p; j++) {
        sumText += ' ${matrice1[i][j]} ';
      }
      sumText += ')\n';
    }
    sumText += '\nTransposée :\n';
    for (int i = 0; i < p; i++) {
      sumText += '(';
      for (int j = 0; j < n; j++) {
        sumText += ' ${matrice1[j][i]} ';
      }
      sumText += ')\n';
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(sumText),
        duration: const Duration(seconds: 10),
      ),
    );
  }
}

enum OperationType { Addition, Soustraction }

enum Operation {
  addition,
  subtraction,
  multiplication,
  division,
  modulo,
}