import 'package:flutter/material.dart';
import 'package:custom_top_navigator/custom_top_navigator.dart';

void main() => runApp(const MyApp());

//give a navigator key to [MaterialApp] if you want to use the default navigation
//anywhere in your app eg: line 15 & line 93
GlobalKey<NavigatorState> mainNavigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: mainNavigatorKey,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({ Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  Page _page =  const Page('Page 0');
  int _currentIndex = 0;

  // Custom navigator takes a global key if you want to access the
  // navigator from outside it's widget tree subtree
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: _items,
        onTap: (index) {
          // here we used the navigator key to pop the stack to get back to our
          // main page
          navigatorKey.currentState?.maybePop();
          setState(() => _page = Page('Page $index'));
          _currentIndex = index;
        },
        currentIndex: _currentIndex,
      ),
      body: CustomTopNavigator(
        navigatorKey: navigatorKey,
        home: _page,
        //Specify your page route [PageRoutes.materialPageRoute] or [PageRoutes.cupertinoPageRoute]
        pageRoute: PageRoutes.materialPageRoute,
      ),
    );
  }

  final _items = [
    const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
    const BottomNavigationBarItem(icon: Icon(Icons.event), label: 'events'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.save_alt), label: 'downloads'),
  ];
}

class Page extends StatelessWidget {
  final String title;

  const Page(this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final text = Text(title);

    return Center(
        child: TextButton(
            onPressed: () => _openDetailsPage(context), child: text));
  }

  //Use the navigator like you usually do with .of(context) method
  _openDetailsPage(BuildContext context) => Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => DetailsPage(title)));

//  _openDetailsPage(BuildContext context) => mainNavigatorKey.currentState.push(MaterialPageRoute(builder: (context) => DetailsPage(title)));

}

class DetailsPage extends StatelessWidget {
  final String title;

  const DetailsPage(this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final text = Text('Details of $title');
    return Center(child: text);
  }
}
