import 'package:flutter/material.dart';
import 'package:full_db/services/nosql_sevice.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../models/nosql_card.dart';
import '../models/sql_card.dart';
import '../services/pref_service.dart';
import '../services/sql_service.dart';


class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController expiredDateController = TextEditingController();

  String cardNumber = '0000 0000 0000 0000';
  String expiredDate = '12/12';

  var cardNumberMaskFormatter = MaskTextInputFormatter(
    mask: '#### #### #### ####',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );
  var expiredDateMaskFormatter = MaskTextInputFormatter(
    mask: '##/##',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  saveCardToDB() async {
    var isSql = await Prefs.loadTypeDatabase();
    if(isSql){
      saveSqlCard();
    }else{
      saveNoSqlCard();
    }
  }

  saveNoSqlCard() {
    setState(() {
      String cardNumber = cardNumberController.text;
      String expiredDate = expiredDateController.text;

      NoSqlCard noSqlCard =
      NoSqlCard(cardNumber: cardNumber, expiredDate: expiredDate);

      if (cardNumber.trim().isEmpty || cardNumber.length < 16) {
        return;
      }

      if (expiredDate.trim().isEmpty || expiredDate.length < 5) {
        return;
      }

      if (cardNumber.startsWith('4')) {
        noSqlCard.cardImage = 'assets/images/ic_card_visa.png';
        noSqlCard.cardType = 'visa';
      } else if (cardNumber.startsWith('5')) {
        noSqlCard.cardImage = 'assets/images/ic_card_master.png';
        noSqlCard.cardType = 'master';
      } else {
        return;
      }
      NoSqlService.saveNoSqlCard(noSqlCard);
      backToFinish();
    });
  }

  saveSqlCard() {
    setState(() {
      String cardNumber = cardNumberController.text;
      String expiredDate = expiredDateController.text;

      SqlCard sqlCard =
      SqlCard(cardNumber: cardNumber, expiredDate: expiredDate);

      if (cardNumber.trim().isEmpty || cardNumber.length < 16) {
        return;
      }

      if (expiredDate.trim().isEmpty || expiredDate.length < 5) {
        return;
      }

      if (cardNumber.startsWith('4')) {
        sqlCard.cardImage = 'assets/images/ic_card_visa.png';
        sqlCard.cardType = 'visa';
      } else if (cardNumber.startsWith('5')) {
        sqlCard.cardImage = 'assets/images/ic_card_master.png';
        sqlCard.cardType = 'master';
      } else {
        return;
      }
      SqlService.createPost(sqlCard);
      backToFinish();
    });
  }

  backToFinish() {
    Navigator.of(context).pop(true);
  }

  String getCardType() {
    if (cardNumber.isEmpty) {
      return '';
    }
    if (cardNumber.startsWith('4')) {
      return 'VISA';
    } else if (cardNumber.startsWith('5')) {
      return 'MASTER';
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Card')),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  AspectRatio(
                    aspectRatio: 1005 / 555,
                    child: Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/im_card_bg.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  getCardType(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      cardNumber,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      expiredDate,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        child: const Text(
                          'Card details',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    height: 45,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(7)),
                    child: TextField(
                      controller: cardNumberController,
                      textAlignVertical: TextAlignVertical.bottom,
                      decoration: InputDecoration(
                        hintText: 'Card number',
                        hintStyle: const TextStyle(color: Colors.grey),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                          borderSide: BorderSide(color: Colors.grey.shade200),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          cardNumber = value;
                        });
                      },
                      inputFormatters: [cardNumberMaskFormatter],
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    height: 45,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(7)),
                    child: TextField(
                      controller: expiredDateController,
                      textAlignVertical: TextAlignVertical.bottom,
                      decoration: InputDecoration(
                        hintText: 'Expired date',
                        hintStyle: const TextStyle(color: Colors.grey),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                          borderSide: BorderSide(color: Colors.grey.shade200),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          expiredDate = value;
                        });
                      },
                      inputFormatters: [expiredDateMaskFormatter],
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    child: const Text(
                      'Only Visa and MasterCards supported',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.blue,
              ),
              child: MaterialButton(
                onPressed: () {
                  saveCardToDB();
                },
                child: const Text(
                  'Save Card',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}