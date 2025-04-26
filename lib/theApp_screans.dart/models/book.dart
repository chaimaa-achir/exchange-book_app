class Book {
  final String booktitel;
  final String ownername;
  final String bookimage;
  final String ownerimage;
  final String bookstatus; // NEW (Exchange, Borrow, Sale)
  final String distence;

  final String? description;
  final double? price;
  final DateTime postDate;
  final bool availability;
  final String category;
   final double? latitude;
   final double? longitude;
  Book({
    required this.booktitel,
    required this.ownername,
    required this.bookimage,
    required this.ownerimage,
    required this.bookstatus,
    required this.distence,
    
    required this.postDate,
    
    required this.availability,
    required this.category,
    this.latitude,
    this.longitude,

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
      
        description: "A fantasy novel about a young wizard.",
        postDate: DateTime(2025, 3, 25, 14, 30),
        availability: true,
        category: "fantasy",
        latitude: 34.8884,
        longitude: -1.3151,
        ),
    Book(
        booktitel: "evil under the sun",
        ownername: "hadji_asheer",
        bookimage: "assets/img/history.jpg",
        ownerimage: "assets/img/history.jpg",
        bookstatus: "Exchange",
        distence: "12m",
        
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
    
      description: "كتاب تاريخي يتحدث عن بداية الإسلام",
      price: 190.99,
      postDate: DateTime(2024, 8, 26, 4, 55),
      availability: true,
      category: "historical",
    ),
    
  ];

