import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:passwordfield/passwordfield.dart';

import 'custom_form_field.dart';
import 'success_page.dart';

class FormPage extends StatefulWidget {
  const FormPage({Key? key}) : super(key: key);
  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              /*
              CustomFormField(
                hintText: 'Name',
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z]+|\s")),
                ],
                validator: (val) {
                  if (val == null || !val.isValidName)
                    return 'Enter valid name';
                  return null;
                },
              ), */
              CustomFormField(
                hintText: 'Email',
                validator: (val) {
                  if (val == null || !val.isValidEmail)
                    return 'Enter valid email';
                  return null;
                },
              ),
              PasswordField(
                color: Colors.blue,
                passwordConstraint: r'.*[@$#.*].*',
                hintText: 'Password - must have special characters',
                border: PasswordBorder(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue.shade100),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue.shade100),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      width: 2,
                      color: Colors.red.shade200,
                    ),
                  ),
                ),
                errorMessage:
                    'must contain special character either . * @ # \$',
              ),
              /*              CustomFormField(
                hintText: 'Phone',
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r"[0-9]")),
                ],
                validator: (val) {
                  if (val == null || !val.isValidPhone)
                    return 'Enter valid phone';
                  return null;
                },
              ), 
              CustomFormField(
                hintText: 'Password',
                validator: (val) {
                  if (val == null || !val.isValidPassword)
                    return 'Enter valid password';
                  return null;
                },
              ),*/
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.of(
                      context,
                    ).push(MaterialPageRoute(builder: (_) => SuccessPage()));
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

extension extString on String {
  bool get isValidEmail {
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegExp.hasMatch(this);
  }

  bool get isValidName {
    final nameRegExp = new RegExp(
      r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$",
    );
    return nameRegExp.hasMatch(this);
  }

  bool get isValidPassword {
    final passwordRegExp = RegExp(
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\><*~]).{8,}/pre>',
    );
    return passwordRegExp.hasMatch(this);
  }

  bool get isNotNull {
    return this != null;
  }

  bool get isValidPhone {
    final phoneRegExp = RegExp(r"^\+?0[0-9]{10}$");
    return phoneRegExp.hasMatch(this);
  }
}
