import 'package:casino_test/src/data/models/character/character.dart';
import 'package:flutter/material.dart';

import '../ui/character_details_screen.dart';

class CharacterCard extends StatelessWidget {
  final Character character;
  CharacterCard({required this.character});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => CharacterDetailsScreen(character: character),
          ),
        );
      },
      child: Container(
        alignment: Alignment.topLeft,
        padding: EdgeInsets.all(12),
        child: Container(
          padding: EdgeInsets.all(14),
          width: double.infinity,
          decoration: ShapeDecoration(
            color: Color.fromARGB(120, 204, 255, 255),
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(32),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100.0),
                  child: Material(
                    child: Hero(
                        tag: character.image,
                        child: Material(child: Image.network(character.image))),
                  ),
                ),
              ),
              SizedBox(width: 6),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Hero(
                        tag: '${character.image}_name',
                        child: Text(
                          character.name,
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(2.0),
                      child: Text(
                        'Last known location:',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.normal,
                              fontSize: 15,
                              color: Colors.grey,
                            ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(2.0),
                      child: Text(
                        character.location.name!,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.normal,
                              fontSize: 16,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Icon(
                  character.status.toLowerCase() == 'alive'
                      ? Icons.favorite
                      : Icons.heart_broken_outlined,
                  color: character.status.toLowerCase() == 'alive'
                      ? Colors.red
                      : Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
