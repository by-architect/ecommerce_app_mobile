enum Authority{
  admin,user;

  static fromString(String authority) {
    if (authority == Authority.admin.name) {
      return Authority.admin;
    } else {
      return Authority.user;
    }
  }
}