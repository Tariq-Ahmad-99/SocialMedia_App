import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context)
  {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children:
        [
          Container(
            height: 190.0,
            child: Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children:
              [
                Align(
                  alignment: AlignmentDirectional.topCenter,
                  child: Container(
                    height: 140.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(4.0),
                        topRight: Radius.circular(4.0),
                      ),
                      image: DecorationImage(
                        image: NetworkImage(
                            'https://img.freepik.com/free-vector/flat-twitch-banner-template-indian-republic-day_23-2151031339.jpg?t=st=1722855611~exp=1722859211~hmac=144ec11ced5acab93dc18df8d6b4e7a5bb91fd3165dcd1e4a12e2ae16c214f9d&w=1060'
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                CircleAvatar(
                  radius: 64.0,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  child: CircleAvatar(
                    radius: 60.0,
                    backgroundImage: NetworkImage(
                        'https://img.freepik.com/premium-photo/pretty-smiling-girl-swiping-imaginary-touch-screen-color-background-people-future-technology_274234-15776.jpg?ga=GA1.1.1892330260.1722245478&semt=ais_user'
                    ),
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
