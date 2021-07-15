import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class EmailFieldWidget extends StatefulWidget {
  final TextEditingController controller;

  const EmailFieldWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  _EmailFieldWidgetState createState() => _EmailFieldWidgetState();
}

class _EmailFieldWidgetState extends State<EmailFieldWidget> {
  @override
  void initState() {
    super.initState();

    widget.controller.addListener(onListen);
  }

  @override
  void dispose() {
    widget.controller.removeListener(onListen);

    super.dispose();
  }

  void onListen() => setState(() {});

  @override
  Widget build(BuildContext context) => TextFormField(
        controller: widget.controller,
        decoration: InputDecoration(
          hintText: 'Email',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          prefixIcon: Icon(Icons.mail),
          suffixIcon: widget.controller.text.isEmpty
              ? Container(width: 0)
              : IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => widget.controller.clear(),
                ),
        ),
        keyboardType: TextInputType.emailAddress,
        autofillHints: [AutofillHints.email],
        validator: (email) => email != null && !EmailValidator.validate(email)
            ? 'Enter a valid email'
            : null,
      );
}
