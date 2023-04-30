import 'package:animate_do/animate_do.dart';
import 'package:chat_app/src/Features/auth/data/models/user_model.dart';
import 'package:chat_app/src/Features/auth/presentation/manager/auth_cubit.dart';
import 'package:chat_app/src/config/app_route.dart';
import 'package:chat_app/src/core/components/app_button.dart';
import 'package:chat_app/src/core/utils/app_assets.dart';
import 'package:chat_app/src/core/utils/extension_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

class VerificationScreenArg {
  String verificationId;
  String phoneNumber;

  VerificationScreenArg({
    required this.verificationId,
    required this.phoneNumber,
  });
}

class VerificationScreen extends StatelessWidget {
  final VerificationScreenArg arguments;

  const VerificationScreen({Key? key, required this.arguments})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => AuthCubit(),
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is DoneAuthState) {
              Navigator.pushNamed(context, AppRoute.informationScreen,
                  arguments: state.userModel ?? UserModel(
                    name: "",
                    phoneNumber: arguments.phoneNumber,
                    image: "",
                  ));
            }
            if (state is ErrorAuthState) {
              context.showTopSnackBar(
                  isError: true, title: "Verification", mess: state.message);
            }
          },
          builder: (context, state) => buildBody(context),
          buildWhen: (previous, current) => false,
        ),
      ),
    );
  }

  Widget buildBody(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    final TextEditingController pinCode = TextEditingController();
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 40),
            Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                width: double.infinity,
                height: 150,
                child: SvgPicture.asset(AppAssets.imgVerification)),
            const SizedBox(height: 10),
            const Text(
              'Enter code',
              style: TextStyle(fontSize: 22, color: Colors.black),
            ),
            const SizedBox(height: 10),
            const Text(
              'You will receive a message through the number you entered',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey,
              ),
            ),
            FadeInDown(
              duration: const Duration(milliseconds: 500),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    return PinCodeTextField(
                      autofocus: true,
                      controller: pinCode,
                      defaultBorderColor: Colors.black,
                      hasTextBorderColor: Colors.green,
                      maxLength: 6,
                      onTextChanged: (text) {
                        authCubit.onPinChanged();
                      },
                      onDone: (text) {},
                      pinBoxWidth: 40,
                      pinBoxHeight: 50,
                      wrapAlignment: WrapAlignment.spaceAround,
                      pinBoxDecoration:
                          ProvidedPinBoxDecoration.underlinedPinBoxDecoration,
                      pinTextStyle: const TextStyle(fontSize: 22.0),
                      pinTextAnimatedSwitcherTransition:
                          ProvidedPinBoxTextAnimation.scalingTransition,
                      pinTextAnimatedSwitcherDuration:
                          const Duration(milliseconds: 300),
                      highlightAnimationBeginColor: Colors.black,
                      highlightAnimationEndColor: Colors.white12,
                      keyboardType: TextInputType.number,
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            BlocBuilder<AuthCubit, AuthState>(
              buildWhen: (previous, current) => current is! PinChangedAuthState,
              builder: (context, state) {
                return AppButton(
                    isLoading: authCubit.isLoading,
                    text: "Verification",
                    onPressed: () {
                      authCubit.verificationCode(
                        code: pinCode.text,
                        verificationId: arguments.verificationId,
                        phoneNumber: arguments.phoneNumber,
                      );
                    });
              },
            )
          ],
        ),
      ),
    );
  }
}
