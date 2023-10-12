import 'package:flutter/material.dart';
import '../components/app_bar_component.dart';

class DetailsEventPage extends StatelessWidget {
  const DetailsEventPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 70),
          child: AppBarComponent(
            subtitleOn: false,
          ),
        ),
        body: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.purple,
              ),
              padding: EdgeInsets.all(5),
              child: Text(
                'Astrofísica e Cosmologia',
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
                'A Física dos Buracos Negros Supermassivos',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5, bottom: 5),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        color: Color(0xff306dc3),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text('Domingo 07:00h - 08:00h'),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Color(0xff306dc3),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text('Maputo'),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
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
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                'A física dos buracos negros supermassivos explora fenômenos intensos e enigmáticos no universo. Esses objetos astronômicos, com milhões a bilhões de vezes a massa do Sol, influenciam fortemente sua vizinhança cósmica, afetando a evolução das galáxias, e desafiando nosso entendimento sobre gravidade e a natureza do espaço-tempo.',
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, bottom: 5),
                  child: Text(
                    'Palestrante',
                    style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.green,
                  ),
                  title: Text('Stephen Willian Hawking'),
                  subtitle: Text('Universidade de Cambridge'),
                )
              ],
            )
          ],
        ));
  }
}
