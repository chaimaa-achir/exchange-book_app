class Book {
  final String booktitel;
  final String ownername;
  final String bookimage;
  final String ownerimage;
  final String bookstatus;// NEW (Exchange, Borrow, Sale)
  final String distence; 
  final double rating;
  Book({
    required this.booktitel,
    required this.ownername,
    required this.bookimage,
    required this.ownerimage,
    required this.bookstatus,
    required this.distence,
    required this.rating,
  });
}
