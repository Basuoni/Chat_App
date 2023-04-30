import 'dart:io';
import 'package:animate_do/animate_do.dart';
import 'package:chat_app/src/Features/auth/data/models/user_model.dart';
import 'package:chat_app/src/Features/auth/presentation/manager/auth_cubit.dart';
import 'package:chat_app/src/config/app_route.dart';
import 'package:chat_app/src/core/components/app_button.dart';
import 'package:chat_app/src/core/components/app_textfield.dart';
import 'package:chat_app/src/core/utils/app_assets.dart';
import 'package:chat_app/src/core/utils/extension_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

class InformationScreen extends StatelessWidget {
  InformationScreen({Key? key, required this.userModel}) : super(key: key);

  final UserModel userModel;
  XFile? _image;
  bool _nameIsView = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is DoneAuthState) {
            Navigator.pushNamed(context, AppRoute.homeScreen,
                arguments: state.userModel);
          }
          if (state is ErrorAuthState) {
            context.showTopSnackBar(
                isError: true, title: "Verification", mess: state.message);
          }
        },
        builder: (context, state) => buildBody(context),
        buildWhen: (previous, current) => current is ScreenChangedAuthState,
      ),
    );
  }

  WillPopScope buildBody(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    return WillPopScope(
        child: Scaffold(
          body: SingleChildScrollView(
            child: SafeArea(
              child:
              _nameIsView ? createName(authCubit) : createImage(authCubit),
            ),
          ),
        ),
        onWillPop: () async {
          if (_nameIsView) {
            return true;
          } else {
            _nameIsView = true;
            authCubit.screenChanged();
            return false;
          }
        });
  }

  Widget createName(AuthCubit authCubit) {
    _nameIsView = true;

    authCubit.nameController.text = userModel.name;

    return FadeInDown(
        child: Column(
          children: [
            const SizedBox(height: 70),
            const Text(
              '1 of 2',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              (userModel.name.isEmpty
                  ? 'Enter Your Name'
                  : 'You can edit your name'),
              style: const TextStyle(fontSize: 22, color: Colors.black),
            ),
            const SizedBox(height: 10),
            const Text(
              'Get more people to know your name',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20),
            AppTextField(
                hint: "Name",
                prefixIcon: Icons.person_outline,
                txtController: authCubit.nameController),
            AppButton(
                text: "Next",
                onPressed: () {
                  _nameIsView = false;
                  authCubit.screenChanged();
                })
          ],
        ));
  }

  Widget createImage(AuthCubit authCubit) {
    return FadeInDown(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              const SizedBox(height: 70),
              const Text(
                '2 of 2',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Upload your photo',
                style: TextStyle(fontSize: 22, color: Colors.black),
              ),
              const SizedBox(height: 10),
              const Text(
                'Get more people to know you better',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 20),
              BlocBuilder<AuthCubit, AuthState>(
                buildWhen: (previous, current) => (current is RefreshAuthState),
                builder: (context, state) {
                  return InkWell(
                    onTap: () async {
                      _image = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);
                      authCubit.refreshImage();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: imageState(image: _image, userModel: userModel),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              BlocBuilder<AuthCubit, AuthState>(
                  buildWhen: (previous,
                      current) => (current is RefreshAuthState),
                  builder: (context, state) {
                    return AppButton(
                        isLoading: authCubit.isLoading,
                        text: _image == null ? "Skip" : "Submit",
                        onPressed: () {
                          authCubit.addUser(
                              image: _image, phone: userModel.phoneNumber);
                        });
                  })
            ],
          ),
        ));
  }

  imageState({XFile? image, required UserModel userModel}) {
    if(_image != null ){
      return  Image.file(
        File(_image!.path),
        fit: BoxFit.cover,
        width: 150,
        height: 150,
      );
    }
    if(userModel.image.isNotEmpty && _image == null ){
      return Image.network(userModel.image,width: 150,height: 150, fit: BoxFit.cover,);
    }

    if (_image == null && userModel.image.isEmpty) {
      return SvgPicture.asset(
        AppAssets.imgInputImage, width: 150, height: 150,);
    }
  }
}
