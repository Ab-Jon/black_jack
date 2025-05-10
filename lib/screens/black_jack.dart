import 'dart:math';

import 'package:black_jack/widgets/custom_button.dart';
import 'package:flutter/material.dart';

import '../widgets/cards_grid_view.dart';

class BlackJack extends StatefulWidget {
  const BlackJack({super.key});

  @override
  State<BlackJack> createState() => _BlackJackState();
}

class _BlackJackState extends State<BlackJack> {
  bool _isGameStarted = false;

  // Card images
  List<Image> _dealerCards = [];
  List<Image> _myCards = [];

  //Cards
  String? dealerFirstCard;
  String? dealerSecondCard;

  String? playerFirstCard;
  String? playerSecondCard;

  //Scores
  int dealerScore = 0;
  int playerScore = 0;

  final Map<String, int> deckOfCards = {
    "cards/2.1.png": 2,
    "cards/2.2.png": 2,
    "cards/2.3.png": 2,
    "cards/2.4.png": 2,
    "cards/3.1.png": 3,
    "cards/3.2.png": 3,
    "cards/3.3.png": 3,
    "cards/3.4.png": 3,
    "cards/4.1.png": 4,
    "cards/4.2.png": 4,
    "cards/4.3.png": 4,
    "cards/4.4.png": 4,
    "cards/5.1.png": 5,
    "cards/5.2.png": 5,
    "cards/5.3.png": 5,
    "cards/5.4.png": 5,
    "cards/6.1.png": 6,
    "cards/6.2.png": 6,
    "cards/6.3.png": 6,
    "cards/6.4.png": 6,
    "cards/7.1.png": 7,
    "cards/7.2.png": 7,
    "cards/7.3.png": 7,
    "cards/7.4.png": 7,
    "cards/8.1.png": 8,
    "cards/8.2.png": 8,
    "cards/8.3.png": 8,
    "cards/8.4.png": 8,
    "cards/9.1.png": 9,
    "cards/9.2.png": 9,
    "cards/9.3.png": 9,
    "cards/9.4.png": 9,
    "cards/10.1.png": 10,
    "cards/10.2.png": 10,
    "cards/10.3.png": 10,
    "cards/10.4.png": 10,
    "cards/J1.png": 10,
    "cards/J2.png": 10,
    "cards/J3.png": 10,
    "cards/J4.png": 10,
    "cards/Q1.png": 10,
    "cards/Q2.png": 10,
    "cards/Q3.png": 10,
    "cards/Q4.png": 10,
    "cards/K1.png": 10,
    "cards/K2.png": 10,
    "cards/K3.png": 10,
    "cards/K4.png": 10,
    "cards/A1.png": 11,
    "cards/A2.png": 11,
    "cards/A3.png": 11,
    "cards/A4.png": 11,
  };
  Map<String, int> playingCards = {};

  @override
  void initState() {
    super.initState();
    playingCards.addAll(deckOfCards);
  }

  void changeCards() {
    _isGameStarted = true;
    // Start new round with full deck of cards
    playingCards = {};
    playingCards.addAll(deckOfCards);

    // reset card images
    _myCards = [];
    _dealerCards = [];

    Random random = Random();

    // random card one for dealer
    String cardOneKey =
        playingCards.keys.elementAt(random.nextInt(playingCards.keys.length));
    playingCards.removeWhere((key, value) => key == cardOneKey);

    // random card two for dealer
    String cardTwoKey =
        playingCards.keys.elementAt(random.nextInt(playingCards.keys.length));
    playingCards.removeWhere((key, value) => key == cardTwoKey);

    // random card one for player
    String cardThreeKey =
        playingCards.keys.elementAt(random.nextInt(playingCards.keys.length));
    playingCards.removeWhere((key, value) => key == cardThreeKey);

    // random card two for player
    String cardFourKey =
        playingCards.keys.elementAt(random.nextInt(playingCards.keys.length));
    playingCards.removeWhere((key, value) => key == cardFourKey);

    //Assign card keys to dealer's cards
    dealerFirstCard = cardOneKey;
    dealerSecondCard = cardTwoKey;

    //Assign card keys to player's cards
    playerFirstCard = cardThreeKey;
    playerSecondCard = cardFourKey;

    //Adding dealers cards to display them in grid view
    _dealerCards.add(Image.asset(dealerFirstCard!));
    _dealerCards.add(Image.asset(dealerSecondCard!));

    // Score for dealer
    dealerScore =
        deckOfCards[dealerFirstCard]! + deckOfCards[dealerSecondCard]!;

    //Adding players cards to display them in grid view
    _myCards.add(Image.asset(playerFirstCard!));
    _myCards.add(Image.asset(playerSecondCard!));

    // Score for player
    playerScore =
        deckOfCards[playerFirstCard]! + deckOfCards[playerSecondCard]!;
    setState(() {});

    if (dealerScore < 14) {
      String thirdDealerCard =
          playingCards.keys.elementAt(random.nextInt(playingCards.keys.length));
      playingCards.removeWhere((key, value) => key == thirdDealerCard);

      _dealerCards.add(Image.asset(thirdDealerCard));
      dealerScore += deckOfCards[thirdDealerCard]!;
      setState(() {});
    }
  }

  void addCard() {
    Random random = Random();

    if (playingCards.isNotEmpty) {
      String cardKey =
          playingCards.keys.elementAt(random.nextInt(playingCards.keys.length));
      playingCards.removeWhere((key, value) => key == cardKey);

      _myCards.add(Image.asset(cardKey));
      playerScore += deckOfCards[cardKey]!;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isGameStarted
          ? SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text("Dealer's Score: $dealerScore",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: dealerScore < 21
                                  ? Colors.green[900]
                                  : Colors.red[900])),

                      //Dealer's card
                      CardsGridView(cards: _dealerCards)
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "Player's Score: $playerScore",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: playerScore < 21
                                ? Colors.green[900]
                                : Colors.red[900]),
                      ),

                      //Player's cards
                      CardsGridView(cards: _myCards)
                    ],
                  ),
                  IntrinsicWidth(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CustomButton(
                            onPressed: () {
                              setState(() {
                                addCard();
                              });
                            },
                            label: "Another Card"),
                        CustomButton(
                            onPressed: () {
                              setState(() {
                                changeCards();
                              });
                            },
                            label: "Next Round")
                      ],
                    ),
                  ),
                ],
              ),
            )
          : Center(
              child: CustomButton(
                  onPressed: () => changeCards(),
                  label: "Start Game")),
    );
  }
}

