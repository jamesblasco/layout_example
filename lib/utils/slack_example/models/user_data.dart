class UserData {
  final String id;
  final String name;
  final String? status;

  final String? description;
  final String? profileImage;
  final bool online;
  UserData(
      {required this.id,
      required this.name,
      this.status,
      this.description,
      this.profileImage,
      this.online = false});
}

class MockUsers {
  static final UserData jaime = UserData(
      id: 'jamesblasco',
      name: 'Jaime Blasco',
      status: '',
      description: '',
      online: true);
  static final UserData argel = UserData(
      id: 'argel', name: 'Argel ', status: '', description: '', online: true);

  static final List<UserData> list = [
    jaime,
    argel,
  ];
}

