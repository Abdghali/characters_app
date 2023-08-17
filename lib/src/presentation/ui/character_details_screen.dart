import 'package:casino_test/src/data/models/character/character.dart';
import 'package:flutter/material.dart';

class CharacterDetailsScreen extends StatelessWidget {
  final Character character;
  const CharacterDetailsScreen({Key? key, required this.character})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            backgroundColor: Colors.deepPurple,
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: character.image,
                child: Material(
                  child: Image.network(
                    character.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        title: Hero(
                          tag: '${character.image}_name',
                          child: Text(
                            character.name,
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple,
                            ),
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10),
                            Text(
                              "Status: ${character.status}",
                              style: TextStyle(
                                  fontSize: 18, color: Colors.grey[700]),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "Species: ${character.species}",
                              style: TextStyle(
                                  fontSize: 18, color: Colors.grey[700]),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "Last Known Location: ${character.location.name}",
                              style: TextStyle(
                                  fontSize: 18, color: Colors.grey[700]),
                            ),
                          ],
                        ),
                      ),
                      // Your additional content here
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
