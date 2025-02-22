import 'package:aplle_shop_pj/constants/color.dart';
import 'package:aplle_shop_pj/data/bloc/auth_bloc.dart';
import 'package:aplle_shop_pj/data/bloc/auth_event.dart';
import 'package:aplle_shop_pj/data/bloc/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  final usernameController = TextEditingController(text: 'yasinxxx7');
  final passwordController = TextEditingController(text: '12345678');
  final passwordConfirmController = TextEditingController(text: '12345678');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.blue,
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
              child: Column(
            children: [
              Image.asset(
                'assets/images/icon_application.png',
                height: 100,
                width: 100,
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                'apple shop',
                style: TextStyle(
                    fontSize: 22, color: Colors.white, fontFamily: 'sb'),
              )
            ],
          )),
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: usernameController,
                          decoration: const InputDecoration(
                              labelText: 'نام کاربری',
                              labelStyle: TextStyle(
                                fontFamily: 'sm',
                                fontSize: 18,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                borderSide:
                                    BorderSide(color: Colors.black, width: 2),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                borderSide: BorderSide(
                                    color: CustomColor.blue, width: 3),
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: passwordController,
                          decoration: const InputDecoration(
                              labelText: 'رمز عبور',
                              labelStyle: TextStyle(
                                fontFamily: 'sm',
                                fontSize: 18,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                borderSide:
                                    BorderSide(color: Colors.black, width: 2),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                borderSide: BorderSide(
                                    color: CustomColor.blue, width: 3),
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: passwordConfirmController,
                          decoration: const InputDecoration(
                              labelText: 'تکرار رمز عبور',
                              labelStyle: TextStyle(
                                fontFamily: 'sm',
                                fontSize: 18,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                borderSide:
                                    BorderSide(color: Colors.black, width: 2),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                borderSide: BorderSide(
                                    color: CustomColor.blue, width: 3),
                              )),
                        ),
                      ),
                      const SizedBox(height: 10),
                      BlocBuilder<AuthBloc, AuthState>(
                        builder: ((context, state) {
                          if (state is AuthInitiateState) {
                            return ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    minimumSize: const Size(200, 45),
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    backgroundColor: Colors.blue[300]),
                                onPressed: () {
                                  BlocProvider.of<AuthBloc>(context).add(
                                      AuthRegisterRequest(
                                          usernameController.text,
                                          passwordController.text,
                                          passwordConfirmController.text));
                                },
                                child: const Text(
                                  'ثبت نام',
                                  style: TextStyle(
                                      fontFamily: 'sb',
                                      color: Colors.white,
                                      fontSize: 24),
                                ));
                          }
                          if (state is AuthStateLoading) {
                            return const CircularProgressIndicator();
                          }
                          if (state is AuthResponseState) {
                            Text widget = const Text('');

                            state.response.fold((l) {
                              widget = Text(l);
                            }, (r) {
                              widget = Text(r);
                            });
                            return widget;
                          }
                          return const Text('خطای نامشخص');
                        }),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          )
        ],
      )),
    );
  }
}
