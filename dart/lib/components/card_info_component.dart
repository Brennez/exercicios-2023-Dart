import 'package:flutter/material.dart';

class CardInfoComponent extends StatelessWidget {
  bool isFavorite;
  final String start;
  final String end;
  final String categoryTitle;
  final String topicTitle;
  final String author;

  CardInfoComponent({
    super.key,
    this.isFavorite = false,
    required this.start,
    required this.end,
    required this.categoryTitle,
    required this.topicTitle,
    required this.author,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
          margin: const EdgeInsets.all(5),
          elevation: 2,
          child: ClipPath(
            clipper: ShapeBorderClipper(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                  left: BorderSide(color: Colors.green, width: 6),
                ),
              ),
              child: ListTile(
                title: Text(
                  '$categoryTitle de $start até $end',
                  style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 3,
                    ),
                    Text(
                      topicTitle,
                      style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      author,
                      style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        if (isFavorite)
          const Positioned(
            right: 10,
            top: 6,
            child: Icon(
              Icons.bookmark,
              size: 26,
              color: Color(0xff7c90ac),
            ),
          )
      ],
    );
  }
}
