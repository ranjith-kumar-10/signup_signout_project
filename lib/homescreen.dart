import 'package:flutter/material.dart';
import 'package:register_form/signup_signin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> dataList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchDataFromApi();
  }

  Future<void> fetchDataFromApi() async {
    try {
      // Create a Dio instance
      Dio dio = Dio();

      // Make a GET request to the API
      Response response =
          await dio.get('https://jsonplaceholder.typicode.com/posts');

      // Check if the request was successful (status code 200)
      if (response.statusCode == 200) {
        // Parse the JSON response
        List<dynamic> data = response.data;
        setState(() {
          dataList = data;
          isLoading = false;
        });
      } else {
        // Handle errors (you can throw an exception or return an empty list, depending on your needs)
        setState(() {
          isLoading = false;
        });
        throw Exception('Failed to fetch data');
      }
    } catch (e) {
      // Handle Dio errors
      setState(() {
        isLoading = false;
      });
      print('Error: $e');
    }
  }

  void signOut(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Clear the saved email and password (sign out)
    await prefs.remove('email');
    await prefs.remove('password');
    // Navigate back to the signin screen
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => SignupScreen(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () => signOut(context),
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : dataList.isEmpty
              ? Center(child: Text('No data available.'))
              : ListView.builder(
                  itemCount: dataList.length,
                  itemBuilder: (context, index) {
                    // Create widgets to display the data here
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          String title1 = dataList[index]['title'];
                          String body1 = dataList[index]['body'];

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Detailscreen(
                                        titile: title1,
                                        body: body1,
                                      )));

                          print(dataList[index]['title']);
                          print(dataList[index]['body']);
                        },
                        child: Card(
                          child: ListTile(
                            title: Text(dataList[index]['title']),
                            subtitle: Text(dataList[index]['body']),
                          ),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}

class Detailscreen extends StatefulWidget {
  String? titile;
  String? body;
  Detailscreen({this.titile, this.body, super.key});

  @override
  State<Detailscreen> createState() => _DetailscreenState(titile, body);
}

class _DetailscreenState extends State<Detailscreen> {
  String? title;
  String? body;
  _DetailscreenState(this.title, this.body);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Detailscreen'),
      ),
      body: Column(
        children: [Text(title!), Text(body!)],
      ),
    );
  }
}
