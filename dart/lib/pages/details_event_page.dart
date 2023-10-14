import 'package:chuva_dart/providers/event_provider.dart';
import 'package:chuva_dart/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../components/person_info_component.dart';
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
  bool isSubscriber = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    void showSnackBar(bool isSubscriber) {
      if (isSubscriber) {
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
                          setState(() {
                            isSubscriber = !isSubscriber;

                            setState(() => isLoading = true);

                            Provider.of<EventProvider>(context, listen: false)
                                .toogleFavorite(widget.event)
                                .then((value) {
                              setState(
                                () => isLoading = false,
                              );
                            });

                            showSnackBar(isSubscriber);
                          });
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
                  widget.event.peopleName.isNotEmpty &&
                          widget.event.peopleInstitution.isNotEmpty
                      ? PersonInfoComponent(
                          event: widget.event,
                          onTap: () => context.push(AppRoutes.PROFILE_PAGE,
                              extra: widget.event),
                        )
                      : const SizedBox(),
                ],
              )
            ],
          ),
        ));
  }
}
