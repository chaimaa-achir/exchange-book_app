class Book {
  final String booktitel;
  final String ownername;
  final String bookimage;
  final String ownerimage;
  final String bookstatus; // NEW (Exchange, Borrow, Sale)
  final String distence;
  final double book_rating;
  final double owner_rating;
  final String? description;
  final double? price;
  final DateTime postDate;
  final bool availability;
  final String category;
//  final double latitude;
//  final double longitude;
  Book({
    required this.booktitel,
    required this.ownername,
    required this.bookimage,
    required this.ownerimage,
    required this.bookstatus,
    required this.distence,
    required this.book_rating,
    required this.postDate,
    required this.owner_rating,
    required this.availability,
    required this.category,

    //  required this.latitude,
    //  required this.longitude, // for later when i work on google map api
    this.description,
    this.price,
  });
}
  final List<Book> books = [
    Book(
        booktitel: " harry potter",
        ownername: "chaima_moonlight ",
        bookimage: "assets/img/history.jpg",
        ownerimage: "assets/img/history.jpg",
        bookstatus: "Lending",
        distence: "3.8km",
        book_rating: 4.8,
        owner_rating: 5.6,
        description: "A fantasy novel about a young wizard.",
        postDate: DateTime(2025, 3, 25, 14, 30),
        availability: true,
        category: "fantasy"),
    Book(
        booktitel: "evil under the sun",
        ownername: "hadji_asheer",
        bookimage: "assets/img/history.jpg",
        ownerimage: "assets/img/history.jpg",
        bookstatus: "Exchange",
        distence: "12m",
        book_rating: 7.8,
        owner_rating: 4.2,
        postDate: DateTime(2024, 6, 5, 9, 00),
        availability: true,
        category: "literary"),
    Book(
      booktitel: "فجر اسلام ",
      ownername: "halloula_achir",
      bookimage: "assets/img/history.jpg",
      ownerimage: "assets/img/history.jpg",
      bookstatus: "Sale",
      distence: "5.9km",
      book_rating: 5.2,
      owner_rating: 5.7,
      description: "كتاب تاريخي يتحدث عن بداية الإسلام",
      price: 190.99,
      postDate: DateTime(2024, 8, 26, 4, 55),
      availability: false,
      category: "historical",
    ),
    Book(
      booktitel: "فجر اسلام ",
      ownername: "halloula_achir",
      bookimage: "assets/img/history.jpg",
      ownerimage: "assets/img/history.jpg",
      bookstatus: "Sale",
      distence: "5.9km",
      book_rating: 5.2,
      owner_rating: 5.7,
      description: "كتاب تاريخي يتحدث عن بداية الإسلام",
      price: 190.99,
      postDate: DateTime(2024, 8, 26, 4, 55),
      availability: false,
      category: "historical",
    ),
    Book(
      booktitel: "فجر اسلام ",
      ownername: "halloula_achir",
      bookimage: "assets/img/history.jpg",
      ownerimage: "assets/img/history.jpg",
      bookstatus: "Sale",
      distence: "5.9km",
      book_rating: 5.2,
      owner_rating: 5.7,
      description: "كتاب تاريخي يتحدث عن بداية الإسلام",
      price: 190.99,
      postDate: DateTime(2024, 8, 26, 4, 55),
      availability: false,
      category: "historical",
    ),
    Book(
      booktitel: "فجر اسلام ",
      ownername: "halloula_achir",
      bookimage: "assets/img/history.jpg",
      ownerimage: "assets/img/history.jpg",
      bookstatus: "Sale",
      distence: "5.9km",
      book_rating: 5.2,
      owner_rating: 5.7,
      description: "كتاب تاريخي يتحدث عن بداية الإسلام",
      price: 190.99,
      postDate: DateTime(2024, 8, 26, 4, 55),
      availability: false,
      category: "historical",
    ),
    Book(
      booktitel: "فجر اسلام ",
      ownername: "halloula_achir",
      bookimage: "assets/img/history.jpg",
      ownerimage: "assets/img/history.jpg",
      bookstatus: "Sale",
      distence: "5.9km",
      book_rating: 5.2,
      owner_rating: 5.7,
      description: "كتاب تاريخي يتحدث عن بداية الإسلام",
      price: 190.99,
      postDate: DateTime(2024, 8, 26, 4, 55),
      availability: false,
      category: "historical",
    ),
    Book(
      booktitel: "فجر اسلام ",
      ownername: "halloula_achir",
      bookimage: "assets/img/history.jpg",
      ownerimage: "assets/img/history.jpg",
      bookstatus: "Sale",
      distence: "5.9km",
      book_rating: 5.2,
      owner_rating: 5.7,
      description: "كتاب تاريخي يتحدث عن بداية الإسلام",
      price: 190.99,
      postDate: DateTime(2024, 8, 26, 4, 55),
      availability: false,
      category: "historical",
    ),
  ];

