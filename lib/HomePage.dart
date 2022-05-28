import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{
  late AnimationController _controller;
  late Animation _animation;
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  late PageController _pageController;
  int _selectedpage = 0;
  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1200));
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
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
          Page1(),
          Page(),
          Page3(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.business), label: "Businnes"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settongs')
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

Widget Page() {
  final _formKey = GlobalKey<FormState>();
  void _doSign() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      print("Welcome");
    }
  }

  String? _email, _password;

  return Scaffold(
    backgroundColor: Colors.grey,
    body: Form(
      key: _formKey,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              height: 55,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
              ),
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: "email", contentPadding: EdgeInsets.all(8)),
                validator: (input) =>
                    !input!.contains("@") ? "please enter a valid email" : null,
                onSaved: (input) => _email = input,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              height: 55,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
              ),
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: "password", contentPadding: EdgeInsets.all(8)),
                validator: (input) => !input!.contains("@")
                    ? "please enter a valid password"
                    : null,
                onSaved: (input) => _password = input,
              ),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                _doSign();
              },
              child: Text("Click"))
        ],
      ),
    ),
  );
}

Widget Page3() {
  return Scaffold(
    body: Center(
      child: Text("SpeedDial"),
    ),
    floatingActionButton: SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: IconThemeData(size: 22.0),
      overlayColor: Colors.black,
      onOpen: () => print("open"),
      onClose: () => print("close"),
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      shape: CircleBorder(),
      children: [
        SpeedDialChild(
          child: Icon(Icons.accessibility),
          backgroundColor: Colors.red,
          label: "First",
          onTap: () => print("First Clicked"),
        ),
        SpeedDialChild(
          child: Icon(Icons.home),
          backgroundColor: Colors.red,
          label: "Home",
          onTap: () => print("First Clicked"),
        ),
        SpeedDialChild(
          child: Icon(Icons.settings),
          backgroundColor: Colors.red,
          label: "Settings",
          onTap: () => print("First Clicked"),
        ),
        SpeedDialChild(
          child: Icon(Icons.mail),
          backgroundColor: Colors.red,
          label: "E-mail",
          onTap: () => print("First Clicked"),
        ),
      ],
    ),
  );
}

Widget Page1() {
  return  Scaffold(
    floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    floatingActionButton: FloatingActionButton(
      onPressed: () {
        _controller.forward();
      },
      child: Icon(Icons.play_arrow),
    ),
    body: Center(
      child: Container(
        height: 200,
        width: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          image: DecorationImage(
            image: NetworkImage(
                'https://images.pexels.com/photos/1544376/pexels-photo-1544376.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1.jpg'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    ),
  );
}
