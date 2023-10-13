import 'package:cached_network_image/cached_network_image.dart';
import 'package:chuva_dart/models/event_model.dart';
import 'package:chuva_dart/utils/date_formater.dart';
import 'package:chuva_dart/utils/string_formater.dart';
import 'package:flutter/material.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:go_router/go_router.dart';
import '../components/app_bar_component.dart';

class DetailsEventPage extends StatelessWidget {
  final EventModel event;
  const DetailsEventPage({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 70),
          child: AppBarComponent(
            subtitleOn: false,
            onPressed: () => context.pop(),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: fromCssColor('${event.categoryColor}'),
                ),
                padding: const EdgeInsets.all(5),
                child: Text(
                  event.categoryTitle,
                  style: TextStyle(
                    color: Colors.grey[50],
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                alignment: Alignment.center,
                child: Text(
                  event.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.access_time,
                          color: Color(0xff306dc3),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                            '${DateFormater.dayOfWeek(event.start)} ${DateFormater.hourFormater(event.start)}h - ${DateFormater.hourFormater(event.end)}h'),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Color(0xff306dc3),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Row(
                          children: event.locations.isNotEmpty
                              ? event.locations
                                  .map((localization) => Text(localization))
                                  .toList()
                              : [],
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * .96,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff306dc3),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  icon: const Icon(
                    Icons.star,
                    color: Colors.white,
                  ),
                  onPressed: () {},
                  label: Text(
                    'Adicionar à sua agenda',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  event.description == 'without description'
                      ? ''
                      : StringFormater.removeHtmlTags(event.description ?? ''),
                  style: const TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, bottom: 5),
                    child: Text(
                      event.peopleLabel.isNotEmpty ? event.peopleLabel[0] : '',
                      style: const TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: event.peopleUrlPicture.isNotEmpty &&
                            event.peopleUrlPicture[0] != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: SizedBox(
                              width: 50,
                              height: 50,
                              child: CachedNetworkImage(
                                imageUrl: event.peopleUrlPicture[0],
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    const Icon(
                                  Icons.error,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          )
                        : const CircleAvatar(
                            radius: 30,
                            backgroundImage:
                                AssetImage('assets/images/user-icon.png'),
                            backgroundColor: Colors.white,
                          ),
                    title: Text(
                      event.peopleName.isNotEmpty && event.peopleName[0] != null
                          ? event.peopleName[0]
                          : '',
                    ),
                    subtitle: Text(
                      event.peopleInstitution.isNotEmpty &&
                              event.peopleInstitution[0] != null
                          ? event.peopleInstitution[0]
                          : '',
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
