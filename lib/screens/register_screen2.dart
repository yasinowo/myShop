import 'package:aplle_shop_pj/screens/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aplle_shop_pj/data/bloc/auth_bloc.dart';
import 'package:aplle_shop_pj/data/bloc/auth_event.dart';
import 'package:aplle_shop_pj/data/bloc/auth_state.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterScreen2 extends StatefulWidget {
  const RegisterScreen2({super.key});

  @override
  State<RegisterScreen2> createState() => _RegisterScreen2State();
}

class _RegisterScreen2State extends State<RegisterScreen2> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController usernameController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: viewContaner(context),
    );
  }

  Scaffold viewContaner(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 30.0.w, vertical: 45.h),
          child: Column(
            children: [
              SizedBox(
                  height: 250.h,
                  width: 300.w,
                  child: Image.asset('assets/images/login1.png')),
              const SizedBox(height: 0),
              Text(
                "Register",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              SizedBox(height: 10.h),
              Text(
                "Create your account",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: 30.h),
              TextFormField(
                controller: usernameController,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  labelText: "Username",
                  prefixIcon: const Icon(Icons.person_outline),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter username.";
                  }
                  return null;
                },
              ),
              SizedBox(height: 10.h),
              TextFormField(
                controller: passwordController,
                obscureText: obscurePassword,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  labelText: "Password",
                  prefixIcon: const Icon(Icons.password_outlined),
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          obscurePassword = !obscurePassword;
                        });
                      },
                      icon: obscurePassword
                          ? const Icon(Icons.visibility_outlined)
                          : const Icon(Icons.visibility_off_outlined)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter password.";
                  } else if (value.length < 8) {
                    return "Password must be at least 8 characters.";
                  }
                  return null;
                },
              ),
              SizedBox(height: 10.h),
              TextFormField(
                controller: confirmPasswordController,
                obscureText: obscurePassword,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  labelText: "Confirm Password",
                  prefixIcon: const Icon(Icons.password_outlined),
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          obscurePassword = !obscurePassword;
                        });
                      },
                      icon: obscurePassword
                          ? const Icon(Icons.visibility_outlined)
                          : const Icon(Icons.visibility_off_outlined)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please confirm password.";
                  } else if (value != passwordController.text) {
                    return "Passwords do not match.";
                  }
                  return null;
                },
              ),
              SizedBox(height: 40.h),
              BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is AuthResponseState) {
                    state.response.fold(
                      (error) {
                        print(error);
                        var snackBar = SnackBar(
                          content: Text(
                            (error == 'null error')
                                ? 'شما به اینترنت متصل نیستید'
                                : error,
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                              fontFamily: 'dana',
                              fontSize: 14,
                            ),
                          ),
                          duration: const Duration(seconds: 2),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.black,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                      (r) {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const DashboardScreen(),
                        ));
                      },
                    );
                  }
                },
                builder: (context, state) {
                  if (state is AuthInitiateState) {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size.fromHeight(40.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          BlocProvider.of<AuthBloc>(context).add(
                            AuthRegisterRequest(
                              usernameController.text,
                              passwordController.text,
                              confirmPasswordController.text,
                            ),
                          );
                        }
                      },
                      child: const Text("Register"),
                    );
                  }
                  if (state is AuthStateLoading) {
                    return const CircularProgressIndicator();
                  }
                  if (state is AuthResponseState) {
                    return state.response.fold(
                      (error) {
                        return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size.fromHeight(40.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              BlocProvider.of<AuthBloc>(context).add(
                                AuthRegisterRequest(
                                  usernameController.text,
                                  passwordController.text,
                                  confirmPasswordController.text,
                                ),
                              );
                            }
                          },
                          child: const Text("Register"),
                        );
                        // Text(
                        //     error,
                        //     style: const TextStyle(color: Colors.red),
                        //   )
                      },
                      (success) => Text(
                        success,
                        style: const TextStyle(color: Colors.green),
                      ),
                    );
                  }
                  return const Text('Unknown error occurred.');
                },
              ),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Login"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
