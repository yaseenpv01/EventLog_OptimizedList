import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'eventbus.dart';

final eventBus = EventBus();
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    eventBus.subscribe().listen((event) {
      if (event is String) {
        print("Event received: $event");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Optimized List with GIFs and Timers'),
      ),
      body: CountdownList(),
    );
  }
}

class CountdownList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 1000,
      itemBuilder: (context, index) {
        return CountdownItem(index: index);
      },
    );
  }
}

class CountdownItem extends StatefulWidget {
  final int index;

  CountdownItem({required this.index});

  @override
  _CountdownItemState createState() => _CountdownItemState();
}

class _CountdownItemState extends State<CountdownItem> with AutomaticKeepAliveClientMixin {
  late int countdown;
  late Timer timer;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    countdown = 60;

    // Initialize the countdown timer
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (countdown > 0) {
        setState(() {
          countdown--;
        });
        if (countdown == 0) {
        }
      }
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Card(
      child: ListTile(
        leading: CachedNetworkImage(
          imageUrl: 'https://media.giphy.com/media/JIX9t2j0ZTN9S/giphy.gif',
          placeholder: (context, url) => CircularProgressIndicator(),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        title: Text('Item ${widget.index}'),
        subtitle: Text('Countdown: $countdown seconds'),
      ),
    );
  }
}