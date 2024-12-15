import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/features/home_main/prensentation/pages/plugin_view_page.dart';
import 'package:my_app/widget/primary_scaffold.dart';
import 'package:my_app/widget/primary_text_field.dart';

import '../../../../widget/primary_button.dart';
import '../bloc/sign_in/sign_in_bloc.dart';


class SignInPage extends StatelessWidget {
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=> SignInBloc(),
      child: BlocConsumer<SignInBloc,SignInState>(
        listener: (context, state) {
          if (state is SignInStateSuccess) {
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const PluginViewPage()));
          } else if (state is SignInStateFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        buildWhen: (previous, current) {
          return current is! SignInStateSuccess;
        },
        builder: (context,signInState){
          return PrimaryScaffold(
            headerText: "Login",
            isLogoutEnable: false,
            body: signInState is SignInStateLoading  ?
            const Center(child: CircularProgressIndicator())
                :Column(
              children: [
                const SizedBox(height: 60,),
                PrimaryTextField(controller: _phoneNumberController, hint: "Phone number"),
                if(signInState is SignInStateOTPSent)
                  PrimaryTextField(controller: _otpController, hint: "OTP"),
                const SizedBox(height: 50,),
                PrimaryButton(
                    btnText: signInState is SignInStateOTPSent ? "LOGIN" : "Send OTP",
                    onTap: (){
                      signInState is SignInStateOTPSent ?
                      context.read<SignInBloc>().add(SignInEventInit(
                          verificationCode: _otpController.text,
                          verificationId: signInState.verificationId,
                          phoneNumber:  _phoneNumberController.text
                      ))
                          : context.read<SignInBloc>().add(SignInSentOTPEventInit(
                          phoneNumber:  _phoneNumberController.text
                      ));
                    }
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}