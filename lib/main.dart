import 'package:authentication/authentication.dart';
import 'package:flutter/material.dart';
import 'package:common/common.dart';
import 'package:home/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const EiCheguei());
}

class EiCheguei extends StatelessWidget {
  const EiCheguei({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ...AuthenticationModule().getProviders(),
        ...HomeModule().getProviders(),
      ],
      child: MaterialApp(
        title: 'Ei, cheguei!',
        theme: ThemeData(
          primarySwatch: Colors.amber,
        ),
        debugShowCheckedModeBanner: false,
        home: Builder(
          builder: (context) => StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (UserService().user?.access == AccessType.condominium) {
                  return const DashboardPage();
                }
                return const HomePage();
              } else if (snapshot.hasError) {
                return Scaffold(
                  backgroundColor: ColorPalette.background,
                  body: const Center(
                    child: Text('Algo deu errado. Tente novamente!!'),
                  ),
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    color: ColorPalette.secondaryColor,
                  ),
                );
              } else {
                return const LoginPage();
              }
            },
          ),
        ),
      ),
    );
  }
}
