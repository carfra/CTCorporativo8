import 'package:flutter/material.dart';
import 'package:ct_personal/style/menuitem.dart';
import 'dart:io';

class MainMenu extends StatefulWidget {
  @override
  MainMenuState createState() => new MainMenuState();
}

class MainMenuState extends State<MainMenu> {
  Widget _appBarTitle;
  Color _appBarBackgroundColor;
  MenuItem _selectedMenuItem;
  List<MenuItem> _menuItems;
  List<Widget> _menuOptionWidgets = [];


  @override
  initState() {
    super.initState();

    _menuItems = createMenuItems();
    _selectedMenuItem = _menuItems.first;
    _appBarTitle = new Text(_menuItems.first.title);
    _appBarBackgroundColor = _menuItems.first.color;
  }

  _getMenuItemWidget(MenuItem menuItem) {
    return menuItem.func();
  }

  _onSelectItem(MenuItem menuItem) {
    setState(() {
      _selectedMenuItem = menuItem;
      _appBarTitle = new Text(menuItem.title);
      _appBarBackgroundColor = menuItem.color;
    });
    Navigator.of(context).pop(); // close side menu
  }

  @override
  Widget build(BuildContext context) {
    _menuOptionWidgets = [];

    for (var menuItem in _menuItems) {
      _menuOptionWidgets.add(new Container(
          decoration: new BoxDecoration(
              color: menuItem == _selectedMenuItem
                  ? Colors.grey[200]
                  : Colors.white),
          child: new ListTile(
              leading: new Image.asset(menuItem.icon),
              onTap: () => _onSelectItem(menuItem),
              title: Text(
                menuItem.title,
                style: new TextStyle(
                    fontSize: 20.0,
                    color: menuItem.color,
                    fontWeight: menuItem == _selectedMenuItem
                        ? FontWeight.bold
                        : FontWeight.w300),
              ))));

      _menuOptionWidgets.add(
        new SizedBox(
          child: new Center(
            child: new Container(
              margin: new EdgeInsetsDirectional.only(start: 20.0, end: 20.0),
              height: 0.3,
              color: Colors.grey,
            ),
          ),
        ),
      );
   }
//}
 return new Scaffold(
      appBar: new AppBar(
        title: _appBarTitle,
        backgroundColor: _appBarBackgroundColor,
        centerTitle: true,
      ),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new Container(
                child: new ListTile(
                   leading: new Image.asset('assets/img/logoct.jpg'),
                   //title: Text("romalon1@gmail.com")),
                ),
              margin: new EdgeInsetsDirectional.only(top: 20.0),
              color: Colors.white,
              constraints: BoxConstraints(maxHeight: 90.0, minHeight: 90.0)),
            new SizedBox(
              child: new Center(
                child: new Container(
                  margin:
                      new EdgeInsetsDirectional.only(start: 10.0, end: 10.0),
                  height: 0.3,
                  color: Colors.black,
                ),
              ),
            ),
            new Container(
              color: Colors.white,
              child: new Column(children: _menuOptionWidgets),
            ),
          ],
        ),
      ),
      body: _getMenuItemWidget(_selectedMenuItem),
    );
  }

  List<MenuItem> createMenuItems() {
    final menuItems = [
      new MenuItem("Salir", 'assets/img/exit.png', Colors.indigo, () => exit(0)),
      /*new MenuItem("Cows", 'assets/images/cow.png', Colors.green, () => new Cows()),
      new MenuItem("Doves", 'assets/images/dove.png', Colors.yellow, () => new Doves()),
      */
    ];

 return menuItems;
  }  
}
