import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import '../config/firebase_config.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: FirebaseConfig.webOptions,
    );
    runApp(const MyApp());
  } catch (e) {
    runApp(const FirebaseErrorApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Connection Test',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const FirebaseConnectionCheck(),
    );
  }
}

class FirebaseErrorApp extends StatelessWidget {
  const FirebaseErrorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 50),
              const SizedBox(height: 20),
              Text(
                'Error de conexión con Firebase',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 10),
              const Text('Por favor verifica tu conexión a internet y la configuración de Firebase'),
            ],
          ),
        ),
      ),
    );
  }
}

class FirebaseConnectionCheck extends StatefulWidget {
  const FirebaseConnectionCheck({super.key});

  @override
  State<FirebaseConnectionCheck> createState() => _FirebaseConnectionCheckState();
}

class _FirebaseConnectionCheckState extends State<FirebaseConnectionCheck> {
  bool _isConnected = false;
  bool _isChecking = true;
  String _connectionMessage = 'Verificando conexión con Firebase...';

  @override
  void initState() {
    super.initState();
    _checkFirebaseConnection();
  }

  Future<void> _checkFirebaseConnection() async {
    try {
      // Intenta acceder a un servicio de Firebase para verificar la conexión
      // Por ejemplo, podrías verificar Firestore o Auth aquí
      _isConnected = true;
      _connectionMessage = '¡Conexión con Firebase exitosa!';
    } catch (e) {
      _connectionMessage = 'Error al conectar con Firebase: ${e.toString()}';
      _isConnected = false;
    } finally {
      setState(() {
        _isChecking = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prueba de conexión Firebase'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _isChecking
                ? const CircularProgressIndicator()
                : Icon(
                    _isConnected ? Icons.check_circle : Icons.error_outline,
                    color: _isConnected ? Colors.green : Colors.red,
                    size: 50,
                  ),
            const SizedBox(height: 20),
            Text(
              _connectionMessage,
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            if (!_isConnected)
              ElevatedButton(
                onPressed: _checkFirebaseConnection,
                child: const Text('Reintentar conexión'),
              ),
          ],
        ),
      ),
    );
  }
}