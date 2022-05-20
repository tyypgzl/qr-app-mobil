import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qr_new/core/base/base_view.dart';
import 'package:qr_new/feature/auth/register/view_model/register_view_model.dart';
import 'package:qr_new/feature/shared/utils/app_colors.dart';
import 'package:qr_new/feature/shared/widgets/auth_text_field.dart';

class RegisterView extends BaseView<RegisterViewModel> {
  RegisterView({Key? key}) : super(key: key);

  @override
  RegisterViewModel get homeViewModel => RegisterViewModel();

  @override
  Widget? body(BuildContext context, RegisterViewModel viewModel) => Form(
        key: viewModel.formKey,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: -230,
              left: -130,
              child: Transform.rotate(
                angle: 699.3,
                child: SvgPicture.asset(
                  'assets/images/textsvg.svg',
                  color: AppColors.instance.orange,
                  width: 600,
                ),
              ),
            ),

            //Sol Alt
            Positioned(
              bottom: -(screenSize.height * .35),
              left: -(screenSize.width * .41),
              child: SizedBox(
                width: 325,
                child: Image.asset(
                  'assets/images/orange.png',
                  color: AppColors.instance.orange,
                ),
              ),
            ),
            //Sağ Alt
            Positioned(
              bottom: -(screenSize.height * .28),
              right: -(screenSize.width * .32),
              child: SizedBox(
                width: 250,
                child: Image.asset(
                  'assets/images/orange.png',
                  color: AppColors.instance.orange,
                ),
              ),
            ),
            ListView(
              shrinkWrap: true,
              children: [
                SizedBox(
                  height: screenSize.height * .08,
                ),
                Center(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Text(
                      'Kayıt Ol',
                      style: TextStyle(
                          color: AppColors.instance.black,
                          fontSize: 48,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  height: screenSize.height * .07,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: screenSize.height * .57,
                    decoration: BoxDecoration(
                      color: AppColors.instance.orangeAccent,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(50),
                      ),
                    ),
                    child: Center(
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AuthTextField(
                                validator: viewModel.nameValidation,
                                onChanged: (value) =>
                                    viewModel.firstName = value,
                                labelText: 'Ad',
                                keyboardType: TextInputType.name,
                                size: Size(screenSize.width * .47,
                                    screenSize.height * .10),
                              ),
                              AuthTextField(
                                validator: viewModel.lastNameValidation,
                                onChanged: (value) =>
                                    viewModel.lastName = value,
                                labelText: 'Soyad',
                                keyboardType: TextInputType.name,
                                size: Size(screenSize.width * .47,
                                    screenSize.height * .10),
                              ),
                            ],
                          ),
                          AuthTextField(
                            validator: viewModel.mailValidation,
                            onChanged: (value) => viewModel.email = value,
                            labelText: 'E-posta',
                            keyboardType: TextInputType.emailAddress,
                            size: Size(screenSize.width * .89,
                                screenSize.height * .10),
                          ),
                          AuthTextField(
                            validator: viewModel.passwordValidation,
                            onChanged: (value) => viewModel.password = value,
                            labelText: 'Şifre',
                            keyboardType: TextInputType.visiblePassword,
                            size: Size(screenSize.width * .90,
                                screenSize.height * .10),
                            isPassword: true,
                          ),
                          SizedBox(
                            height: screenSize.height * .04,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        AppColors.instance.pink),
                                fixedSize: MaterialStateProperty.all<Size>(
                                  Size(
                                    screenSize.width * .9,
                                    screenSize.height * .06,
                                  ),
                                ),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(28),
                                    ),
                                  ),
                                ),
                                elevation: MaterialStateProperty.all<double>(6),
                              ),
                              onPressed: () =>
                                  viewModel.registerButtonOnTap(context),
                              child: const Text('Kayıt Ol'),
                            ),
                          ),
                          SizedBox(
                            height: screenSize.height * .02,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Zaten bir hesabınız var mı?'),
                              TextButton(
                                onPressed: viewModel.loginButtonOnTap,
                                style: ButtonStyle(
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          AppColors.instance.black),
                                  padding: MaterialStateProperty.all<
                                      EdgeInsetsGeometry>(EdgeInsets.zero),
                                ),
                                child: const Text(
                                  'Giriş Yap',
                                  style: TextStyle(fontWeight: FontWeight.w800),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
}
