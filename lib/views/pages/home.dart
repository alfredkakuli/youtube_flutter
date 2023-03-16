import 'package:flutter/material.dart';
import 'package:full_screen_app/state/ui/ui_provider.dart';
import 'package:full_screen_app/views/pages/shared/widgets/navbar.dart';
import 'package:full_screen_app/views/pages/shared/widgets/sidebar.dart';
import 'package:full_screen_app/views/pages/user_list.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      Provider.of<UiProvider>(context, listen: true).getLogedUser;
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          // image: const DecorationImage(
          //   fit: BoxFit.cover,
          //   image: AssetImage('assets/images/bg_dark.png'),
          // ),
        ),
        child: Column(
          children: [navbar(context), const SideBar(), Expanded(child: usersList(context))],
        ),
      ),
    );
  }
}
