import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../models/event_model.dart';
import '../utils/app_routes.dart';
import '../utils/date_formater.dart';
import 'components/card_info_component.dart';
import 'components/header_top_component.dart';
import 'components/app_bar_component.dart';

import '../providers/event_provider.dart';
import 'pages/details_event_page.dart';

void main() {
  runApp(const ChuvaDart());
}

class ChuvaDart extends StatelessWidget {
  const ChuvaDart({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => EventProvider(),
        )
      ],
      child: MaterialApp.router(
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('pt', 'BR')],
        routerConfig: GoRouter(
          routes: [
            GoRoute(
              path: AppRoutes.HOME,
              builder: (context, state) => const Calendar(),
            ),
            GoRoute(
              path: AppRoutes.DETAILS_PAGE,
              builder: (context, state) {
                final eventModel = state.extra as EventModel;

                return DetailsEventPage(
                  event: eventModel,
                );
              },
            ),
          ],
        ),
        title: 'Exercicio chuva',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
      ),
    );
  }
}

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime _currentDate = DateTime(2023, 11, 26);

  final List<String> daysMonth = ['26', '27', '28', '29', '30'];

  void _changeDate(DateTime newDate) {
    setState(() {
      _currentDate = newDate;
    });
  }

  int currentPage = 0;
  String dayMonth = '26';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    Provider.of<EventProvider>(context, listen: false)
        .getEvents()
        .then((value) {
      setState(() {
        isLoading = false;
      });
    });
  }

  Future<void> refreshPage() async {
    Provider.of<EventProvider>(context, listen: false)
        .getEvents()
        .then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final items = Provider.of<EventProvider>(context, listen: false).items;

    final filteredList =
        items.where((e) => DateFormater.dayFormater(e.start) == dayMonth);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 100),
        child: AppBarComponent(
          onPressed: () {},
        ),
      ),
      body: RefreshIndicator(
        onRefresh: refreshPage,
        child: Column(
          children: [
            const HeaderComponent(),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          DateFormater.abbreviatedMonth(_currentDate),
                          style: const TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w400),
                        ),
                        Text(
                          _currentDate.year.toString(),
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Container(
                    color: const Color(0xff306dc3),
                    height: 60,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: daysMonth.length,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  currentPage = index;
                                  dayMonth = daysMonth[index];
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Text(
                                  daysMonth[index],
                                  style: TextStyle(
                                    color: currentPage == index
                                        ? Colors.white
                                        : const Color(0xffb0c3e1),
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      itemCount: filteredList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => context.push(AppRoutes.DETAILS_PAGE,
                              extra: filteredList.elementAt(index)),
                          child: CardInfoComponent(
                            eventModel: filteredList.elementAt(index),
                          ),
                        );
                      }),
            ),
          ],
        ),
      ),
    );
  }
}

class Activity extends StatefulWidget {
  const Activity({super.key});

  @override
  State<Activity> createState() => _ActivityState();
}

class _ActivityState extends State<Activity> {
  bool _favorited = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.inversePrimary,
      child: Column(children: [
        Text(
          'Activity title',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const Text('A Física dos Buracos Negros Supermassivos'),
        const Text('Domingo 07:00h - 08:00h'),
        const Text('Sthepen William Hawking'),
        const Text('Maputo'),
        const Text('Astrofísica e Cosmologia'),
        ElevatedButton.icon(
          onPressed: () {
            setState(() {
              _favorited = !_favorited;
            });
          },
          icon: _favorited
              ? const Icon(Icons.star)
              : const Icon(Icons.star_outline),
          label: Text(
              _favorited ? 'Remover da sua agenda' : 'Adicionar à sua agenda'),
        )
      ]),
    );
  }
}
