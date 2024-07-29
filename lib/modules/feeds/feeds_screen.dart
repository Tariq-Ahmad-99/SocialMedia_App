
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../shared/styles/colors.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({super.key});

  @override
  Widget build(BuildContext context)
  {
    return Column(
      children: [
        Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          elevation: 10.0,
          margin: EdgeInsets.all(8.0),
          child: Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              Image(
                image: NetworkImage(
                  'https://img.freepik.com/free-photo/smartphone-screen-hand-with-social-media-icons_53876-128999.jpg?t=st=1722246240~exp=1722249840~hmac=ca047e0d68580497429c72a375d3edb584a38376135da55ff45d333c75c3f2c2&w=900'
                ),
                fit: BoxFit.fitWidth,
                height: 200.0,
                width: double.infinity,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Communicate With Friends',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          elevation: 10.0,
          margin: EdgeInsets.symmetric(
            horizontal: 8.0,
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children:
              [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25.0,
                      backgroundImage: NetworkImage(
                        'https://img.freepik.com/premium-photo/pretty-smiling-girl-swiping-imaginary-touch-screen-color-background-people-future-technology_274234-15776.jpg?ga=GA1.1.1892330260.1722245478&semt=ais_user'
                      ),
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:
                          [
                            Row(
                              children: [
                                Text(
                                  'Tariq Ahmed',
                                  style: TextStyle(
                                    height: 1.4,
                                  ),
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Icon(
                                  Icons.check_circle,
                                  color: defaultColor,
                                  size: 16.0,
                                ),
                              ],
                            ),
                            Text(
                              'Jon 21, 2024 at 12:00 pm',
                              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                color: Colors.blueGrey[300],
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    IconButton(
                        onPressed: (){},
                        icon: Icon(
                          Icons.more_horiz,
                          size: 16.0,
                        ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 15.0,
                  ),
                  child: Container(
                    width: double.infinity,
                    height: 1.0,
                    color: Colors.grey[300],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
