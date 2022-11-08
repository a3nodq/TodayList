import 'package:flutter/material.dart';
import 'package:listapp/control/list_controller.dart';
import 'package:get/get.dart';


class TodoScreen extends StatefulWidget {


  const TodoScreen({super.key, required this.title});

  final String title;
  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  var controller = Get.put(ListController());
  bool click = false;
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Padding(
      padding: EdgeInsets.all(15.0),
      child: Text(
        'Today',
        style: TextStyle(
          fontSize:28,
          fontWeight: FontWeight.bold,
          color: Color(0xFF395B64),
        ),
      ),
    ),
    Padding(
      padding: EdgeInsets.all(20.0),
      child: Text(
        'Contact',
        style: TextStyle(
          fontSize:26,
          fontWeight: FontWeight.bold,
          color: Color(0xFF395B64),
        ),
      ),
    )
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: (Color(0xFF131313)),
      appBar: AppBar(
        title: (Text(
          "List",
          style: TextStyle(
            fontSize: 21,
            color: Color(0xFF3F8AE0),
          ),
        )),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.add,
                color: Color(0xFF3F8AE0),
              ),

              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (BuildContext bc){
                      return Container(
                        height: 350,
                        child: Wrap(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text("Add task",
                                style: TextStyle(
                                    color: Color(0xFF395B64),
                                    fontSize: 21,
                                    fontWeight: FontWeight.w500),),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child:  TextField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Write your task',
                                  ),
                                  controller: controller.textAddController,
                                  onSubmitted: (value){
                                    controller.addItem(value);
                                    Navigator.pop(context);
                                    _TodoScreenState();

                                  }),
                            )
                          ],
                        ),
                      );
                    }
                );
              }
          )
        ],
        backgroundColor: Color(0xFF131313),
        // leading: IconButton(
        //   icon: Icon(
        //     Icons.arrow_back_ios,
        //     color: Color(0xFF3F8AE0),
        //   ),
        //   onPressed: () {
        //     // do something
        //   },
        // ),
      ),
      body: Stack(
        children: [
          _widgetOptions.elementAt(_selectedIndex),
          Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: Obx(() => ListView.builder(
              // the number of items in the list
                itemCount: controller.item.length,
                // display each item of the product list
                itemBuilder: (context, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        icon: Icon((click == true) ?
                        Icons.circle : Icons.circle_outlined,
                          color: Color(0xFF3F8AE0),
                        ),
                        onPressed: () {
                          setState(() {
                            click = !click;
                          });
                        },
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 15),
                        child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(controller.item[index],
                              style: TextStyle(
                                  fontSize: 21,
                                  color: Color(0xFFFFFFFF)
                              ),
                            )
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            controller.deleteItem(index);
                          },
                          icon: Icon(Icons.delete, color: Color(0xFFA5C9CA))),
                      IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (BuildContext bc){
                                  return Container(
                                    height: 350,
                                    child: new Wrap(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child:Text("Edit your task",
                                            style: TextStyle(
                                                color: Color(0xFF395B64),
                                                fontSize: 21,
                                                fontWeight: FontWeight.w500),),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: new TextField(
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              hintText: 'Edit your task',
                                            ),
                                            controller: controller.textAddController,
                                            onSubmitted: (value){
                                              controller.editItem(index,value);
                                              Navigator.pop(context);
                                              _TodoScreenState();
                                            },),
                                        )
                                      ],
                                    ),
                                  );
                                }
                            );
                          },
                          icon: Icon(Icons.edit, color: Color(0xFFA5C9CA)))
                    ],
                  );
                }
            )
            ),
          ),
        ],
      ),
      bottomNavigationBar:
      BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Today',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_pin_circle_outlined),
            label: 'Contact',
          ),
        ],
        backgroundColor: Color(0xFF434343),
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xFFA5C9CA),
        onTap: _onItemTapped,


      ),
    );
  }
}