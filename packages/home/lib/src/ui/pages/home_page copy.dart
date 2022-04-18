import 'dart:developer';

import 'package:authentication/authentication.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:home/src/ui/controllers/home_controller.dart';
import 'package:home/src/ui/pages/custom_app_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  late HomeController controller;
  TextEditingController textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller = context.read<HomeController>();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      controller.iniltializeOrders();
    });
  }

  @override
  Widget build(BuildContext context) {
    context.watch<HomeController>();
    return WillPopScope(
      onWillPop: () async {
        if (controller.isEditing) {
          controller.toogleEditingMode();
        }
        return false;
      },
      child: Scaffold(
        appBar: CustomAppBar(),
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
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: (controller.isProfileComplete)
                ? ListView(
                    children: [
                      // if (controller.isEditing)
                      //   Row(
                      //     children: [
                      //       const SizedBox(width: 12),
                      //       Checkbox(
                      //         value: false,
                      //         onChanged: (value) {},
                      //       ),
                      //       Text('Selecionar todos').body1(),
                      //     ],
                      //   ),
                      for (int i = 0; i < controller.orders.length; i++)
                        Dismissible(
                          key: UniqueKey(),
                          onDismissed: (direction) async {
                            if (direction == DismissDirection.startToEnd) {
                            } else if (direction ==
                                DismissDirection.endToStart) {
                              controller.deleteOrder(i);
                              // await showDialog<void>(
                              //     context: context,
                              //     builder: (context) => AlertDialog(
                              //           title: Text(
                              //               'Deseja mesmo excluir o pedido ${controller.orders[i].description}?'),
                              //           actions: [
                              //             TextButton(
                              //               onPressed: () {
                              //                 Navigator.pop(context);
                              //                 setState(() {});
                              //               },
                              //               child: Text('CANCELAR'),
                              //             ),
                              //             TextButton(
                              //               onPressed: () async {
                              //                 controller.deleteOrder(i);
                              //                 Navigator.pop(context);
                              //               },
                              //               child: Text('EXCLUIR'),
                              //             ),
                              //           ],
                              //         ));
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
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    if (controller.isEditing) ...[
                                      Checkbox(
                                        value: controller.orders[i].selected,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(4)),
                                        visualDensity: const VisualDensity(
                                          horizontal:
                                              VisualDensity.minimumDensity,
                                          vertical:
                                              VisualDensity.minimumDensity,
                                        ),
                                        onChanged: (value) {
                                          controller.selectOrder(i, value);
                                        },
                                      ),
                                      const SizedBox(width: 12),
                                    ],
                                    if (controller.orders[i].description !=
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
                                            DateTimeUtils.getFormmatedDate(
                                                controller.orders[i].date),
                                          ).body2(
                                            style: TextStyle(
                                              color: ColorPalette.neutral300,
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
                                            decoration: TextDecoration.none,
                                            fontSize: 16.0,
                                            fontStyle: FontStyle.normal,
                                            color: ColorPalette.neutral600,
                                          ),
                                          decoration: InputDecoration(
                                            suffixIcon: GestureDetector(
                                              onTap: () async {
                                                if (textController
                                                    .text.isNotEmpty) {
                                                  await controller.addOrder(
                                                      textController.text);
                                                  textController.clear();
                                                }
                                              },
                                              child: Icon(
                                                Icons.add,
                                                color: ColorPalette.neutral300,
                                              ),
                                            ),
                                            hintText: 'Digite a descrição',
                                          ),
                                          onFieldSubmitted: (value) async {
                                            if (value.isNotEmpty) {
                                              await controller.addOrder(value);
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
                  )
                : Center(
                    child: Column(
                      children: [
                        const Spacer(flex: 2),
                        Stack(
                          alignment: AlignmentDirectional.center,
                          children: [
                            Icon(
                              Icons.map,
                              size: 60,
                              color: ColorPalette.neutral400,
                            ),
                            Icon(
                              Icons.place,
                              size: 20,
                              color: ColorPalette.neutral400,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Para começar a incluir seus pedidos, precisamos saber onde você está.',
                          textAlign: TextAlign.center,
                        ).headline4(
                          style: TextStyle(
                            color: ColorPalette.neutral300,
                          ),
                        ),
                        const SizedBox(height: 24),
                        PrimaryButton(text: 'Abrir Maps'),
                        const Spacer(flex: 3),
                      ],
                    ),
                  ),
          ),
        ),
        floatingActionButton: controller.isProfileComplete
            ? FloatingActionButton(
                onPressed: () async {
                  await showDialog<void>(
                      context: context,
                      builder: (context) => AlertDialog(
                            content: CustomTextField(
                              controller: textController,
                              hintText: 'Insira o seu pedido',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  textController.clear();
                                },
                                child: Text('CANCELAR'),
                              ),
                              TextButton(
                                onPressed: () async {
                                  await controller
                                      .addOrder(textController.text);
                                  Navigator.pop(context);
                                  textController.clear();
                                },
                                child: Text('ADICIONAR'),
                              ),
                            ],
                          ));
                },
                elevation: 0,
                child: Icon(
                  Icons.add,
                  color: ColorPalette.neutral0,
                ),
              )
            : null,
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

class OrderCard extends StatelessWidget {
  const OrderCard({
    Key? key,
    required this.animation,
    required this.textController,
    required this.order,
    required this.onSubmit,
  }) : super(key: key);

  final Animation<double> animation;
  final TextEditingController textController;
  final Order order;
  final Future<void> Function(String value) onSubmit;

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
        sizeFactor: animation,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (order.description != null) ...[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(order.description!).headline4(),
                      const SizedBox(height: 8),
                      Text(order.date.toString()).body3(),
                    ],
                  ),
                  SizedBox(
                    width: 70,
                    child: getStatusIcon(order.status),
                  ),
                ] else ...[
                  Expanded(
                    child: TextFormField(
                      controller: textController,
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 16.0,
                        fontStyle: FontStyle.normal,
                        color: ColorPalette.neutral600,
                      ),
                      decoration: InputDecoration(
                        suffixIcon: GestureDetector(
                          onTap: () async {
                            if (textController.text.isNotEmpty) {
                              await onSubmit(textController.text);
                              textController.clear();
                            }
                          },
                          child: Icon(
                            Icons.add,
                            color: ColorPalette.neutral300,
                          ),
                        ),
                        hintText: 'Digite a descrição',
                      ),
                      onFieldSubmitted: (value) async {
                        if (value.isNotEmpty) {
                          await onSubmit(value);
                          textController.clear();
                        }
                      },
                    ),
                  ),
                ],
              ],
            ),
          ),
        ));
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
