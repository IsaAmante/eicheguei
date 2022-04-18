import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:home/src/ui/controllers/home_controller.dart';
import 'package:home/src/ui/pages/custom_app_bar.dart';

class AddOrderPage extends StatefulWidget {
  const AddOrderPage({Key? key}) : super(key: key);

  @override
  State<AddOrderPage> createState() => _AddOrderPageState();
}

class _AddOrderPageState extends State<AddOrderPage> {
  late HomeController controller;

  @override
  void initState() {
    super.initState();
    controller = context.read<HomeController>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(children: [
            CustomTextField(),
            const SizedBox(height: 16),
          ]),
        ),
      ),
    );
  }
}
