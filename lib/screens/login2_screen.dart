import 'package:aplle_shop_pj/screens/dashboard_screen.dart';
import 'package:aplle_shop_pj/screens/register_screen2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aplle_shop_pj/data/bloc/auth_bloc.dart';
import 'package:aplle_shop_pj/data/bloc/auth_event.dart';
import 'package:aplle_shop_pj/data/bloc/auth_state.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen2 extends StatefulWidget {
  const LoginScreen2({super.key});

  @override
  State<LoginScreen2> createState() => _LoginScreen2State();
}

class _LoginScreen2State extends State<LoginScreen2> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
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
                "Welcome back",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              SizedBox(height: 10.h),
              Text(
                "Login to your account",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: 40.h),
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
                        : const Icon(Icons.visibility_off_outlined),
                  ),
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
                  }
                  return null;
                },
              ),
              SizedBox(height: 40.h),
              BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is AuthResponseState) {
                    state.response.fold(
                        //this is print Falled to create record
                        (l) {
                      print(l);
                      var snackBar = SnackBar(
                        content: Text(
                            (l == 'null error')
                                ? 'شما به اینترنت متصل نیستید'
                                : l,
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                                fontFamily: 'dana', fontSize: 14)),
                        duration: const Duration(seconds: 2),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.black,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }, (r) async {
                      print(r);

                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const DashboardScreen(),
                        ),
                      );
                    });
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
                            AuthLoginRequest(
                              usernameController.text,
                              passwordController.text,
                            ),
                          );
                        }
                      },
                      child: const Text("Login"),
                    );
                  }
                  if (state is AuthStateLoading) {
                    return const CircularProgressIndicator();
                  }
                  if (state is AuthResponseState) {
                    return state.response.fold(
                      //this is text Falled to create record
                      //not have widget 537 == 5:00
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
                                AuthLoginRequest(
                                  usernameController.text,
                                  passwordController.text,
                                ),
                              );
                            }
                          },
                          child: const Text("Login"),
                        );
                        // Text(
                        //   error,
                        //   style: const TextStyle(color: Colors.red),
                        // );
                      },
                      (success) => Text(
                        success,
                        style: const TextStyle(color: Colors.green),
                      ),
                    );
                  }
                  return const Text('Unknown error occurred');
                },
              ),
              SizedBox(height: 15.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return const RegisterScreen2();
                        },
                      ));
                    },
                    child: const Text("Signup"),
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
