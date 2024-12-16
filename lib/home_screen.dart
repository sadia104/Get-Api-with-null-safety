import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Models/posts_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Function to fetch data from the API
  Future<List<PostsModel>> getPostApi() async {
    // Send a GET request to the API
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
    );

    // Check if the API call was successful
    if (response.statusCode == 200) {
      // Decode the JSON response body into a Dart object
      var data = jsonDecode(response.body.toString());
      // Map the JSON data to a list of PostModel objects
      return (data as List).map((e) => PostsModel.fromJson(e)).toList();
    } else {
      // Throw an exception if the API call failed
      throw Exception('Failed to load posts');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App bar at the top of the screen
      appBar: AppBar(
        title: const Text('GetApi data with null safety',style: TextStyle(color: Colors.white),), // App bar title
        backgroundColor: Colors.teal, // App bar color
      ),
      // Body of the screen where the data will be shown
      body: FutureBuilder<List<PostsModel>>(
        future: getPostApi(), // Fetch the API data
        builder: (context, snapshot) {
          // If the data is still loading, show a progress indicator
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          // If there is an error while fetching data
          else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          // If there is no data
          else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No data available.'));
          }
          // If the data is successfully fetched
          else {
            List<PostsModel> postLists = snapshot.data!; // Store data in a list
            return ListView.builder(
              itemCount: postLists.length, // Total number of items in the list
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0), // Add padding around each card
                  child: Card(
                    elevation: 3, // Adds shadow effect to the card
                    child: Padding(
                      padding: const EdgeInsets.all(12.0), // Inner padding of the card
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start, // Align content to the left
                        children: [
                          // Display the ID of the post in blue color
                          Text(
                            'ID: ${postLists[index].id}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue, // Blue color for ID
                            ),
                          ),
                          const SizedBox(height: 5), // Add space between ID and Title

                          // Display the Title heading in deep orange
                          const Text(
                            'Title:',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepOrange, // Orange color for Title heading
                            ),
                          ),
                          // Display the Title content
                          Text(
                            postLists[index].title ?? 'No Title', // Show title
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black87, // Slightly dark black for title text
                            ),
                          ),
                          const SizedBox(height: 5), // Add space between Title and Description

                          // Display the Description heading in gray
                          const Text(
                            'Description:',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey, // Gray color for Description heading
                            ),
                          ),
                          // Display the Description content
                          Text(
                            postLists[index].body ?? 'No Content', // Show description
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black54, // Light black for description text
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
