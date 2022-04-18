import 'package:authentication/authentication.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:home/src/ui/controllers/home_controller.dart';
import 'package:home/src/ui/pages/custom_app_bar.dart';
import 'package:home/src/ui/pages/invitations/invitations_page.dart';
import 'package:home/src/ui/pages/tab_app_bar.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage>
    with SingleTickerProviderStateMixin {
  late HomeController controller;
  TextEditingController textController = TextEditingController();
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    controller = context.read<HomeController>();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      controller.iniltializeOrders();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<HomeController>();
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: TabAppBar(
          controller: tabController,
        ),
        drawer: Drawer(
          backgroundColor: ColorPalette.neutral0,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 32,
                ),
                Text('Olá, ${controller.userService.user?.name ?? ''}!')
                    .headline3(),
                const Spacer(),
                Row(
                  children: [
                    LogoutButton(
                      iconColor: ColorPalette.secondaryColor,
                    ),
                    Text(
                      'Sair',
                      style: TextStyle(
                        color: ColorPalette.secondaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        body: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: TabBarView(
            controller: tabController,
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      DashboardButton(
                        title: 'Condomínio',
                        text: 'Edite as informações do seu condomínio',
                        icon: Icons.apartment_rounded,
                        onTap: () {},
                      ),
                      DashboardButton(
                        title: 'Empresas',
                        text: 'Gerencie as empresas do seu condomínio',
                        icon: Icons.add_business_rounded,
                        onTap: () {},
                      ),
                      DashboardButton(
                        title: 'Porteiros',
                        text:
                            'Gerencie os porteiros que podem atender no seu condomínio',
                        icon: Icons.notifications_rounded,
                        onTap: () {},
                      ),
                      DashboardButton(
                        title: 'Convites',
                        text:
                            'Envie convites para as pessoas que fazem parte do seu condomínio',
                        icon: Icons.group_add_rounded,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) =>
                                  InvitationsPage(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    stream: controller.orderStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        controller.snapshotToOrdersList(snapshot.data!);
                        return Column(
                          children: [
                            for (int i = 0; i < controller.orders.length; i++)
                              Dismissible(
                                key: UniqueKey(),
                                onDismissed: (direction) async {
                                  if (direction ==
                                      DismissDirection.startToEnd) {
                                  } else if (direction ==
                                      DismissDirection.endToStart) {
                                    controller.deleteOrder(i);
                                  }
                                },
                                secondaryBackground: Card(
                                  color: ColorPalette.error,
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Icon(
                                        Icons.delete_forever_rounded,
                                        color: ColorPalette.neutral0,
                                        size: 28,
                                      ),
                                    ),
                                  ),
                                ),
                                background: Card(
                                  color: ColorPalette.miscLime,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Icon(
                                        Icons.check_circle_outline_rounded,
                                        color: ColorPalette.neutral0,
                                      ),
                                    ),
                                  ),
                                ),
                                child: GestureDetector(
                                  onLongPress: () {
                                    controller.toogleEditingMode();
                                  },
                                  child: Card(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0,
                                        vertical: 24.0,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          if (controller.isEditing) ...[
                                            Checkbox(
                                              value:
                                                  controller.orders[i].selected,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(4)),
                                              visualDensity:
                                                  const VisualDensity(
                                                horizontal: VisualDensity
                                                    .minimumDensity,
                                                vertical: VisualDensity
                                                    .minimumDensity,
                                              ),
                                              onChanged: (value) {
                                                controller.selectOrder(
                                                    i, value);
                                              },
                                            ),
                                            const SizedBox(width: 12),
                                          ],
                                          if (controller
                                                  .orders[i].description !=
                                              null) ...[
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(controller
                                                        .orders[i].description!)
                                                    .headline4(),
                                                const SizedBox(height: 8),
                                                Text(
                                                  DateTimeUtils
                                                      .getFormmatedDate(
                                                          controller
                                                              .orders[i].date),
                                                ).body2(
                                                  style: TextStyle(
                                                    color:
                                                        ColorPalette.neutral300,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const Spacer(),
                                            SizedBox(
                                              width: 70,
                                              child: getStatusIcon(
                                                  controller.orders[i].status),
                                            ),
                                          ] else ...[
                                            Expanded(
                                              child: TextFormField(
                                                controller: textController,
                                                style: TextStyle(
                                                  decoration:
                                                      TextDecoration.none,
                                                  fontSize: 16.0,
                                                  fontStyle: FontStyle.normal,
                                                  color:
                                                      ColorPalette.neutral600,
                                                ),
                                                decoration: InputDecoration(
                                                  suffixIcon: GestureDetector(
                                                    onTap: () async {
                                                      if (textController
                                                          .text.isNotEmpty) {
                                                        await controller
                                                            .addOrder(
                                                                textController
                                                                    .text);
                                                        textController.clear();
                                                      }
                                                    },
                                                    child: Icon(
                                                      Icons.add,
                                                      color: ColorPalette
                                                          .neutral300,
                                                    ),
                                                  ),
                                                  hintText:
                                                      'Digite a descrição',
                                                ),
                                                onFieldSubmitted:
                                                    (value) async {
                                                  if (value.isNotEmpty) {
                                                    await controller
                                                        .addOrder(value);
                                                    textController.clear();
                                                  }
                                                },
                                              ),
                                            ),
                                          ],
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        );
                      }
                      return Container();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getStatusIcon(OrderStatus status) {
    switch (status) {
      case OrderStatus.waiting:
        return Column(
          children: [
            Icon(
              Icons.watch_later_rounded,
              color: ColorPalette.neutral100,
            ),
            const SizedBox(height: 2),
            Text('Aguardando').overline(
                style: TextStyle(
              color: ColorPalette.neutral100,
            )),
          ],
        );
      case OrderStatus.pending:
        return Column(
          children: [
            Icon(
              Icons.notifications_active_rounded,
              color: ColorPalette.miscYellow,
            ),
            const SizedBox(height: 2),
            Text('Cheguei!').overline(
                style: TextStyle(
              color: ColorPalette.miscYellow,
            )),
          ],
        );
      case OrderStatus.delivered:
        return Column(
          children: [
            Icon(
              Icons.verified_rounded,
              color: ColorPalette.miscLime,
            ),
            const SizedBox(height: 2),
            Text('Retirado').overline(
                style: TextStyle(
              color: ColorPalette.miscLime,
            )),
          ],
        );
    }
  }
}

class DashboardButton extends StatelessWidget {
  const DashboardButton({
    Key? key,
    required this.title,
    required this.text,
    required this.icon,
    this.onTap,
  }) : super(key: key);

  final String title, text;
  final IconData icon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
          color: ColorPalette.neutral0,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              children: [
                Icon(icon, color: ColorPalette.primaryColor, size: 40),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title).headline4(),
                      const SizedBox(height: 8),
                      Text(text).body3(),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
