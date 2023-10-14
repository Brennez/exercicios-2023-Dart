import 'package:cached_network_image/cached_network_image.dart';
import 'package:chuva_dart/models/event_model.dart';
import 'package:flutter/material.dart';

class PersonInfoComponent extends StatelessWidget {
  final EventModel event;
  Function()? onTap;
  bool hasCircleAvatar;

  PersonInfoComponent({
    super.key,
    required this.event,
    this.onTap,
    this.hasCircleAvatar = true,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: hasCircleAvatar &&
              event.peopleUrlPicture.isNotEmpty &&
              event.peopleUrlPicture[0] != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: SizedBox(
                width: 50,
                height: 50,
                child: CachedNetworkImage(
                  imageUrl: event.peopleUrlPicture[0],
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(
                    Icons.error,
                    color: Colors.red,
                  ),
                ),
              ),
            )
          : hasCircleAvatar
              ? const CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('assets/images/user-icon.png'),
                  backgroundColor: Colors.white,
                )
              : null,
      title: Text(
        event.peopleName.isNotEmpty && event.peopleName[0] != null
            ? event.peopleName[0]
            : '',
      ),
      subtitle: Text(
        event.peopleInstitution.isNotEmpty && event.peopleInstitution[0] != null
            ? event.peopleInstitution[0]
            : '',
      ),
    );
  }
}
