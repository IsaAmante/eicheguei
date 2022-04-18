import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:home/src/ui/controllers/home_controller.dart';
import 'package:home/src/ui/pages/forms_app_bar.dart';

class InvitationsPage extends StatelessWidget {
  const InvitationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = context.read<HomeController>();
    return Scaffold(
      appBar: const FormsAppBar(),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: FocusScope.of(context).unfocus,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              children: [
                const SizedBox(height: 24),
                Text('Enviar convite para').headline4(),
                const SizedBox(
                  height: 16,
                ),
                CustomTextField(
                  hintText: 'E-mail',
                ),
                const SizedBox(
                  height: 16,
                ),
                accessTypeDropdown(),
                const SizedBox(
                  height: 16,
                ),
                PrimaryButton(
                  text: 'Enviar Convite',
                  onPressed: () async {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget accessTypeDropdown() {
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
        child: DropdownButton<int>(
          isDense: true,
          value: 0,
          elevation: 2,
          style: TextStyle(
            color: ColorPalette.neutral600,
          ),
          isExpanded: true,
          items: [
            DropdownMenuItem(
              value: 0,
              child: Text(
                'Usuário',
              ).body1(),
            ),
            DropdownMenuItem(
              value: 1,
              child: Text(
                'Porteiro',
              ).body1(),
            ),
          ],
          onChanged: (value) async {},
        ),
      ),
    );
  }
}
