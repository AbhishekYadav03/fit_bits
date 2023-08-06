import 'package:fit_bits/feature/auth/auth_form.dart';
import 'package:fit_bits/feature/auth/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Authentication'),
      ),
      body: BlocBuilder<AuthCubit, AuthStatus>(
        builder: (context, state) {
          if (state == AuthStatus.initial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state == AuthStatus.authenticated) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Logged in successfully!'),
                  ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<AuthCubit>(context).signOut();
                    },
                    child: const Text('Sign Out'),
                  ),
                ],
              ),
            );
          } else if (state == AuthStatus.unauthenticated) {
            return const AuthForm();
          }
          return Container();
        },
      ),
    );
  }
}
