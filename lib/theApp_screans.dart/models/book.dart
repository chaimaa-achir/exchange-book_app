class Book {
  final int bookid;
  final int ownerid;
  final String author;
  final String? ownerimage;
  final String ownername;
  final String booktitel;
  final String bookimage;
  final String bookstatus; // (Exchange, Borrow, Sale)
  final int? distence;
  final String? description;
  final double? price;
  final DateTime? postDate;
  final bool availability;
  final String category;
  final double? latitude;
  final double? longitude;
  

  Book({
    required this.bookid,
    required this.ownerid,
    required this.ownername,
    required this.booktitel,
    required this.author,
    required this.bookimage,
    required this.bookstatus,
     this.distence,
    required this.postDate,
    required this.availability,
    required this.category,
    this.ownerimage,
    this.latitude,
    this.longitude,
    this.description,
    this.price,
    
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      bookid: json['bookid'] != null
          ? int.tryParse(json['bookid'].toString()) ?? 0
          : 0,
      ownerid: json['user_id'] != null
          ? int.tryParse(json['user_id'].toString()) ?? 0
          : 0,
      booktitel: json['title'] ?? '',
      ownername: json['username'] ?? '',
      ownerimage: json['profile_pic'],
      author: json['author'] ?? '',
      bookimage: json['cover_image'] ?? '',
      bookstatus: json['transaction_type'] ?? '',
      distence: json['distance'] != null ? (json['distance'] as num?)?.toInt() : null,
      description: json['caption'],
      price: json['price'] != null
          ? double.tryParse(json['price'].toString())
          : null,
      postDate: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      availability: json['disponibility'] ?? false,
      category: json['category'] ?? '',
      latitude: json['latitude'] != null
          ? double.tryParse(json['latitude'].toString())
          : null,
      longitude: json['longitude'] != null
          ? double.tryParse(json['longitude'].toString())
          : null,
          
    );
  }
}

  // final List<Book> books = [
  //   Book(
  //       booktitel: " harry potter",
  //       ownername: "chaima_moonlight ",
  //       bookimage: "assets/img/history.jpg",
  //       ownerimage: "assets/img/history.jpg",
  //       bookstatus: "Lending",
  //       distence: "3.8km",
      
  //       description: "A fantasy novel about a young wizard.",
  //       postDate: DateTime(2025, 3, 25, 14, 30),
  //       availability: true,
  //       category: "fantasy",
  //       latitude: 34.8884,
  //       longitude: -1.3151,
  //       ),
  //   Book(
  //       booktitel: "evil under the sun",
  //       ownername: "hadji_asheer",
  //       bookimage: "assets/img/history.jpg",
  //       ownerimage: "assets/img/history.jpg",
  //       bookstatus: "Exchange",
  //       distence: "12m",
        
  //       postDate: DateTime(2024, 6, 5, 9, 00),
  //       availability: true,
  //       category: "literary"),
  //   Book(
  //     booktitel: "فجر اسلام ",
  //     ownername: "halloula_achir",
  //     bookimage: "assets/img/history.jpg",
  //     ownerimage: "assets/img/history.jpg",
  //     bookstatus: "Sale",
  //     distence: "5.9km",
    
  //     description: "كتاب تاريخي يتحدث عن بداية الإسلام",
  //     price: 190.99,
  //     postDate: DateTime(2024, 8, 26, 4, 55),
  //     availability: true,
  //     category: "historical",
  //   ),
    
  // ];
  

