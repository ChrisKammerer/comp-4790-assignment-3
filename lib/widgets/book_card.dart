import 'package:favorites/models/book_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/favorite_provider.dart';

class BookCard extends StatelessWidget {
  final BookModel book;

  const BookCard({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(book.bookTitle),
        subtitle: Text(book.bookAuthor),
        trailing: IconButton(
          onPressed: () {
            context.read<FavoritesProvider>()
            .toggleBookFavorite(book.id);
          },
          icon: Icon(book.isFavorite ?
          Icons.favorite :
          Icons.favorite_border,
          color: book.isFavorite ? Colors.red : Colors.grey)
        )
      )
    );
  }
}