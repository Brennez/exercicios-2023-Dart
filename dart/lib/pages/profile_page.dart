import 'package:cached_network_image/cached_network_image.dart';
import 'package:chuva_dart/components/app_bar_component.dart';
import 'package:chuva_dart/components/card_info_component.dart';
import 'package:chuva_dart/providers/event_provider.dart';
import 'package:chuva_dart/utils/date_formater.dart';
import 'package:chuva_dart/utils/string_formater.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../models/event_model.dart';

class ProfilePage extends StatelessWidget {
  final EventModel event;

  const ProfilePage({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final filteredEvents = Provider.of<EventProvider>(context, listen: false)
        .getEventsById(event.peopleId[0]);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 70),
        child:
            AppBarComponent(subtitleOn: false, onPressed: () => context.pop()),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: SizedBox(
                        width: 98,
                        height: 98,
                        child: event.peopleUrlPicture.isNotEmpty &&
                                event.peopleUrlPicture[0] != null
                            ? CachedNetworkImage(
                                imageUrl: event.peopleUrlPicture[0],
                                fit: BoxFit.cover,
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    const Icon(
                                  Icons.error,
                                  color: Colors.red,
                                ),
                              )
                            : CircleAvatar(
                                radius: 50,
                                backgroundColor: const Color(0xff306dc3),
                                child: Text(
                                  StringFormater.getInitialName(
                                      event.peopleName),
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 50),
                                ),
                              ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: event.peopleName.isNotEmpty &&
                            event.peopleName[0] != null
                        ? ListTile(
                            title: Text(
                              event.peopleName[0],
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 24,
                                color: Colors.black54,
                              ),
                            ),
                          )
                        : const Text(''),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if (event.peopleBio.isNotEmpty && event.peopleBio[0] != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Bio',
                            style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            )),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(StringFormater.removeHtmlTags(event.peopleBio[0])),
                      ],
                    ),
                  const Row(
                    children: [
                      Text(
                        'Atividades',
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Row(
                      children: [
                        Text(
                          DateFormater.abbreviatedDate(event.start),
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 350,
              child: ListView.builder(
                itemCount: filteredEvents.length,
                itemBuilder: (context, index) {
                  return CardInfoComponent(
                    eventModel: filteredEvents[index],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
