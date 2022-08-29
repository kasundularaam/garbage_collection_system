import 'package:easy_localization/easy_localization.dart';

bool emailValid(String email) {
  bool empty = email.isEmpty;
  bool valid = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
  if (empty) {
    throw "email_empty".tr();
  }

  if (!valid) {
    throw "invalid_email".tr();
  }
  return true;
}

bool passwordValid(String password) {
  bool valid = password.length >= 6;
  bool empty = password.isEmpty;
  if (empty) {
    throw "password_empty".tr();
  }
  if (!valid) {
    throw "short_password".tr();
  }
  return true;
}

bool phoneValid(int phone) {
  bool empty = phone == -1;
  bool valid = "$phone".length == 9;
  if (empty) {
    throw "phone_empty".tr();
  }
  if (!valid) {
    throw "invalid_phone".tr();
  }
  return true;
}

bool nicValid(String nic) {
  bool empty = nic.isEmpty;
  bool valid =
      RegExp(r'^(?:19|20)?\d{2}[0-9]{10}|[0-9]{9}[x|X|v|V]$').hasMatch(nic);
  if (empty) {
    throw "nic_empty".tr();
  }

  if (!valid) {
    throw "invalid_nic".tr();
  }
  return true;
}

bool addressValid(String address) {
  bool empty = address.isEmpty;
  if (empty) {
    throw "address_empty".tr();
  }
  return true;
}

bool usernameValid(String username) {
  bool empty = username.isEmpty;
  if (empty) {
    throw "username_empty".tr();
  }
  return true;
}

bool passwordsValid(String password, String confirm) {
  bool empty = password.isEmpty;
  bool match = password == confirm;
  if (empty) {
    throw "password_empty".tr();
  }
  if (!match) {
    throw "password_not_match".tr();
  }
  return true;
}

bool complainValid(String complain) {
  bool empty = complain.isEmpty;
  if (empty) {
    throw "complaint_empty".tr();
  }
  return true;
}
