import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:musify/API/musify.dart';
import 'package:musify/extensions/l10n.dart';
import 'package:musify/style/app_themes.dart';
import 'package:musify/utilities/flutter_toast.dart';
import 'package:musify/widgets/playlist_cube.dart';
import 'package:musify/widgets/song_bar.dart';

class UserOfflineSongsPage extends StatefulWidget {
  const UserOfflineSongsPage({super.key});

  @override
  State<UserOfflineSongsPage> createState() => _UserOfflineSongsPageState();
}

class _UserOfflineSongsPageState extends State<UserOfflineSongsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Offline Songs'),
      ),
      body: Column(
        children: [
          buildPlaylistHeader(),
          const SizedBox(height: 30),
          Expanded(
            child: buildSongList(),
          ),
        ],
      ),
    );
  }

  Widget buildPlaylistHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildPlaylistImage(),
        const SizedBox(width: 20),
        Column(
          children: [
            const Text(
              'Your Offline Songs Here',
              style: TextStyle(
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(height: 10),
            buildPlayButton(),
          ],
        ),
      ],
    );
  }

  Widget _buildPlaylistImage() {
    return PlaylistCube(
      title: 'User Offline Songs',
      onClickOpen: false,
      showFavoriteButton: false,
      size: 150,
      zoomNumber: 0.55,
    );
  }

  Widget buildPlayButton() {
    return GestureDetector(
      onTap: () {
        setActivePlaylist(
          {
            'ytid': '',
            'title': context.l10n!.userLikedSongs,
            'header_desc': '',
            'image': '',
            'list': userLikedSongsList,
          },
        );
        showToast(
          context,
          context.l10n!.queueInitText,
        );
      },
      child: Icon(
        FluentIcons.play_circle_48_filled,
        color: colorScheme.primary,
        size: 60,
      ),
    );
  }

  Widget buildSongList() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: userOfflineSongs.length,
      itemBuilder: (context, index) {
        final _song = userOfflineSongs[index];
        _song['isOffline'] = true;
        return SongBar(
          _song,
          true,
        );
      },
    );
  }
}
