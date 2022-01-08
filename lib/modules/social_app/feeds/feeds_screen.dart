import 'package:flutter/material.dart';
import 'package:social_app/shared/styles/colors.dart';

class FeedsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          // Card(
          //   clipBehavior: Clip.antiAliasWithSaveLayer,
          //   elevation: 10.0,
          //   margin: EdgeInsets.all(8.0),
          //   child: Stack(
          //     alignment: AlignmentDirectional.bottomEnd,
          //     children: [
          //       Image(
          //         image: NetworkImage(
          //             "https://image.freepik.com/free-photo/portrait-beautiful-young-woman-gesticulating_273609-41056.jpg"),
          //         fit: BoxFit.cover,
          //         height: 200.0,
          //         width: double.infinity,
          //       ),
          //       Padding(
          //         padding: const EdgeInsets.all(8.0),
          //         child: Text(
          //           'communication with friends',
          //           style: Theme.of(context).textTheme.subtitle1,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => buildPostItem(context),
            itemCount: 3,
            separatorBuilder: (context, index) => SizedBox(
              height: 15.0,
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
        ],
      ),
    );
  }

  Widget buildPostItem(context) => Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 5.0,
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 25.0,
                    backgroundImage: NetworkImage(
                        'https://image.freepik.com/free-photo/joyful-afro-woman-raises-arms-tilts-head-dressed-casual-knitted-jumper-laughs-from-happiness-celebrates-victory-isolated-yellow_273609-32594.jpg'),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Tarek El-sayed',
                              style: TextStyle(height: 1.0),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Icon(
                              Icons.check_circle,
                              size: 15,
                              color: defaultColor,
                            ),
                          ],
                        ),
                        Text(
                          'January 03 2022 at 07:00 pm',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.more_horiz,
                      size: 18.0,
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey[300],
                ),
              ),
              Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat",
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                child: Container(
                  width: double.infinity,
                  child: Wrap(
                    children: [
                      Container(
                        height: 25.0,
                        child: MaterialButton(
                          minWidth: 1.0,
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          child: Text(
                            '#Software',
                            style: TextStyle(color: defaultColor),
                          ),
                        ),
                      ),
                      Container(
                        height: 25.0,
                        child: MaterialButton(
                          minWidth: 1.0,
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          child: Text(
                            '#JavaScript',
                            style: TextStyle(color: defaultColor),
                          ),
                        ),
                      ),
                      Container(
                        height: 25.0,
                        child: MaterialButton(
                          minWidth: 1.0,
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          child: Text(
                            '#Dart',
                            style: TextStyle(color: defaultColor),
                          ),
                        ),
                      ),
                      Container(
                        height: 25.0,
                        child: MaterialButton(
                          minWidth: 1.0,
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          child: Text(
                            '#flutter',
                            style: TextStyle(color: defaultColor),
                          ),
                        ),
                      ),
                      Container(
                        height: 25.0,
                        child: MaterialButton(
                          minWidth: 1.0,
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          child: Text(
                            '#CSS',
                            style: TextStyle(color: defaultColor),
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
                        "https://image.freepik.com/free-photo/portrait-beautiful-young-woman-gesticulating_273609-41056.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.favorite_outline,
                              size: 18,
                              color: Colors.red,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              '1200',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  .copyWith(fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.message_outlined,
                              size: 18,
                              color: Colors.red,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              '120 comment',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  .copyWith(fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey[300],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 18.0,
                            backgroundImage: NetworkImage(
                                'https://image.freepik.com/free-photo/joyful-afro-woman-raises-arms-tilts-head-dressed-casual-knitted-jumper-laughs-from-happiness-celebrates-victory-isolated-yellow_273609-32594.jpg'),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            'Write a comment...',
                            style: Theme.of(context)
                                .textTheme
                                .caption
                                .copyWith(fontSize: 16.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Row(
                      children: [
                        Icon(
                          Icons.favorite_outline,
                          size: 18,
                          color: Colors.red,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Like',
                          style: Theme.of(context)
                              .textTheme
                              .caption
                              .copyWith(fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
