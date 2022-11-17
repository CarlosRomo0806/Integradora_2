part of 'songs_bloc.dart';

@immutable
abstract class SongsState extends Equatable {
  const SongsState();
  
  @override
  List<Object> get props => [];
}

class SongsInitial extends SongsState {}

class SongsVal extends SongsInitial {}

class SongsRecognition extends SongsInitial {}

class SongsEnded extends SongsInitial {}

class SongsSuccess extends SongsInitial {
  final String song, artist, album, date, apple, spotify, image, link;

  SongsSuccess({
    required this.song,
    required this.artist,
    required this.album,
    required this.date,
    required this.apple,
    required this.spotify,
    required this.image,
    required this.link,
  });
}

class SongsFailure extends SongsInitial {}
