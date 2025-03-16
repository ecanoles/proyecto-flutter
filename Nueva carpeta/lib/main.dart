import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LoginScreen(),
    );
  }
}

// login_screen.dart
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email = """
""";
  String _password = '';
  bool _isLoading = false;

  void _submit() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      // Aquí iría la lógica de autenticación
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Login exitoso')));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Iniciar Sesión')), // Título centrado
      ),
      body: Center(
        // Centra todo el contenido vertical y horizontalmente
        child: SingleChildScrollView(
          // Permite desplazamiento si el contenido es grande
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center, // Centra los hijos verticalmente
                crossAxisAlignment:
                    CrossAxisAlignment
                        .center, // Centra los hijos horizontalmente
                children: [
                  // Campo de email
                  SizedBox(
                    width: 300, // Limita el ancho para mejor control
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Correo Electrónico',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.email),
                      ),
                      textAlign:
                          TextAlign.center, // Texto centrado dentro del campo
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingrese su correo';
                        }
                        if (!RegExp(
                          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                        ).hasMatch(value)) {
                          return 'Por favor ingrese un correo válido';
                        }
                        return null;
                      },
                      onChanged: (value) => _email = value,
                    ),
                  ),
                  SizedBox(height: 16),
                  // Campo de contraseña
                  SizedBox(
                    width: 300, // Limita el ancho para mejor control
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Contraseña',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.lock),
                      ),
                      textAlign:
                          TextAlign.center, // Texto centrado dentro del campo
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingrese su contraseña';
                        }
                        if (value.length < 6) {
                          return 'La contraseña debe tener al menos 6 caracteres';
                        }
                        return null;
                      },
                      onChanged: (value) => _password = value,
                    ),
                  ),
                  SizedBox(height: 24),
                  // Botón de login
                  SizedBox(
                    width: 300, // Mismo ancho que los campos
                    child:
                        _isLoading
                            ? Center(child: CircularProgressIndicator())
                            : ElevatedButton(
                              onPressed: _submit,
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(double.infinity, 50),
                                backgroundColor:
                                    Colors
                                        .blue[800], // Color de fondo del botón
                                foregroundColor: Colors.white,
                              ),
                              child: Text('Iniciar Sesión'),
                            ),
                  ),
                  SizedBox(height: 16),
                  // Link de olvido contraseña
                  TextButton(
                    onPressed: () {
                      // Aquí iría la lógica para recuperar contraseña
                    },
                    child: Text('¿Olvidaste tu contraseña?'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
