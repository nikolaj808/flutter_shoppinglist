import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shoppinglist/login/login_cubit.dart';
import 'package:flutter_shoppinglist/login/widgets/center_logo_widget.dart';
import 'package:flutter_shoppinglist/login/widgets/google_login_button_widget.dart';
import 'package:flutter_shoppinglist/login/widgets/header_widget.dart';
import 'package:flutter_shoppinglist/providers/repositories/authentication/authentication_repository.dart';
import 'package:flutter_shoppinglist/shared/common_snackbar.dart';
import 'package:formz/formz.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(context.read<AuthenticationRepository>()),
      child: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state.status.isSubmissionFailure) {
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                CommonSnackBar.error('Login fejlede, prøv igen'),
              );
          }
        },
        child: Scaffold(
          body: SafeArea(
            child: Stack(
              fit: StackFit.expand,
              children: const [
                HeaderWidget(),
                CenterLogoWidget(),
                GoogleLoginButtonWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
