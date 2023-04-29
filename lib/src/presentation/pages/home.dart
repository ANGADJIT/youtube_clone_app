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
  final _pages = [
    const VideosPage(),
    const UploadPage(),
    const SubscriptionVideos()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: black,
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(CustomMediaQuery.makeHeight(context, .06)),
        child: BlocBuilder<PageCubit, PageState>(
          bloc: context.read<PageCubit>(),
          builder: (context, state) {
            if (state is PageIndex) {
              return CustomAppBar().call(
                context,
                title: state.pageIndex == 0 || state.pageIndex == 2
                    ? youtubeTitle
                    : 'Upload Video',
                isHome: state.pageIndex == 0 || state.pageIndex == 2,
                allVideosCubit: context.read<AllVideosCubit>(),
                showLogo: state.pageIndex == 0 || state.pageIndex == 2,
              );
            }

            return Container();
          },
        ),
      ),
      bottomNavigationBar: BlocBuilder<PageCubit, PageState>(
        builder: (context, state) {
          if (state is PageIndex) {
            return BottomBarDoubleBullet(
                selectedIndex: state.pageIndex,
                color: white,
                backgroundColor: black,
                onSelect: (index) {
                  context.read<PageCubit>().changePage(index);
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
                ]);
          }

          return Container();
        },
      ),
      body: BlocBuilder<PageCubit, PageState>(
        bloc: context.read<PageCubit>(),
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
