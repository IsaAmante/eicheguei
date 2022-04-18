import 'package:authentication/src/ui/controllers/auth_controller.dart';
import 'package:authentication/src/ui/pages/registration_page.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
    context.read<AuthController>().signInSilently();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: FocusScope.of(context).unfocus,
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      child: const Logo(),
                    ),
                    const SizedBox(height: 24),
                    CustomTextField(
                      hintText: 'E-mail',
                      prefixIcon: Icon(
                        Icons.email_rounded,
                        color: ColorPalette.neutral300,
                      ),
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      hintText: 'Senha',
                      prefixIcon: Icon(
                        Icons.lock_rounded,
                        color: ColorPalette.neutral300,
                      ),
                    ),
                    const SizedBox(height: 24),
                    PrimaryButton(
                      onPressed: () {},
                      text: 'Entrar com e-mail e senha',
                    ),
                    const SizedBox(height: 8),
                    PrimaryButton(
                      onPressed: () async {
                        await context.read<AuthController>().signInWithGoogle();
                      },
                      text: 'Entrar com Google',
                    ),
                    const SizedBox(height: 8),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const RegistrationPage(),
                        ));
                      },
                      child: const Text('Cadastrar condomínio').body3(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
