import 'package:flutter/material.dart';
import 'package:full_db/pages/setting_page.dart';

import '../models/nosql_card.dart';
import '../models/sql_card.dart';
import '../services/nosql_sevice.dart';
import '../services/pref_service.dart';
import '../services/sql_service.dart';
import 'details_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isSql = true;
  List<SqlCard> sqlCards = [];
  List<NoSqlCard> noSqlCards = [];

  Future openDetailsPage() async {
    var result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return const DetailsPage();
        },
      ),
    );
    loadCards();
  }

  Future openSettingPage() async {
    bool? isSql;
    var typeDatabase = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return  SettingPage(isSql: isSql,);
        },
      ),
    );
    isSql = typeDatabase;
    loadCards();
  }

  loadCards() async {
    isSql = await Prefs.loadTypeDatabase();
    if (isSql) {
      var myCards = await SqlService.fetchSqlCards();
      setState(() {
        sqlCards = myCards;
        noSqlCards.clear();
      });
    } else{
      var myCards = NoSqlService.fetchNoSqlCard();
      setState(() {
        noSqlCards = myCards;
        sqlCards.clear();
      });
    }
    print(sqlCards.length.toString());
    print(noSqlCards.length.toString());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadCards();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'My cards',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        actions: [
          IconButton(
            onPressed: () {
              openSettingPage();
            },
            icon: const Icon(Icons.settings),
          ),
          const SizedBox(width: 10)
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: isSql ? ListView.builder(
                itemCount: sqlCards.length,
                itemBuilder: (ctx, i) {
                  return _itemSqlCardList(sqlCards[i]);
                },
              ) : ListView.builder(
                itemCount: noSqlCards.length,
                itemBuilder: (ctx, i) {
                  return _itemNoSqlCardList(noSqlCards[i]);
                },
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
                  openDetailsPage();
                },
                child: const Text(
                  'Add Card',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _itemSqlCardList(SqlCard card) {
    return GestureDetector(
      onLongPress: () {
        // print(typeDatabase);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(5),
        height: 80,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey.shade200,
        ),
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 15),
              child: Image(image: AssetImage(card.cardImage!)),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '**** **** **** ${card.cardNumber!.substring(card.cardNumber!.length - 4)}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  card.expiredDate!,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _itemNoSqlCardList(NoSqlCard card) {
    return GestureDetector(
      onLongPress: () {
        // print(typeDatabase);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(5),
        height: 80,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey.shade200,
        ),
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 15),
              child: Image(image: AssetImage(card.cardImage!)),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '**** **** **** ${card.cardNumber!.substring(card.cardNumber!.length - 4)}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  card.expiredDate!,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
