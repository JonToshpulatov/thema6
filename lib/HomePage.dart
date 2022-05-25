import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PageController _pageController;
  int _selectedpage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Demo'),
        centerTitle: true,
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (int index) {
          setState(() {
            _selectedpage = index;
          });
        },
        children: [
          Container(
            color: Colors.blue,
          ),
          Container(
            color: Colors.red,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.business), label: "Businnes"),
        ],
        currentIndex: _selectedpage,
        selectedItemColor: Colors.red,
        onTap: (int index) {
          setState(() {
            _selectedpage = index;
            _pageController.animateToPage(index,
                duration: Duration(microseconds: 200), curve: Curves.easeIn);
          });
        },
      ),
    );
  }
}
