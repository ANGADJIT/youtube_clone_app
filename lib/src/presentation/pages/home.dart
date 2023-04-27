import 'package:bottom_bar_matu/bottom_bar_double_bullet/bottom_bar_double_bullet.dart';
import 'package:bottom_bar_matu/bottom_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:youtube_clone_app/src/logic/all_videos_cubit/all_videos_cubit.dart';
import 'package:youtube_clone_app/src/logic/page_cubit/page_cubit.dart';
import 'package:youtube_clone_app/src/presentation/pages/all_videos_page.dart';
import 'package:youtube_clone_app/src/presentation/pages/subscription_videos_page.dart';
import 'package:youtube_clone_app/src/presentation/pages/upload_page.dart';
import 'package:youtube_clone_app/src/presentation/widgets/custom_app_bar.dart';
import 'package:youtube_clone_app/src/utils/colors.dart';
import 'package:youtube_clone_app/src/utils/custom_media_query.dart';
import 'package:youtube_clone_app/src/utils/strings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final PageCubit _pageCubit = PageCubit();

  final _pages = [
    const VideosPage(),
    const UploadPage(),
    const SubscriptionVideos()
  ];

  @override
  void dispose() {
    _pageCubit.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      appBar: CustomAppBar().call(
        context,
        title: youtubeTitle,
        isHome: false,
        allVideosCubit: context.read<AllVideosCubit>(),
        showLogo: true,
      ),
      bottomNavigationBar: BottomBarDoubleBullet(
          color: white,
          backgroundColor: black,
          onSelect: (index) {
            _pageCubit.changePage(index);
          },
          height: CustomMediaQuery.makeHeight(context, .04),
          items: [
            BottomBarItem(
              iconData: Icons.home,
            ),
            BottomBarItem(
              iconData: Icons.add_rounded,
            ),
            BottomBarItem(
              iconData: Icons.library_add_check,
            ),
          ]),
      body: BlocBuilder<PageCubit, PageState>(
        bloc: _pageCubit,
        builder: (context, state) {
          if (state is PageIndex) {
            return _pages.elementAt(state.pageIndex);
          }

          return Container();
        },
      ),
    );
  }
}

