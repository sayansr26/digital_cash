class UserModel {
  String fname;
  String lname;
  String email;
  String username;
  String phone;
  String balance;

  UserModel({
    this.fname,
    this.lname,
    this.email,
    this.username,
    this.phone,
    this.balance,
  });

  factory UserModel.fromMap(Map<String, dynamic> jsonData) {
    return UserModel(
      fname: jsonData['fname'],
      lname: jsonData['lname'],
      email: jsonData['email'],
      username: jsonData['username'],
      phone: jsonData['phone'],
      balance: jsonData['balance'],
    );
  }
}
