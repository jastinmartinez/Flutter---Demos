import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:garbage_collector/view/animation/authenticatio_logo_animation.dart';

import '../../../../data/model/user.dart';
import '../../../../logic/bloc/authentication/authentication_bloc.dart';
import '../../../../logic/bloc/authentication/authentication_event.dart';
import '../../../../logic/bloc/authentication/authentication_state.dart';
import '../../../../utils/app_color.dart';
import '../../../../utils/app_responsive.dart';
import '../../../validation/authentication_validator.dart';
import '../../../widgets/base_input_form_field.dart';

class AuthenticationForm extends StatefulWidget {
  @override
  _AuthenticationFormState createState() => _AuthenticationFormState();
}

class _AuthenticationFormState extends State<AuthenticationForm> {
  bool _isSignUp = false;
  final _formKey = GlobalKey<FormState>();
  final _emailTextEditController = TextEditingController();
  final _passwordTextEditController = TextEditingController();
  final _passwordConfirmationTextEditController = TextEditingController();

  void _submit(AuthenticationBloc authenticationBloc) {
    if (_formKey.currentState.validate()) {
      authenticationBloc.add(
        !_isSignUp
            ? AuthenticationSignedIn(
                user: User(
                  email: _emailTextEditController.text,
                  password: _passwordTextEditController.text,
                ),
              )
            : AuthenticationSignedUp(
                user: User(
                  email: _emailTextEditController.text,
                  password: _passwordTextEditController.text,
                ),
              ),
      );
    }
  }

  @override
  void dispose() {
    _emailTextEditController.dispose();
    _passwordTextEditController.dispose();
    _passwordConfirmationTextEditController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColor.kWhite,
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AuthenticatioLogoAnimation(),
              SizedBox(
                height: AppResponsive(context).hp(3),
              ),
              BaseTextFormField(
                key: ValueKey('email'),
                hintText: 'Correo',
                controller: _emailTextEditController,
                validation: (value) =>
                    AuthenticationValidator.isValidEmail(value),
              ),
              SizedBox(
                height: AppResponsive(context).hp(3),
              ),
              BaseTextFormField(
                key: ValueKey('password'),
                hintText: 'Contraseña',
                controller: _passwordTextEditController,
                validation: (value) =>
                    AuthenticationValidator.isValidPassword(value),
                isObscuredText: true,
              ),
              if (_isSignUp)
                SizedBox(
                  height: AppResponsive(context).hp(3),
                ),
              if (_isSignUp)
                BaseTextFormField(
                  key: ValueKey('password_confirmation'),
                  hintText: 'Confirmar Contraseña',
                  controller: _passwordTextEditController,
                  validation: (value) => AuthenticationValidator.isPasswordSame(
                      _passwordTextEditController.text, value),
                  isObscuredText: true,
                ),
              Switch(
                value: _isSignUp,
                onChanged: (_) {
                  setState(
                    () {
                      _isSignUp = !_isSignUp;
                    },
                  );
                },
              ),
              BlocBuilder<AuthenticationBloc, AuthenticationState>(
                builder: (context, state) {
                  if (state is AuthenticationLoading) {
                    return CircularProgressIndicator(
                      backgroundColor: Colors.blue,
                    );
                  } else {
                    return TextButton(
                      key: ValueKey('authentication_action'),
                      onPressed: () => _submit(
                        BlocProvider.of<AuthenticationBloc>(
                          context,
                        ),
                      ),
                      child: Text(!_isSignUp ? 'Iniciar Sesion' : 'Registrar'),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
