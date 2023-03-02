import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:full_screen_app/state/ui/ui_provider.dart';
import 'package:provider/provider.dart';

class SideBar extends StatefulWidget {
  const SideBar({super.key});

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> with SingleTickerProviderStateMixin {
  late Animation<double> sidebarAnimation;
  late AnimationController sidebarAnimationController;
  OverlayEntry? sidebarOverlayEntry;
  final sidebarOverlayLayerLink = LayerLink();
  bool isSidebar = true;

  @override
  void initState() {
    super.initState();
    sidebarAnimationController = AnimationController(duration: const Duration(milliseconds: 500), vsync: this);

    setState(() {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        return showSidebarOverlay();
      });
    });
  }

  @override
  void dispose() {
    sidebarAnimationController.dispose();
    super.dispose();
  }

  void showSidebarOverlay() {
    final sideBarOverlay = Overlay.of(context);

    sidebarOverlayEntry = OverlayEntry(
        builder: (context) => Consumer<UiProvider>(builder: (_, uiProvider, _2) {
              sidebarAnimation = Tween<double>(begin: 150, end: MediaQuery.of(context).size.width * 0.75).animate(sidebarAnimationController);
              if (uiProvider.getSidebar) {
                sidebarAnimationController.forward();
              } else {
                sidebarAnimationController.reset();
              }

              return AnimatedBuilder(
                  animation: sidebarAnimationController,
                  builder: (BuildContext context, Widget? child) {
                    return Positioned(
                        width: sidebarAnimation.value,
                        height: MediaQuery.of(context).size.height,
                        child: uiProvider.getSidebar
                            ? CompositedTransformFollower(
                                link: sidebarOverlayLayerLink,
                                child: Material(
                                    color: Theme.of(context).colorScheme.surface,
                                    child: Container(
                                      decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface, boxShadow: [
                                        BoxShadow(
                                          color: Theme.of(context).colorScheme.shadow.withOpacity(0.1),
                                          spreadRadius: 2.0,
                                          blurRadius: 3.0,
                                          offset: const Offset(0, 1),
                                        )
                                      ]),
                                      child: 
                                      
                                      SafeArea(
                                         
                                          child: Stack(
                                        children: [
                                          Column(
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.only(top: 30.0),
                                                alignment: Alignment.topCenter,
                                                child: Text(
                                                  "LIDTA ACADEMY",
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    letterSpacing: 2.0,
                                                    fontSize: 24.0,
                                                    fontWeight: FontWeight.bold,
                                                    color: Theme.of(context).colorScheme.primary,
                                                  ),
                                                ),
                                              ),
                                              Divider(
                                                height: 5.0,
                                                color: Theme.of(context).colorScheme.primary,
                                              ),
                                              Expanded(
                                                child: SingleChildScrollView(
                                                  child: Container(
                                                    margin: const EdgeInsets.only(top: 10.0, bottom: 5.0),
                                                   
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          overflow: TextOverflow.ellipsis,
                                                          "MENU",
                                                          style: TextStyle(overflow: TextOverflow.ellipsis, fontSize: 18.0, color: Theme.of(context).colorScheme.primary.withOpacity(0.75)),
                                                        ),
                                                        ListView.builder(
                                                            physics: const BouncingScrollPhysics(),
                                                            shrinkWrap: true,
                                                            scrollDirection: Axis.vertical,
                                                            itemCount: 5,
                                                            itemBuilder: (BuildContext context, int index) {
                                                              double deviceHeight = MediaQuery.of(context).size.height;
                                                              double deviceWidth = MediaQuery.of(context).size.width;

                                                              var icon = Icons.home;
                                                              String text = "Home";
                                                              switch (index) {
                                                                case 1:
                                                                  icon = Icons.verified_user_sharp;
                                                                  text = "Human Resource";
                                                                  break;
                                                                case 2:
                                                                  icon = Icons.calculate;
                                                                  text = "Accounting";
                                                                  break;
                                                                case 3:
                                                                  icon = Icons.laptop;
                                                                  text = "Point of Sale";
                                                                  break;

                                                                case 4:
                                                                  icon = Icons.warehouse;
                                                                  text = "Inventory";
                                                                  break;
                                                                default:
                                                              }

                                                              return InkWell(
                                                                focusColor: Theme.of(context).colorScheme.error,
                                                                hoverColor: Theme.of(context).colorScheme.primary,
                                                                onTap: () {},
                                                                onHover: (value) {},
                                                                child: Column(
                                                                  children: [
                                                                    Container(
                                                                      height: deviceHeight * 0.060,
                                                                      margin: const EdgeInsets.only(top: 3.0),
                                                                      decoration: BoxDecoration(
                                                                        color: Theme.of(context).colorScheme.surface,
                                                                        boxShadow: [
                                                                          BoxShadow(
                                                                            color: Theme.of(context).colorScheme.shadow.withOpacity(0.05),
                                                                            spreadRadius: 0,
                                                                            blurRadius: 0,
                                                                            offset: const Offset(0, 1), // changes position of shadow
                                                                          )
                                                                        ],
                                                                      ),
                                                                      child: Padding(
                                                                        padding: const EdgeInsets.all(5.0),
                                                                        child: Row(
                                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                                          children: [
                                                                            Icon(
                                                                              icon,
                                                                              size: 24.0,
                                                                              color: Theme.of(context).colorScheme.onBackground.withOpacity(0.75),
                                                                            ),
                                                                            const SizedBox(
                                                                              width: 10.0,
                                                                            ),
                                                                            Expanded(
                                                                              child: Text(
                                                                                text,
                                                                                overflow: TextOverflow.ellipsis,
                                                                                style: TextStyle(overflow: TextOverflow.ellipsis, fontSize: 18.0, color: Theme.of(context).colorScheme.onBackground.withOpacity(0.75)),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              );
                                                            }),
                                                        Text(
                                                          "APP SETUP",
                                                          style: TextStyle(overflow: TextOverflow.ellipsis, fontSize: 18.0, color: Theme.of(context).colorScheme.primary.withOpacity(0.75)),
                                                        ),
                                                        ListView.builder(
                                                            physics: const BouncingScrollPhysics(),
                                                            shrinkWrap: true,
                                                            scrollDirection: Axis.vertical,
                                                            itemCount: 5,
                                                            itemBuilder: (BuildContext context, int index) {
                                                              double deviceHeight = MediaQuery.of(context).size.height;
                                                              double deviceWidth = MediaQuery.of(context).size.width;

                                                              var icon = Icons.home;
                                                              String text = "Home";
                                                              switch (index) {
                                                                case 1:
                                                                  icon = Icons.verified_user_sharp;
                                                                  text = "Human Resource";
                                                                  break;
                                                                case 2:
                                                                  icon = Icons.calculate;
                                                                  text = "Accounting";
                                                                  break;
                                                                case 3:
                                                                  icon = Icons.laptop;
                                                                  text = "Point of Sale";
                                                                  break;

                                                                case 4:
                                                                  icon = Icons.warehouse;
                                                                  text = "Inventory";
                                                                  break;
                                                                default:
                                                              }

                                                              return InkWell(
                                                                focusColor: Theme.of(context).colorScheme.error,
                                                                hoverColor: Theme.of(context).colorScheme.primary,
                                                                onTap: () {},
                                                                onHover: (value) {},
                                                                child: Column(
                                                                  children: [
                                                                    Container(
                                                                      height: deviceHeight * 0.060,
                                                                      margin: const EdgeInsets.only(top: 3.0),
                                                                      decoration: BoxDecoration(
                                                                        color: Theme.of(context).colorScheme.surface,
                                                                        boxShadow: [
                                                                          BoxShadow(
                                                                            color: Theme.of(context).colorScheme.shadow.withOpacity(0.05),
                                                                            spreadRadius: 0,
                                                                            blurRadius: 0,
                                                                            offset: const Offset(0, 1), // changes position of shadow
                                                                          )
                                                                        ],
                                                                      ),
                                                                      child: Padding(
                                                                        padding: const EdgeInsets.all(5.0),
                                                                        child: Row(
                                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                                          children: [
                                                                            Icon(
                                                                              icon,
                                                                              size: 24.0,
                                                                              color: Theme.of(context).colorScheme.onBackground.withOpacity(0.75),
                                                                            ),
                                                                            const SizedBox(
                                                                              width: 10.0,
                                                                            ),
                                                                            Expanded(
                                                                              child: Text(
                                                                                text,
                                                                                style: TextStyle(overflow: TextOverflow.ellipsis, fontSize: 18.0, color: Theme.of(context).colorScheme.onBackground.withOpacity(0.75)),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              );
                                                            }),
                                                        Text(
                                                          "USER ACCOUNT",
                                                          style: TextStyle(overflow: TextOverflow.ellipsis, fontSize: 18.0, color: Theme.of(context).colorScheme.primary.withOpacity(0.75)),
                                                        ),
                                                        ListView.builder(
                                                            physics: const BouncingScrollPhysics(),
                                                            shrinkWrap: true,
                                                            scrollDirection: Axis.vertical,
                                                            itemCount: 5,
                                                            itemBuilder: (BuildContext context, int index) {
                                                              double deviceHeight = MediaQuery.of(context).size.height;
                                                              double deviceWidth = MediaQuery.of(context).size.width;

                                                              var icon = Icons.home;
                                                              String text = "Home";
                                                              switch (index) {
                                                                case 1:
                                                                  icon = Icons.verified_user_sharp;
                                                                  text = "Human Resource";
                                                                  break;
                                                                case 2:
                                                                  icon = Icons.calculate;
                                                                  text = "Accounting";
                                                                  break;
                                                                case 3:
                                                                  icon = Icons.laptop;
                                                                  text = "Point of Sale";
                                                                  break;

                                                                case 4:
                                                                  icon = Icons.warehouse;
                                                                  text = "Inventory";
                                                                  break;
                                                                default:
                                                              }

                                                              return InkWell(
                                                                focusColor: Theme.of(context).colorScheme.error,
                                                                hoverColor: Theme.of(context).colorScheme.primary,
                                                                onTap: () {},
                                                                onHover: (value) {},
                                                                child: Column(
                                                                  children: [
                                                                    Container(
                                                                      height: deviceHeight * 0.060,
                                                                      margin: const EdgeInsets.only(top: 3.0),
                                                                      decoration: BoxDecoration(
                                                                        color: Theme.of(context).colorScheme.surface,
                                                                        boxShadow: [
                                                                          BoxShadow(
                                                                            color: Theme.of(context).colorScheme.shadow.withOpacity(0.05),
                                                                            spreadRadius: 0,
                                                                            blurRadius: 0,
                                                                            offset: const Offset(0, 1), // changes position of shadow
                                                                          )
                                                                        ],
                                                                      ),
                                                                      child: Padding(
                                                                        padding: const EdgeInsets.all(5.0),
                                                                        child: Row(
                                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                                          children: [
                                                                            Icon(
                                                                              icon,
                                                                              size: 24.0,
                                                                              color: Theme.of(context).colorScheme.onBackground.withOpacity(0.75),
                                                                            ),
                                                                            const SizedBox(
                                                                              width: 10.0,
                                                                            ),
                                                                            Expanded(
                                                                              child: Text(
                                                                                text,
                                                                                style: TextStyle(overflow: TextOverflow.ellipsis, fontSize: 18.0, color: Theme.of(context).colorScheme.onBackground.withOpacity(0.75)),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              );
                                                            }),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Positioned(
                                              bottom: 2.0,
                                              right: 0.0,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  Container(
                                                    alignment: Alignment.center,
                                                    margin: const EdgeInsets.all(5.0),
                                                    padding: const EdgeInsets.all(5.0),
                                                    child: InkWell(
                                                      onHover: (value) {},
                                                      onTap: () {
                                                        uiProvider.setSidebar(false);
                                                      },
                                                      child: Icon(
                                                        Icons.arrow_back_ios,
                                                        size: 30.0,
                                                        color: Theme.of(context).colorScheme.onErrorContainer,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ))
                                       
                                       
                                        ],
                                      )),
                                    
                                    )),
                              )
                            : const SizedBox.shrink());
                  });
            }));
    sideBarOverlay?.insert(sidebarOverlayEntry!);
    sidebarAnimationController.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
