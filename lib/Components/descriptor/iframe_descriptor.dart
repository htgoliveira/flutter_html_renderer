import 'package:flutter/material.dart';
import 'package:html/dom.dart' as dom;
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../widgets_factory.dart';
import '../handler/link_handler.dart';
import '../element/element_descriptor.dart';
import '../rendering_context.dart';

/// <iframe> descriptor.
/// If src is youtube embed, it will render video using youtube_player_flutter
class IframeDescriptor extends ElementDescriptor {
  const IframeDescriptor()
      : super(
          name: 'iframe',
          supported: true,
          isInline: false,
          isBlock: true,
        );

  @override
  Future<Widget> render(
      dom.Element element,
      BuildContext context,
      WidgetsFactory widgetsFactory,
      LinkHandler linkHandler,
      RenderingContext renderingContext) async {
    String src = element.attributes['src'];
    if (src == null || src.trim().isEmpty) {
      return Container();
    }
    YoutubePlayerController _youtubeController;
    String videoId = YoutubePlayer.convertUrlToId(src);
    if (videoId != null) {
      _youtubeController = YoutubePlayerController(
        initialVideoId: videoId,
        flags: YoutubePlayerFlags(
          autoPlay: false,
        ),
      );
      //this is youtube video.
      ThemeData theme = Theme.of(context);
      return YoutubePlayer(
        controller: _youtubeController,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.amber,
        progressColors: ProgressBarColors(
          playedColor: theme.primaryColor,
          handleColor: theme.accentColor,
        ),
        //thumbnail: cultoModel.tumbnail,
      );
      // return YoutubePlayer(
      //   context: context,
      //   videoId: videoId,
      //   flags: YoutubePlayerFlags(
      //     autoPlay: false,
      //     showVideoProgressIndicator: true,
      //   ),
      //   videoProgressIndicatorColor: theme.primaryColor,
      //   progressColors: ProgressColors(
      //     playedColor: theme.primaryColor,
      //     handleColor: theme.accentColor,
      //   ),
      // );
    }
    //TODO: Maybe one day we will fully support iframes
    return Container();
  }
}
