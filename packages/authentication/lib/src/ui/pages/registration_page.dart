import 'package:authentication/src/ui/controllers/registration_controller.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  bool acceptedTerms = false;
  @override
  Widget build(BuildContext context) {
    var controller = context.read<RegistrationController>();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back,
              color: ColorPalette.neutral400,
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: FocusScope.of(context).unfocus,
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  children: [
                    const SizedBox(height: 24),
                    Text('Forneça as informações do condomínio:').headline4(),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomTextField(
                      hintText: 'Nome',
                      controller: controller.nameController,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomTextField(
                      hintText: 'Endereço',
                      controller: controller.addressController,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomTextField(
                      hintText: 'Telefone',
                      controller: controller.phoneController,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: acceptedTerms,
                          onChanged: (value) {
                            if (value != null) {
                              setState(() {
                                acceptedTerms = value;
                              });
                            }
                          },
                        ),
                        Expanded(
                          child: const Text(
                                  'Estou de acordo com os Termos de Uso e Política de Privacidade')
                              .body3(),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    PrimaryButton(
                      text: 'Cadastrar Responsável',
                      enabled: acceptedTerms,
                      onPressed: () async {
                        if (await controller.checkForExistingUser()) {
                          showDialog(
                            context: context,
                            builder: (dialogContext) => WillPopScope(
                              onWillPop: () async {
                                controller.cancelGoogleUser();
                                return true;
                              },
                              child: AlertDialog(
                                content: Text(
                                  'Este usuário já está cadastrado em outro condomínio. Caso deseje prosseguir, as informações atualmente associadas a ele serão perdidas.',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      controller.cancelGoogleUser();
                                      Navigator.pop(dialogContext);
                                    },
                                    child: Text('CANCELAR'),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      Navigator.pop(dialogContext);
                                      await controller.registerCondominium();
                                      Navigator.pop(context);
                                    },
                                    child: Text('PROSEGUIR'),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                      },
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Center(
                      child: Image.asset(
                        'assets/eicheguei_logo_mini.png',
                        height: 100,
                        width: 100,
                      ),
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
