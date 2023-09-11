import 'package:flutter/material.dart';
import 'package:instagram_clone/screens/add_post.dart';
import 'package:instagram_clone/screens/feeds.dart';

const webScreenSize = 576;

const mobileHomeScreenItems = [
  Feeds(),
  Text("Search"),
  AddPost(),
  Text("Videos"),
  Text("Profile"),
];
