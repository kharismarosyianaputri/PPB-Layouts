import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 231, 219, 233),
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          title: Center(
            child: Text(
              'Recipes',
              style: TextStyle(fontSize: 25),
            ),
          ),
        ),
        body: ListView(
          children: [
            ImageCarousel(),
            SizedBox(height: 50),
            // Add other sections here
            ReviewSection(
              username: 'Zayyan',
              review: 'Rasanya juara banget loch',
              avatarIcon: Icons.person,
              rating: 4,
              isUserReview: true, // This is a user review
            ),
            ReviewSection(
              username: 'Farzan',
              review:
                  'Biasa aja sih, kemasan dan rasa standar',
              avatarIcon: Icons.person,
              rating: 2,
              isUserReview: true, // This is a user review
            ),
            ReviewSection(
              username: 'Zayra',
              review:
                  'Harga kaki lima, rasa bintang lima',
              avatarIcon: Icons.person,
              rating: 5,
              isUserReview: true, // This is a user review
            ),
          ],
        ),
        drawer: Drawer(
          backgroundColor: Colors.white,
          child: SafeArea(
            child: Column(
              children: [
                ListTile(
                  leading: Icon(
                    Icons.home,
                    color: Colors.black,
                  ),
                  title: Text(
                    "Home",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.list,
                    color: Colors.black,
                  ),
                  title: Text(
                    "Lists Menu",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  title: Text(
                    "Search Menu",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {},
          label: Container(
            width: 200,
            child: Center(
              child: Text(
                "Recipe",
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
          ),
          backgroundColor: Colors.blueAccent,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}

class ImageCarousel extends StatefulWidget {
  @override
  _ImageCarouselState createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  final List<Map<String, dynamic>> imagePaths = [
    {
      'imagePath': 'images/sate.jpg',
      'foodName': 'Sate Kambing',
      'rating': 5,
    },
    {
      'imagePath': 'images/geprek.jpg',
      'foodName': 'Ayam Geprek',
      'rating': 4,
    },
    {
      'imagePath': 'images/gado-gado.jpg',
      'foodName': 'Gado-Gado',
      'rating': 4,
    },
  ];

  int _currentPage = 0;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  @override
  void dispose() {
    _stopAutoScroll();
    super.dispose();
  }

  void _startAutoScroll() {
    Future.delayed(const Duration(seconds: 3), _scrollToNextPage);
  }

  void _stopAutoScroll() {
    _pageController.dispose();
  }

  void _scrollToNextPage() {
    if (_currentPage < imagePaths.length - 1) {
      _currentPage++;
    } else {
      _currentPage = 0;
    }

    if (mounted) {
      _pageController
          .animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeIn,
      )
          .then((_) {
        _startAutoScroll();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: PageView.builder(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentPage = index;
          });
        },
        itemCount: imagePaths.length,
        itemBuilder: (context, index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                imagePaths[index]['imagePath'],
                height: 200,
                width: 300,
                fit: BoxFit.fitWidth,
              ),
              SizedBox(height: 10),
              if (imagePaths[index]['foodName'] != '')
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${imagePaths[index]['foodName']}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              StarRating(rating: imagePaths[index]['rating']),
            ],
          );
        },
      ),
    );
  }
}

class ReviewSection extends StatelessWidget {
  final String username;
  final String review;
  final IconData avatarIcon;
  final String foodName;
  final int rating;
  final bool isUserReview;

  const ReviewSection({
    required this.username,
    required this.review,
    required this.avatarIcon,
    required this.rating,
    this.foodName = '',
    this.isUserReview = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(25, 10, 25, 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 15,
                child: Icon(avatarIcon),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      username,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 10),
                    if (isUserReview)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          StarRating(rating: rating),
                        ],
                      )
                    else if (foodName.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Food: $foodName',
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 5),
          Text(review),
        ],
      ),
    );
  }
}

class StarRating extends StatelessWidget {
  final int rating;
  static const int maxRating = 5;

  const StarRating({required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        maxRating,
        (index) {
          if (index < rating) {
            return Icon(
              Icons.star,
              color: Colors.orange,
              size: 16,
            );
          } else {
            return Icon(
              Icons.star,
              color: Colors.grey,
              size: 16,
            );
          }
        },
      ),
    );
  }
}