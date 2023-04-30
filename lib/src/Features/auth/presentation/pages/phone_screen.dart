import 'dart:developer';

import 'package:animate_do/animate_do.dart';
import 'package:chat_app/src/Features/auth/presentation/manager/auth_cubit.dart';
import 'package:chat_app/src/Features/auth/presentation/pages/verification_screen.dart';
import 'package:chat_app/src/config/app_route.dart';
import 'package:chat_app/src/core/components/app_button.dart';
import 'package:chat_app/src/core/utils/app_assets.dart';
import 'package:chat_app/src/core/utils/extension_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class PhoneScreen extends StatelessWidget {
  const PhoneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthState>(
        builder: (context, state) => buildScaffold(context),
        buildWhen: (previous, current) => false,
        listener: (context, state) {
          if (state is DoneSendState) {
            Navigator.pushNamed(
              context,
              AppRoute.verificationScreen,
              arguments: VerificationScreenArg(
                verificationId: state.verificationId,
                phoneNumber: state.phoneNumber,
              ),
            );
          }
          if (state is ErrorAuthState) {
            context.showTopSnackBar(
                isError: true, title: "Phone Number", mess: state.message);
          }
        },
      ),
    );
  }

  Scaffold buildScaffold(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    log("message");
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 30),
                SizedBox(
                  height: 150,
                  child: SvgPicture.asset(AppAssets.imgVerification),
                ),
                const Text("Enter Your Phone Number",
                    style: TextStyle(fontSize: 20, color: Colors.black)),
                const SizedBox(height: 10),
                const Text(
                  "Please confirm your region and enter your phone number.",
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
                FadeInDown(
                    duration: const Duration(microseconds: 500),
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 10),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border:
                            Border.all(color: Colors.black.withOpacity(0.13)),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0xffeeeeee),
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: InternationalPhoneNumberInput(
                        onInputChanged: (PhoneNumber number) {
                          log(number.phoneNumber!);
                          if (!authCubit.isLoading) {
                            authCubit.phoneController.text =
                                number.phoneNumber!;
                          }
                        },
                        onInputValidated: (bool value) {
                          log(value.toString());
                        },
                        selectorConfig: const SelectorConfig(
                          selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                        ),
                        ignoreBlank: false,
                        autoValidateMode: AutovalidateMode.disabled,
                        selectorTextStyle: const TextStyle(color: Colors.black),

                        formatInput: false,
                        maxLength: 11,
                        keyboardType: const TextInputType.numberWithOptions(
                            signed: true, decimal: true),
                        cursorColor: Colors.black,
                        inputDecoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.only(bottom: 15, left: 0),
                          border: InputBorder.none,
                          hintText: 'Phone Number',
                          hintStyle: TextStyle(
                              color: Colors.grey.shade500, fontSize: 16),
                        ),
                        onSaved: (PhoneNumber number) {
                          log('On Saved: $number');
                        },
                      ),
                    )),
                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    return AppButton(
                        isLoading: authCubit.isLoading,
                        text: "Send Code",
                        onPressed: () {
                          // Navigator.pushNamed(context, AppRoute.verificationScreen);
                          authCubit.sendCode();
                        });
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
