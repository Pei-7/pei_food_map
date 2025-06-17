import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'common.dart';
import 'cuisine.dart';
import 'restaurant.dart';

class ListPage extends StatefulWidget {
  final Cuisine cuisine;

  const ListPage({
    super.key,
    required this.cuisine,
  });

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  List _restaurantList = [];
  String? _errorText;
  bool _isLoading = true;

  void updateState({List items = const [], String? errorText}) {
    setState(() {
      _restaurantList = items;
      _errorText = errorText;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchList();
  }

  void fetchList() async {
    var response = await http.get(
        Uri.parse(
            'https://api.airtable.com/v0/appqNvg0QhjEh4fwr/Restaurant%20List?&view=Grid%20view'),
        headers: {
          'Authorization':
              'Bearer patrO2QrW5XdX7NAf.9f84aef20da4aa9d9a114e0361ae7d2dc1156961149d7600e69ce9eab22079d4'
        });
    try {
      if (response.statusCode == 200) {
        Map fetchedData = jsonDecode(response.body);
        List records = fetchedData['records'];
        List<Restaurant> restaurants =
            records.map((element) => Restaurant.fromJson(element)).toList();

        List<Restaurant> filteredRestaurants = restaurants.where((record) {
          List hashTags = record.hashTag;
          return hashTags.contains(widget.cuisine.englishName);
        }).toList();

        setState(() {
          updateState(items: filteredRestaurants);
        });
      } else {
        setState(() {
          updateState(errorText: 'Failed to load items');
        });
      }
    } catch (e) {
      setState(() {
        updateState(errorText: 'error: $e'); //
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${widget.cuisine.chineseName} ${widget.cuisine.englishName}",
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      body: Center(child: showContent()),
    );
  }

  Widget showContent() {
    if (_isLoading == true) {
      return const LoadingIndicator();
    } else if (_errorText != null) {
      return const Icon(Icons.cloud_off);
    } else {
      return RestaurantList(restaurantList: _restaurantList);
    }
  }
}

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        SizedBox(
            width: 60,
            height: 60,
            child: Image.asset('assets/walkingPerson.gif')),
        const Spacer(),
        const Text('Icons by Lordicon.com', style: TextStyle(fontSize: 9))
      ],
    );
  }
}

class RestaurantList extends StatelessWidget {
  const RestaurantList({
    super.key,
    required List restaurantList,
  }) : _restaurantList = restaurantList;

  final List _restaurantList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _restaurantList.length,
      itemBuilder: (context, index) {
        Restaurant restaurant = _restaurantList[index];
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RestaurantName(restaurant: restaurant),
              const Spacer(),
              RestaurantButtons(restaurant: restaurant),
            ],
          ),
        );
      },
    );
  }
}

class RestaurantButtons extends StatelessWidget {
  const RestaurantButtons({
    super.key,
    required this.restaurant,
  });

  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GoogleMapButton(restaurant: restaurant),
        LocationButton(restaurant: restaurant),
        CommentButton(restaurant: restaurant),
      ],
    );
  }
}

class GoogleMapButton extends StatelessWidget {
  const GoogleMapButton({
    super.key,
    required this.restaurant,
  });

  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        Uri uri = Uri.parse(restaurant.restaurantLink);
        try {
          //  如果可以打開，則 await 開啟瀏覽器
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri);
          } else {
            // 如果無法打開 URL，則進行錯誤處理
            throw 'Could not launch ${restaurant.restaurantLink}';
          }
        } catch (e) {
          print('error: $e');
        }
      },
      icon: const Icon(Icons.travel_explore),
    );
  }
}

class LocationButton extends StatelessWidget {
  const LocationButton({
    super.key,
    required this.restaurant,
  });

  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return MapDialogue(restaurant: restaurant);
            });
      },
      icon: const Icon(Icons.pin_drop),
    );
  }
}

class MapDialogue extends StatelessWidget {
  const MapDialogue({
    super.key,
    required this.restaurant,
  });

  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 8,
      insetPadding: const EdgeInsets.all(4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        alignment: AlignmentDirectional.topEnd,
        children: [
          ZoomableMap(restaurant: restaurant),
          const DisMissButton(),
        ],
      ),
    );
  }
}

class ZoomableMap extends StatelessWidget {
  const ZoomableMap({
    super.key,
    required this.restaurant,
  });

  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
        width: (screenHeight > screenWidth)
            ? screenWidth * 0.96
            : screenHeight * 0.8 / 1251 * 1063, //地圖圖片比例 1024:1120
        height: (screenHeight > screenWidth)
            ? screenWidth * 0.96 / 1063 * 1251
            : screenHeight * 0.8,
        alignment: Alignment.center,
        child: InteractiveViewer(
          minScale: 1,
          maxScale: 5,
          child: Stack(
            fit: StackFit.expand,
            alignment: Alignment.center,
            children: [
              Image.asset('assets/background.png', fit: BoxFit.cover),
              Image.network(restaurant.imageLink, fit: BoxFit.cover),
            ],
          ),
        ));
  }
}

class DisMissButton extends StatelessWidget {
  const DisMissButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          Icons.cancel,
          color: Colors.grey.withAlpha(180),
        ));
  }
}

class CommentButton extends StatelessWidget {
  const CommentButton({super.key, required this.restaurant});

  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return SizedBox(
                height: ScreenSize.getStandardSize(context).height * 0.42,
                child: Column(
                  children: [
                    NoteTitle(restaurant: restaurant),
                    NoteContent(restaurant: restaurant),
                  ],
                ),
              );
            });
      },
      icon: const Icon(Icons.sticky_note_2_outlined),
    );
  }
}

class NoteContent extends StatelessWidget {
  const NoteContent({
    super.key,
    required this.restaurant,
  });

  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: ListTile(
            title: Text(restaurant.notes),
          ),
        ),
      ),
    );
  }
}

class NoteTitle extends StatelessWidget {
  const NoteTitle({
    super.key,
    required this.restaurant,
  });

  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        '${restaurant.restaurantNameChi} ${restaurant.restaurantNameEng} test',
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}

class RestaurantName extends StatelessWidget {
  const RestaurantName({
    super.key,
    required this.restaurant,
  });

  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          restaurant.restaurantNameChi,
          style: const TextStyle(fontSize: 16),
        ),
        Text(
          restaurant.restaurantNameEng,
          style: const TextStyle(fontSize: 14),
        ),
      ],
    );
  }
}
