//navigation menu on the right of the country page to easily navigate between the sections of the page
import 'package:flutter/material.dart';
import 'package:flutter_frontend/widgets/menu_item.dart';
import 'package:sticky_headers/sticky_headers.dart';

class CountrySectionsNavigation extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();
  final List<String> _sections = [
    'Sécurité',
    'Climat sociopolitique',
    'Droits des femmes et enfants',
    'Droit LGBT+',
    'Allergènes'
        'Us et coutumes',
    'Climat',
    'Conditions sanitaires',
    'Espace collaboratif',
  ]; //a modifier avec les Risk des country.dart

  void _scrollToSection() {
    // You can change the yOffset value according to your layout
    double yOffset = 300.0;
    _scrollController.animateTo(
      yOffset,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: StickyHeader(
        header: Column(
          children: <Widget>[
            // TODO: list view
            for (int i = 0; i < _sections.length; i++)
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  MenuItem(
                    onPressed: () => _scrollToSection(),
                    text: _sections[i],
                  ),
                ],
              ),
          ],
        ),
        content: SizedBox(
          height: MediaQuery.of(context).size.height * 4.4,
          width: 300,
        ),
      ),
    );
    //       ),
    //       ElevatedButton(
    //       onPressed: _scrollToSection,
    //       child: Text('Scroll To Section'),
    //     ),
    //   ),
    //   Center(
    //     child: Container(
    //       height: 300,
    //       width: 300,
    //       color: Colors.blue,
    //       child: Center(
    //         child: Text(
    //           'Section to scroll to',
    //           style: TextStyle(
    //             color: Colors.white,
    //           ),
    //         ),
    //       ),
    //     ),
    //   ),
    //   SizedBox(height: 100), // Placeholder space to demonstrate scrolling
    // ],
    //   ),
    // );
  }
}
