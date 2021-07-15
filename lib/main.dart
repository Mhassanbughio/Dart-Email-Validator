import 'package:email_field_example/widget/button_widget.dart';
import 'package:email_field_example/widget/email_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final String title = 'Email Field';

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(primarySwatch: Colors.blue),
        home: MainPage(),
      );
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(MyApp.title),
          centerTitle: true,
        ),
        body: Center(
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  EmailFieldWidget(controller: emailController),
                  const SizedBox(height: 16),
                  buildButton(),
                  buildNoAccount(),
                ],
              ),
            ),
          ),
        ),
      );

  Widget buildButton() => ButtonWidget(
        text: 'LOGIN',
        onClicked: () {
          final form = formKey.currentState!;

          if (form.validate()) {
            final email = emailController.text;

            ScaffoldMessenger.of(context)
              ..removeCurrentSnackBar()
              ..showSnackBar(SnackBar(
                content: Text('Your email is $email'),
              ));
          }
        },
      );

  Widget buildNoAccount() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Don\'t have an account?'),
          TextButton(
            child: Text('SIGN UP'),
            onPressed: () {},
          ),
        ],
      );
}
