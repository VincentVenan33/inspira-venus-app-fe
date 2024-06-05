import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:venus/core/app_constants/route.dart';
import 'package:venus/core/networks/authentication_network.dart';
import 'package:venus/core/services/authentication_service.dart';
import 'package:venus/core/services/navigation_service.dart';
import 'package:venus/core/services/shared_preferences_service.dart';
import 'package:venus/core/utilities/text_styles.dart';
import 'package:venus/core/view_models/authentication/login_view_model.dart';
import 'package:venus/core/view_models/view_model.dart';
import 'package:venus/ui/shared/loading_overlay.dart';
import 'package:venus/ui/shared/spacings.dart';
import 'package:venus/ui/shared/unfocus_helper.dart';
import 'package:venus/ui/widgets/buttons.dart';
import 'package:venus/ui/widgets/text_inputs.dart';

class LoginViewParam {
  LoginViewParam({
    this.tokenFCM,
  });

  final String? tokenFCM;
}

class LoginView extends ConsumerStatefulWidget {
  const LoginView({
    required this.param,
    Key? key,
  }) : super(key: key);

  final LoginViewParam param;

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final FocusNode _focus = FocusNode();
  @override
  Widget build(BuildContext context) {
    return ViewModel<LoginViewModel>(
        model: LoginViewModel(
          // dioService: ref.read(dioProvider),
          sharedPreferencesService: ref.read(sharedPrefProvider),
          navigationService: ref.read(navigationProvider),
          authenticationApi: ref.read(authenticationApi),
          authenticationService: ref.read(authProvider),
        ),
        builder: (_, LoginViewModel model, __) {
          return LoadingOverlay(
              isLoading: model.busy,
              child: UnfocusHelper(
                child: Scaffold(
                  body: SingleChildScrollView(
                    child: SafeArea(
                      child: Column(
                        children: <Widget>[
                          Image.asset(
                            'assets/images/bg_atas.png',
                            width: double.infinity,
                          ),
                          Stack(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 120,
                                    ),
                                    child: Image.asset(
                                      'assets/images/bg_tengah.png',
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/icons/pt_venus_ceramica_indonesia_logo.png',
                                  ),
                                ],
                              ),
                            ],
                          ),
                          // Spacings.verSpace(106),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                venusTextInput(
                                  controller: model.usernameController,
                                  hintText: 'Masukkan User',
                                  label: 'User',
                                ),
                                Spacings.verSpace(17.5),
                                venusTextInput(
                                  controller: model.passwordController,
                                  enableFocusBorder: true,
                                  enableObscureText: true,
                                  focusNode: _focus,
                                  hintText: 'Masukkan Password',
                                  label: 'Password',
                                ),
                                Spacings.verSpace(30.5),
                                Button(
                                  buttonType: ButtonType.primary,
                                  buttonSize: ButtonSize.large,
                                  text: 'Login',
                                  onTap: () async {
                                    debugPrint("${model.usernameController.text} data kode");
                                    debugPrint("${model.passwordController.text} data sandi");

                                    // ignore: unused_local_variable
                                    String usernameText = model.usernameController.text;
                                    // ignore: unused_local_variable
                                    String passwordText = model.passwordController.text;

                                    // print(passwordText.isNotEmpty);
                                    // if (usernameText == 'sales' && passwordText.isNotEmpty) {
                                    //   Navigator.pushNamed(
                                    //     context,
                                    //     Routes.navBarSales,
                                    //   );
                                    // } else if (usernameText == 'owner' && passwordText.isNotEmpty) {
                                    //   Navigator.pushNamed(
                                    //     context,
                                    //     Routes.navBarOwner,
                                    //   );
                                    // }
                                    // Navigator.pushNamed(
                                    //   context,
                                    //   Routes.navBarOwner,
                                    // // );
                                    // Navigator.pushNamed(
                                    //   context,
                                    //   Routes.navBarSales,
                                    // );
                                    if (model.usernameController.text.isEmpty ||
                                        model.passwordController.text.isEmpty) {
                                      // handle required field
                                      return;
                                    }

                                    final bool response = await model.requestLogin();

                                    if (response && mounted) {
                                      Navigator.pushNamed(
                                        // ignore: use_build_context_synchronously
                                        context,
                                        Routes.navBarSales,
                                      );
                                    } else {
                                      // Handle login failed
                                      showErrorToast('Username/Password Salah!');
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                          Spacings.verSpace(50),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset(
                                'assets/images/bg_bawah.png',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ));
        });
  }

  void showErrorToast(String text) {
    BotToast.showSimpleNotification(
      title: text,
      backgroundColor: const Color(0xffEA6767),
      hideCloseButton: true,
      titleStyle: buildTextStyle(
        fontSize: 14,
        fontWeight: 400,
        color: Colors.white,
      ),
    );
  }
}
