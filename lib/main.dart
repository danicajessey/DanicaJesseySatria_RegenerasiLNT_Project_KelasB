import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(title: 'To Do List'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Map<String, dynamic>> todoList = [];
  String singlevalue = "";
  void addString(String content) {
    setState(() {
      singlevalue = content;
    });
  }

  void addList() {
    setState(() {
      todoList.add({"value": singlevalue, "checked": false});
    });
  }

  void deleteItem(int index) {
    setState(() {
      todoList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "To do List",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 33,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 13, 219, 255),
        centerTitle: true,
        toolbarHeight: 75,
        elevation: 0,
      ),
      body: Container(
        margin: const EdgeInsets.all(25),
        child: Column(
          children: [
            Expanded(
              flex: 50, //create task box
              child: ListView.builder(
                itemCount: todoList.length,
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    color: Color.fromARGB(255, 76, 204, 226),
                    child: ListTile(
                      leading: Checkbox(
                        value: todoList[index]['checked'],
                        onChanged: (bool? value) {
                          setState(() {
                            todoList[index]['checked'] = value;
                          });
                        },
                      ),
                      title: Text(
                        todoList[index]['value'].toString(),
                        style: TextStyle(
                          color: Color.fromARGB(255, 64, 40, 40),
                          fontWeight: FontWeight.bold,
                          decoration: todoList[index]['checked']
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                      trailing: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromARGB(255, 205, 255, 253)),
                        child: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            deleteItem(index);
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              flex: 10,
              child: Row(
                children: [
                  Expanded(
                    flex: 70,
                    child: Container(
                      height: 40,
                      child: TextFormField(
                        onChanged: (content) {
                          addString(content);
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          fillColor: const Color.fromARGB(255, 179, 221, 255),
                          filled: true,
                          labelText: 'Create Task....',
                          labelStyle: TextStyle(
                            color: Color.fromARGB(255, 2, 10, 102),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: SizedBox(width: 5),
                  ),
                  Expanded(
                    flex: 27,
                    child: ElevatedButton(
                      onPressed: () {
                        addList();
                      },
                      child: Container(
                        height: 15,
                        alignment: Alignment.center,
                        child: Text("Add"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
