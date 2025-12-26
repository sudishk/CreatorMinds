
import 'package:creator_mind/features/auth/domain/usecases/register_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/injection.dart';
import '../bloc/login_bloc.dart';
import '../bloc/login_event.dart';
import '../bloc/login_state.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final firstNameCtrl = TextEditingController();
  final lastNameCtrl = TextEditingController();
  final genderCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  String? selectedClass;

  @override
  void dispose() {
    firstNameCtrl.dispose();
    lastNameCtrl.dispose();
    genderCtrl.dispose();
    phoneCtrl.dispose();
    emailCtrl.dispose();
    passCtrl.dispose();
    super.dispose();
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.blue, width: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AuthBloc>(),
      child: Scaffold(
        appBar: AppBar(title: const Text("Register")),
        body: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is RegisterSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Welcome ${state.user.name}")),
              );
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [
                    TextFormField(
                      controller: firstNameCtrl,
                      decoration: _inputDecoration("First Name"),
                      validator: (v) =>
                      v == null || v.isEmpty ? "First name required" : null,
                    ),
                    const SizedBox(height: 12),

                    TextFormField(
                      controller: lastNameCtrl,
                      decoration: _inputDecoration("Last Name"),
                      validator: (v) =>
                      v == null || v.isEmpty ? "Last name required" : null,
                    ),
                    const SizedBox(height: 12),

                  DropdownButtonFormField<String>(
                    decoration: _inputDecoration("Class"),
                    value: selectedClass,
                    items: const [
                      DropdownMenuItem(
                        value: "IX",
                        child: Text("Class IX"),
                      ),
                      DropdownMenuItem(
                        value: "X",
                        child: Text("Class X"),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        selectedClass = value;
                      });
                    },
                    validator: (value) =>
                    value == null ? "Please select class" : null,
                  ),
                    const SizedBox(height: 12),

                    TextFormField(
                      controller: genderCtrl,
                      decoration: _inputDecoration("Gender"),
                      validator: (v) =>
                      v == null || v.isEmpty ? "Gender required" : null,
                    ),
                    const SizedBox(height: 12),

                    TextFormField(
                      controller: phoneCtrl,
                      decoration: _inputDecoration("Phone Number"),
                      keyboardType: TextInputType.phone,
                      validator: (v) {
                        if (v == null || v.isEmpty) {
                          return "Phone number required";
                        }
                        if (v.length != 10) {
                          return "Enter valid 10 digit number";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),

                    TextFormField(
                      controller: emailCtrl,
                      decoration: _inputDecoration("Email"),
                      keyboardType: TextInputType.emailAddress,
                      validator: (v) {
                        if (v == null || v.isEmpty) {
                          return "Email required";
                        }
                        final regex = RegExp(
                            r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                        if (!regex.hasMatch(v)) {
                          return "Enter valid email";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),

                    TextFormField(
                      controller: passCtrl,
                      decoration: _inputDecoration("Password"),
                      obscureText: true,
                      validator: (v) {
                        if (v == null || v.isEmpty) {
                          return "Password required";
                        }
                        if (v.length < 6) {
                          return "Minimum 6 characters required";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),

                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: state is AuthLoading
                            ? null
                            : () {
                          if (_formKey.currentState!.validate()) {
                            context.read<AuthBloc>().add(
                              RegisterRequested(
                                RegisterParams(firstName: firstNameCtrl.text, lastName: lastNameCtrl.text, className: "$selectedClass", gender: genderCtrl.text, email:  emailCtrl.text, password: passCtrl.text, phone: phoneCtrl.text)),
                            );
                          }
                        },
                        child: state is AuthLoading
                            ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                            : const Text("Register"),
                      ),
                    ),

                    if (state is LoginError) ...[
                      const SizedBox(height: 12),
                      Text(
                        state.message,
                        style: const TextStyle(color: Colors.red),
                      ),

                    ],
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, '/login');
                      },
                      child: const Text("Already have an account? Login"),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

