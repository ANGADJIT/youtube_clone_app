import 'package:flutter/material.dart';
import 'package:youtube_clone_app/src/utils/api_endpoint_page.dart';
import 'package:youtube_clone_app/src/utils/cache_manager.dart';
import 'package:youtube_clone_app/src/utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  CacheManager.init();

  runApp(const YoutubeCloneApp());
}

class YoutubeCloneApp extends StatelessWidget {
  const YoutubeCloneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(backgroundColor: black, fontFamily: 'Lato'),
        home: APIEndpointPage());
  }
}
