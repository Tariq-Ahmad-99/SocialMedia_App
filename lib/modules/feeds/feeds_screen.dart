
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../shared/styles/colors.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({super.key});

  @override
  Widget build(BuildContext context)
  {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            elevation: 5.0,
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
          ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => buildPostItem(context),
              separatorBuilder: (context , index) => SizedBox(
                height: 8.0,
              ),
              itemCount: 10,
          ),
          SizedBox(
            height: 8.0,
          ),
        ],
      ),
    );
  }

  Widget buildPostItem(context) => Card(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 5.0,
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
          Text(
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry \'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 10.0,
              top: 5.0,
            ),
            child: Container(
              width: double.infinity,
              child: Wrap(
                children:
                [
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                      end: 6.0,
                    ),
                    child: Container(
                      height: 25.0,
                      child: MaterialButton(
                        onPressed: (){},
                        height: 25.0,
                        minWidth: 1.0,
                        padding: EdgeInsets.zero,
                        child: Text(
                          '#software',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: defaultColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                      end: 6.0,
                    ),
                    child: Container(
                      height: 25.0,
                      child: MaterialButton(
                        onPressed: (){},
                        height: 25.0,
                        minWidth: 1.0,
                        padding: EdgeInsets.zero,
                        child: Text(
                          '#flutter',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: defaultColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 140.0,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.0),
              image: DecorationImage(
                image: NetworkImage(
                    'https://img.freepik.com/free-photo/smartphone-screen-hand-with-social-media-icons_53876-128999.jpg?t=st=1722246240~exp=1722249840~hmac=ca047e0d68580497429c72a375d3edb584a38376135da55ff45d333c75c3f2c2&w=900'
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 5.0,
            ),
            child: Row(
              children:
              [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 5.0,
                    ),
                    child: InkWell(
                      child: Row(
                        children:
                        [
                          Icon(
                            EvaIcons.heartOutline,
                            size: 18.0,
                            color: Colors.red,
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            '120',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Colors.grey
                            ),
                          ),
                        ],
                      ),
                      onTap: (){},
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 5.0,
                    ),
                    child: InkWell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children:
                        [
                          Icon(
                            EvaIcons.messageCircleOutline,
                            size: 18.0,
                            color: Colors.amber,
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            '120 comment',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Colors.grey
                            ),
                          ),
                        ],
                      ),
                      onTap: (){},
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 10.0,
            ),
            child: Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],
            ),
          ),
          Row(
            children:
            [
              Expanded(
                child: InkWell(
                  child: Row(
                    children:
                    [
                      CircleAvatar(
                        radius: 18.0,
                        backgroundImage: NetworkImage(
                            'https://img.freepik.com/premium-photo/pretty-smiling-girl-swiping-imaginary-touch-screen-color-background-people-future-technology_274234-15776.jpg?ga=GA1.1.1892330260.1722245478&semt=ais_user'
                        ),
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      Text(
                        'write a comment ...',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: Colors.blueGrey[300],
                        ),
                      ),
                    ],
                  ),
                  onTap: (){},
                ),
              ),
              InkWell(
                child: Row(
                  children:
                  [
                    Icon(
                      EvaIcons.heartOutline,
                      size: 18.0,
                      color: Colors.red,
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      'Like',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey
                      ),
                    ),
                  ],
                ),
                onTap: (){},
              ),
            ],
          ),
        ],
      ),
    ),
  );

}
