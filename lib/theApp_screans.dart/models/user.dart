class User {
  final String username;
  final String userimag;
  final double userrating;
  final String location;

  User(
      {required this.userimag,
      required this.username,
      required this.userrating,
      required this.location});
}

final List<User> users = [
  User(
      userimag: "assets/img/history.jpg",
      username: "hanane_ben",
      userrating: 9.1,
      location: "Tlmecen"
      ),
  User(
      userimag: "assets/img/history.jpg",
      username: "yassine.kh",
      userrating: 8.6,
      location: "Oran"
      ),
  User(
      userimag: "assets/img/history.jpg",
      username: "chaima_achi2",
      userrating: 9.4,
      location: "Alger"
      ),
  User(
      userimag: "assets/img/history.jpg",
      username: "hadji_asheer",
      location: "bejia",
      userrating: 7.9),
];
