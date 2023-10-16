import 'package:cached_network_image/cached_network_image.dart';
import 'package:chuva_dart/pages/profile_page.dart';
import 'package:chuva_dart/providers/event_provider.dart';
import 'package:flutter/material.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../components/app_bar_component.dart';
import '../models/event_model.dart';
import '../utils/date_formater.dart';
import '../utils/string_formater.dart';

class DetailsEventPage extends StatefulWidget {
  final EventModel event;
  const DetailsEventPage({super.key, required this.event});

  @override
  State<DetailsEventPage> createState() => _DetailsEventPageState();
}

class _DetailsEventPageState extends State<DetailsEventPage> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    bool isSubscriber = widget.event.isFavorite;

    void showSnackBar(bool isSubscriber) {
      if (!isSubscriber) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            duration: Duration(milliseconds: 700),
            content: Text('Vamos te lembrar dessa atividade.'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            duration: Duration(milliseconds: 700),
            content: Text('Não Vamos te lembrar dessa atividade.'),
          ),
        );
      }
    }

    void favoriteEvent() {
      setState(() => isLoading = true);

      Provider.of<EventProvider>(context, listen: false)
          .setEventFavorite(widget.event.eventId)
          .then((value) {
        setState(
          () => isLoading = false,
        );
      });
    }

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
                  color: fromCssColor('${widget.event.categoryColor}'),
                ),
                padding: const EdgeInsets.all(5),
                child: Text(
                  widget.event.categoryTitle,
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
                  widget.event.title,
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
                            '${DateFormater.dayOfWeek(widget.event.start)} ${DateFormater.hourFormater(widget.event.start)}h - ${DateFormater.hourFormater(widget.event.end)}h'),
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
                          children: widget.event.locations.isNotEmpty
                              ? widget.event.locations
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
                    backgroundColor: isLoading
                        ? const Color(0xffdcdcdc)
                        : const Color(0xff306dc3),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  icon: isLoading
                      ? const Icon(
                          Icons.refresh,
                          color: Colors.grey,
                        )
                      : Icon(
                          isSubscriber ? Icons.star : Icons.star_border,
                          color: Colors.white,
                        ),
                  onPressed: isLoading
                      ? null
                      : () {
                          favoriteEvent();
                          showSnackBar(isSubscriber);
                        },
                  label: isLoading
                      ? const Text(
                          'Processando',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      : Text(
                          isSubscriber
                              ? 'Remover de sua agenda'
                              : 'Adicionar à sua agenda',
                          style: const TextStyle(
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
                  widget.event.description == 'without description'
                      ? ''
                      : StringFormater.removeHtmlTags(
                          widget.event.description ?? ''),
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
                      widget.event.peopleLabel.isNotEmpty
                          ? widget.event.peopleLabel[0]
                          : '',
                      style: const TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 200,
                    child: ListView.builder(
                      itemCount: widget.event.peopleName.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () =>
                              Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ProfilePage(
                              event: widget.event,
                              index: index,
                            ),
                          )),
                          child: ListTile(
                            leading: widget.event.peopleUrlPicture[index] !=
                                    null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: SizedBox(
                                      width: 50,
                                      height: 50,
                                      child: CachedNetworkImage(
                                        imageUrl: widget
                                            .event.peopleUrlPicture[index],
                                        fit: BoxFit.cover,
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
                                    backgroundImage: AssetImage(
                                        'assets/images/user-icon.png'),
                                    backgroundColor: Colors.white,
                                  ),
                            title: widget.event.peopleName.isNotEmpty &&
                                    widget.event.peopleName[index] != null
                                ? Text(
                                    widget.event.peopleName[index],
                                  )
                                : const Text(''),
                            subtitle:
                                widget.event.peopleInstitution.isNotEmpty &&
                                        widget.event.peopleInstitution[index] !=
                                            null
                                    ? Text(
                                        widget.event.peopleInstitution[index],
                                      )
                                    : const Text(''),
                          ),
                        );
                      },
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
