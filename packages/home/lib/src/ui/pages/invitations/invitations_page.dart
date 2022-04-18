import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:home/src/ui/controllers/home_controller.dart';
import 'package:home/src/ui/pages/forms_app_bar.dart';

class InvitationsPage extends StatelessWidget {
  InvitationsPage({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var controller = context.watch<HomeController>();
    controller.clearEmailController();
    return Scaffold(
      appBar: const FormsAppBar(),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: FocusScope.of(context).unfocus,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  Text('Enviar convite para').headline4(),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomTextField(
                    hintText: 'E-mail',
                    controller: controller.emailController,
                    validator: (value) =>
                        (Validations.isAValidEmailAddress(value ?? ''))
                            ? null
                            : 'E-mail inválido',
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  accessTypeDropdown(controller),
                  const SizedBox(
                    height: 16,
                  ),
                  PrimaryButton(
                    text: 'Enviar Convite',
                    loading: controller.isLoading,
                    onPressed: () async {
                      if (_formKey.currentState != null &&
                          _formKey.currentState!.validate()) {
                        await controller.sendInvitation();
                        await Alerts.showMessage(
                            context: context, title: 'Convite enviado!');
                        Navigator.pop(context);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget accessTypeDropdown(HomeController controller) {
    return InputDecorator(
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
        filled: true,
        fillColor: ColorPalette.neutral0,
        labelText: 'Permissão',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<AccessType>(
          isDense: true,
          value: controller.invitationAccess,
          elevation: 2,
          style: TextStyle(
            color: ColorPalette.neutral600,
          ),
          isExpanded: true,
          items: [
            DropdownMenuItem(
              value: AccessType.user,
              child: Text(
                'Usuário',
              ).body1(),
            ),
            DropdownMenuItem(
              value: AccessType.concierge,
              child: Text(
                'Porteiro',
              ).body1(),
            ),
          ],
          onChanged: (value) async {
            if (value != null) controller.changeAccessType(value);
          },
        ),
      ),
    );
  }
}
