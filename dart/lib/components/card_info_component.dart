import 'package:chuva_dart/models/event_model.dart';
import 'package:chuva_dart/utils/date_formater.dart';
import 'package:flutter/material.dart';
import 'package:from_css_color/from_css_color.dart';

class CardInfoComponent extends StatelessWidget {
  final EventModel eventModel;

  CardInfoComponent({
    super.key,
    required this.eventModel,
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
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  left: BorderSide(
                      color: fromCssColor('${eventModel.categoryColor}'),
                      width: 6),
                ),
              ),
              child: ListTile(
                title: Text(
                  '${eventModel.categoryTitle} de ${DateFormater.hourFormater(eventModel.start)} até ${DateFormater.hourFormater(eventModel.end)}',
                  style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 15,
                      fontWeight: FontWeight.w600),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 3,
                    ),
                    Text(
                      eventModel.title,
                      style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      eventModel.peopleName.isNotEmpty
                          ? eventModel.peopleName[0]
                          : '',
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
        if (eventModel.isFavorite)
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
