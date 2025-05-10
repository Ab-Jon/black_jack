import 'package:flutter/material.dart';

class CardsGridView extends StatelessWidget {
  const CardsGridView({
    super.key,
    required List<Image> cards,
  }) : _cards = cards;

  final List<Image> _cards;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: GridView.builder(
          gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3),
          itemCount: _cards.length,
          itemBuilder: (context, index) {
            return Padding(
              padding:
              const EdgeInsets.symmetric(vertical: 13.0),
              child: _cards[index],
            );
          }),
    );
  }
}

