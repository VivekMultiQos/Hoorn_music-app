mixin ValidationMixin {
  bool isFieldEmpty(String fieldValue) => fieldValue.trim().isEmpty;

  bool validateCheckBox(bool checkbox) {
    if (checkbox == false) {
      return true;
    }
    return false;
  }

  bool validateEmailAddress(String email) {
    if (email.isEmpty) {
      return false;
    }

    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email.trim());
  }

  bool passwordValidation(String password) {
    if (password.length < 6 || password.contains(' ')) {
      return false;
    }
    return true;
  }

  bool confirmPasswordValidation(String password, String confirmPwd) {
    return (password != confirmPwd);
  }

  bool contactNumberValidation(String contactNumber) {
    if (contactNumber.length < 10 || contactNumber.contains(' ')) {
      return false;
    }
    return true;
  }

  bool validateZipCode(String zipCode) {
    if (zipCode.length < 5) {
      return false;
    }
    return true;
  }
}
