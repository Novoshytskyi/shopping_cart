import 'package:flutter/material.dart';
import '../db/database.dart';
import '../functions.dart';
import '../model/user.dart';
import '../theme_settings.dart';
import '../user_secure_storage.dart';
import '../widgets/reusable_button.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _confirmPassController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKeyAuthForm = GlobalKey<ScaffoldState>();

  final _nameFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _passFocus = FocusNode();
  final _passConfirmFocus = FocusNode();

  bool _hidePass = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passController.dispose();
    _confirmPassController.dispose();

    _nameFocus.dispose();
    _emailFocus.dispose();
    _passFocus.dispose();
    _passConfirmFocus.dispose();
    super.dispose();
  }

  void _fieldFocusChange(
    BuildContext context,
    FocusNode currentFocus,
    FocusNode nextFocus,
  ) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKeyAuthForm,
      appBar: AppBar(
        title: const Text(
          'РЕГИСТРАЦИЯ',
          style: TextStyle(
            color: richColor,
            fontSize: 24.0,
          ),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 10.0,
          ),
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView(
                    children: [
                      const SizedBox(
                        height: 25.0,
                      ),
                      TextFormField(
                        style: Theme.of(context).textTheme.bodySmall,
                        focusNode: _nameFocus,
                        onFieldSubmitted: (_) {
                          _fieldFocusChange(context, _nameFocus, _emailFocus);
                        },
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: 'Введите Имя',
                          hintText: 'Имя',
                          prefixIcon: const Icon(
                            Icons.person_outlined,
                          ),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _nameController.clear();
                              });
                            },
                            child: _nameController.text.isNotEmpty
                                ? const Icon(Icons.close_outlined)
                                : const SizedBox(),
                          ),
                        ),
                        validator: _validateName,
                        onChanged: (value) {
                          setState(() {});
                        },
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      TextFormField(
                        style: Theme.of(context).textTheme.bodySmall,
                        focusNode: _emailFocus,
                        onFieldSubmitted: (_) {
                          _fieldFocusChange(context, _emailFocus, _passFocus);
                        },
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Введите e-mail',
                          hintText: 'e-mail',
                          prefixIcon: const Icon(
                            Icons.mail_outline,
                          ),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _emailController.clear();
                              });
                            },
                            child: _emailController.text.isNotEmpty
                                ? const Icon(Icons.close_outlined)
                                : const SizedBox(),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: _vaidateEmail,
                        onChanged: (value) {
                          setState(() {});
                        },
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      TextFormField(
                        style: Theme.of(context).textTheme.bodySmall,
                        focusNode: _passFocus,
                        onFieldSubmitted: (_) {
                          _fieldFocusChange(
                              context, _passFocus, _passConfirmFocus);
                        },
                        controller: _passController,
                        obscureText: _hidePass,
                        decoration: InputDecoration(
                          // err
                          labelText: 'Введите пароль',
                          hintText: 'Пароль',
                          prefixIcon: const Icon(
                            Icons.gpp_good_outlined,
                          ),
                          suffixIcon: IconButton(
                            // color: richColor,
                            icon: Icon(_hidePass
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined),
                            onPressed: () {
                              setState(() {
                                _hidePass = !_hidePass;
                              });
                            },
                          ),
                        ),
                        validator: _validatePassword,
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      TextFormField(
                        style: Theme.of(context).textTheme.bodySmall,
                        focusNode: _passConfirmFocus,
                        controller: _confirmPassController,
                        obscureText: _hidePass,
                        decoration: const InputDecoration(
                          labelText: 'Повторно введите пароль',
                          hintText: 'Пароль',
                          filled: true,
                          prefixIcon: Icon(Icons.gpp_maybe_outlined),
                        ),
                        validator: _validatePasswordConfirm,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                    ],
                  ),
                ),
              ),
              ReusableButton(
                text: 'РЕГИСТРАЦИЯ',
                onPressed: () {
                  setState(() {
                    _submitForm();
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Добавление нового пользователя в БД
      User user = User(
        id: null,
        name: _nameController.text,
        email: _emailController.text,
        password: _passController.text,
      );
      DBProvider.db.insertUser(user);

      // Добавление нового пользователя в Secure Storage
      await saveNewUserToSecureStorage();

      // Создание таблиц ShoppingCart и History (для нового пользователя)
      await createTablesForNewUser();

      _nameController.text = '';
      _emailController.text = '';
      _passController.text = '';
      _confirmPassController.text = '';

      routeToProductsPage();
    } else {
      showCustomSnackBar(context, 'Заполните поля корректно');
    }
  }

  void routeToProductsPage() {
    showCustomSnackBar(context, 'Регистрация успешна');

    Navigator.pushNamed(context, '/page3');
  }

  // Извлечение нового пользователя с id из БД и сохр. в SecureStorage
  Future saveNewUserToSecureStorage() async {
    User newUser = await DBProvider.db.getNewUser();

    await UserSecureStorage.setCurrentUserInfo(newUser);
    debugColorPrint('register_page -> name: ${newUser.name}');
  }

  Future createTablesForNewUser() async {
    User newUser = await DBProvider.db.getNewUser();
    // Создание таблицы ShoppingCart (для нового пользователя)
    await DBProvider.db.createTableShoppingCart(newUser.id as int);

    // Создание таблицы History (для нового пользователя)
    // DBProvider.db.createTableHistory(newUser.id as int);
  }

  String? _validateName(String? value) {
    // ignore: no_leading_underscores_for_local_identifiers
    final _nameExp = RegExp(r'^[A-Za-zА-Яа-я. ]+$');
    if (value == null || value.isEmpty) {
      return 'Введите своё Имя';
    } else if (!_nameExp.hasMatch(value)) {
      return 'Символы в имени не допустимы';
    } else {
      return null;
    }
  }

  String? _vaidateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Введите свой e-mail';
    } else if (!_emailController.text.contains('@') ||
        !_emailController.text.contains('.')) {
      return 'Введен не e-mail';
    } else {
      return null;
    }
  }

  String? _validatePassword(String? value) {
    if (_passController.text.length < 6 || _passController.text.length > 12) {
      return 'Длина пароля 6..12 символов';
    } else {
      return null;
    }
  }

  String? _validatePasswordConfirm(String? value) {
    if (_confirmPassController.text != _passController.text) {
      return 'Пароли должны совпадать';
    } else {
      return null;
    }
  }
}
