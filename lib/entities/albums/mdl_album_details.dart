import 'package:music_app/entities/albums/mdl_search_album_response.dart';

class MdlAlbumDetails {
  bool? success;
  Data? data;

  MdlAlbumDetails({this.success, this.data});

  MdlAlbumDetails.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class MdlSongRecommendedResponse {
  bool? success;
  List<Songs>? data;

  MdlSongRecommendedResponse({this.success, this.data});

  MdlSongRecommendedResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = List<Songs>.from(json['data'].map((song) => Songs.fromJson(song)));
    } else {
      data = null;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = {};
    result['success'] = success;
    if (data != null) {
      result['data'] = data!.map((song) => song.toJson()).toList();
    }
    return result;
  }
}

class MDLLyricsResponse {
  bool? success;
  MDLLyricsData? data;

  MDLLyricsResponse({this.success, this.data});

  MDLLyricsResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? MDLLyricsData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class MDLSearchSongResponse {
  bool? success;
  MDlSearchSongData? data;

  MDLSearchSongResponse({this.success, this.data});

  MDLSearchSongResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data =
        json['data'] != null ? MDlSearchSongData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class MDlSearchSongData {
  int? total;
  int? start;
  List<Songs>? results;

  MDlSearchSongData({this.total, this.start, this.results});

  MDlSearchSongData.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    start = json['start'];
    if (json['results'] != null) {
      results = <Songs>[];
      json['results'].forEach((v) {
        results!.add(Songs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['total'] = total;
    data['start'] = start;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MDLLyricsData {
  String? lyrics;
  String? snippet;
  String? copyright;

  MDLLyricsData({this.lyrics, this.snippet, this.copyright});

  MDLLyricsData.fromJson(Map<String, dynamic> json) {
    lyrics = json['lyrics'];
    snippet = json['snippet'];
    copyright = json['copyright'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['lyrics'] = lyrics;
    data['snippet'] = snippet;
    data['copyright'] = copyright;
    return data;
  }
}

class Data {
  String? id;
  String? name;
  String? description;
  String? type;
  int? year;
  int? playCount;
  String? language;
  bool? explicitContent;
  String? url;
  int? songCount;
  Artists? artists;
  List<MDLImage>? image;
  List<Songs>? songs;

  Data(
      {this.id,
      this.name,
      this.description,
      this.type,
      this.year,
      this.playCount,
      this.language,
      this.explicitContent,
      this.url,
      this.songCount,
      this.artists,
      this.image,
      this.songs});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    type = json['type'];
    year = json['year'];
    playCount = json['playCount'];
    language = json['language'];
    explicitContent = json['explicitContent'];
    url = json['url'];
    songCount = json['songCount'];
    artists =
        json['artists'] != null ? Artists.fromJson(json['artists']) : null;
    if (json['image'] != null) {
      image = <MDLImage>[];
      json['image'].forEach((v) {
        image!.add(MDLImage.fromJson(v));
      });
    }
    if (json['songs'] != null) {
      songs = <Songs>[];
      json['songs'].forEach((v) {
        songs!.add(Songs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['type'] = type;
    data['year'] = year;
    data['playCount'] = playCount;
    data['language'] = language;
    data['explicitContent'] = explicitContent;
    data['url'] = url;
    data['songCount'] = songCount;
    if (artists != null) {
      data['artists'] = artists!.toJson();
    }
    if (image != null) {
      data['image'] = image!.map((v) => v.toJson()).toList();
    }
    if (songs != null) {
      data['songs'] = songs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Artists {
  List<Primary>? primary;
  List<Featured>? featured;
  List<All>? all;

  Artists({this.primary, this.featured, this.all});

  Artists.fromJson(Map<String, dynamic> json) {
    if (json['primary'] != null) {
      primary = <Primary>[];
      json['primary'].forEach((v) {
        primary!.add(Primary.fromJson(v));
      });
    }
    if (json['featured'] != null) {
      featured = <Featured>[];
      json['featured'].forEach((v) {
        featured!.add(Featured.fromJson(v));
      });
    }
    if (json['all'] != null) {
      all = <All>[];
      json['all'].forEach((v) {
        all!.add(All.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (primary != null) {
      data['primary'] = primary!.map((v) => v.toJson()).toList();
    }
    if (featured != null) {
      data['featured'] = featured!.map((v) => v.toJson()).toList();
    }
    if (all != null) {
      data['all'] = all!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Primary {
  String? id;
  String? name;
  String? role;
  List<MDLImage>? image;
  String? type;
  String? url;

  Primary({this.id, this.name, this.role, this.image, this.type, this.url});

  Primary.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    role = json['role'];
    if (json['image'] != null) {
      image = <MDLImage>[];
      json['image'].forEach((v) {
        image!.add(MDLImage.fromJson(v));
      });
    }
    type = json['type'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['role'] = role;
    if (image != null) {
      data['image'] = image!.map((v) => v.toJson()).toList();
    }
    data['type'] = type;
    data['url'] = url;
    return data;
  }
}

class Songs {
  String? id;
  String? name;
  String? type;
  String? year;
  String? releaseDate;
  int? duration;
  String? label;
  bool? explicitContent;
  int? playCount;
  String? language;
  bool? hasLyrics;
  int? lyricsId;
  String? url;
  String? copyright;
  Album? album;
  Artists? artists;
  List<MDLImage>? image;
  List<DownloadUrl>? downloadUrl;

  Songs(
      {this.id,
      this.name,
      this.type,
      this.year,
      this.releaseDate,
      this.duration,
      this.label,
      this.explicitContent,
      this.playCount,
      this.language,
      this.hasLyrics,
      this.lyricsId,
      this.url,
      this.copyright,
      this.album,
      this.artists,
      this.image,
      this.downloadUrl});

  Songs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    year = json['year'];
    releaseDate = json['releaseDate'];
    duration = json['duration'];
    label = json['label'];
    explicitContent = json['explicitContent'];
    playCount = json['playCount'];
    language = json['language'];
    hasLyrics = json['hasLyrics'];
    lyricsId = json['lyricsId'];
    url = json['url'];
    copyright = json['copyright'];
    album = json['album'] != null ? Album.fromJson(json['album']) : null;
    artists =
        json['artists'] != null ? Artists.fromJson(json['artists']) : null;
    if (json['image'] != null) {
      image = <MDLImage>[];
      json['image'].forEach((v) {
        image!.add(MDLImage.fromJson(v));
      });
    }
    if (json['downloadUrl'] != null) {
      downloadUrl = <DownloadUrl>[];
      json['downloadUrl'].forEach((v) {
        downloadUrl!.add(DownloadUrl.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['type'] = type;
    data['year'] = year;
    data['releaseDate'] = releaseDate;
    data['duration'] = duration;
    data['label'] = label;
    data['explicitContent'] = explicitContent;
    data['playCount'] = playCount;
    data['language'] = language;
    data['hasLyrics'] = hasLyrics;
    data['lyricsId'] = lyricsId;
    data['url'] = url;
    data['copyright'] = copyright;
    if (album != null) {
      data['album'] = album!.toJson();
    }
    if (artists != null) {
      data['artists'] = artists!.toJson();
    }
    if (image != null) {
      data['image'] = image!.map((v) => v.toJson()).toList();
    }
    if (downloadUrl != null) {
      data['downloadUrl'] = downloadUrl!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Album {
  String? id;
  String? name;
  String? url;

  Album({this.id, this.name, this.url});

  Album.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['url'] = url;
    return data;
  }
}

class DownloadUrl {
  String? quality;
  String? url;

  DownloadUrl({this.quality, this.url});

  DownloadUrl.fromJson(Map<String, dynamic> json) {
    quality = json['quality'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['quality'] = quality;
    data['url'] = url;
    return data;
  }
}

class MDLGetAlbumsParam {
  int? id;

  MDLGetAlbumsParam({
    this.id,
  });

  Map<String, dynamic> get toJson {
    return {
      'id': id,
    };
  }
}

class MDLGetLyricsParam {
  String? id;

  MDLGetLyricsParam({
    this.id,
  });

  Map<String, dynamic> get toJson {
    return {
      'id': id,
    };
  }
}

class MDLGetSongParam {
  String? id;
  int? limit;

  MDLGetSongParam({this.id, this.limit});

  Map<String, dynamic> get toJson {
    return {
      'id': id,
      'limit': limit,
    };
  }
}

class MDLSearchPlayListResponse {
  bool? success;
  MdlPlayListData? data;

  MDLSearchPlayListResponse({this.success, this.data});

  MDLSearchPlayListResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? MdlPlayListData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class MdlPlayListData {
  int? total;
  int? start;
  List<MDLPlayListResults>? results;

  MdlPlayListData({this.total, this.start, this.results});

  MdlPlayListData.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    start = json['start'];
    if (json['results'] != null) {
      results = <MDLPlayListResults>[];
      json['results'].forEach((v) {
        results!.add(MDLPlayListResults.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['total'] = total;
    data['start'] = start;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MDLPlayListResults {
  String? id;
  String? name;
  String? type;
  List<MDLImage>? image;
  String? url;
  int? songCount;
  String? language;
  bool? explicitContent;

  MDLPlayListResults(
      {this.id,
      this.name,
      this.type,
      this.image,
      this.url,
      this.songCount,
      this.language,
      this.explicitContent});

  MDLPlayListResults.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    if (json['image'] != null) {
      image = <MDLImage>[];
      json['image'].forEach((v) {
        image!.add(MDLImage.fromJson(v));
      });
    }
    url = json['url'];
    songCount = json['songCount'];
    language = json['language'];
    explicitContent = json['explicitContent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['type'] = type;
    if (image != null) {
      data['image'] = image!.map((v) => v.toJson()).toList();
    }
    data['url'] = url;
    data['songCount'] = songCount;
    data['language'] = language;
    data['explicitContent'] = explicitContent;
    return data;
  }
}

class MDlPlayListResponse {
  bool? success;
  MDlPlayListData? data;

  MDlPlayListResponse({this.success, this.data});

  MDlPlayListResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? MDlPlayListData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class MDlPlayListData {
  String? id;
  String? name;
  String? description;
  String? type;
  int? year;
  int? playCount;
  String? language;
  bool? explicitContent;
  String? url;
  int? songCount;
  List<PlayListArtists>? artists;
  List<MDLImage>? image;
  List<Songs>? songs;

  MDlPlayListData(
      {this.id,
      this.name,
      this.description,
      this.type,
      this.year,
      this.playCount,
      this.language,
      this.explicitContent,
      this.url,
      this.songCount,
      this.artists,
      this.image,
      this.songs});

  MDlPlayListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    type = json['type'];
    year = json['year'];
    playCount = json['playCount'];
    language = json['language'];
    explicitContent = json['explicitContent'];
    url = json['url'];
    songCount = json['songCount'];
    if (json['artists'] != null) {
      artists = <PlayListArtists>[];
      json['artists'].forEach((v) {
        artists!.add(PlayListArtists.fromJson(v));
      });
    }
    if (json['image'] != null) {
      image = <MDLImage>[];
      json['image'].forEach((v) {
        image!.add(MDLImage.fromJson(v));
      });
    }
    if (json['songs'] != null) {
      songs = <Songs>[];
      json['songs'].forEach((v) {
        songs!.add(Songs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['type'] = type;
    data['year'] = year;
    data['playCount'] = playCount;
    data['language'] = language;
    data['explicitContent'] = explicitContent;
    data['url'] = url;
    data['songCount'] = songCount;
    if (artists != null) {
      data['artists'] = artists!.map((v) => v.toJson()).toList();
    }
    if (image != null) {
      data['image'] = image!.map((v) => v.toJson()).toList();
    }
    if (songs != null) {
      data['songs'] = songs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MDlSearchArtistResponse {
  bool? success;
  MDlSearchArtistData? data;

  MDlSearchArtistResponse({this.success, this.data});

  MDlSearchArtistResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null
        ? MDlSearchArtistData.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class MDlSearchArtistData {
  int? total;
  int? start;
  List<PlayListArtists>? results;

  MDlSearchArtistData({this.total, this.start, this.results});

  MDlSearchArtistData.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    start = json['start'];
    if (json['results'] != null) {
      results = <PlayListArtists>[];
      json['results'].forEach((v) {
        results!.add(PlayListArtists.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['total'] = total;
    data['start'] = start;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PlayListArtists {
  String? id;
  String? name;
  String? role;
  List<MDLImage>? image;
  String? type;
  String? url;

  PlayListArtists(
      {this.id, this.name, this.role, this.image, this.type, this.url});

  PlayListArtists.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    role = json['role'];
    if (json['image'] != null) {
      image = <MDLImage>[];
      json['image'].forEach((v) {
        image!.add(MDLImage.fromJson(v));
      });
    }
    type = json['type'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['role'] = role;
    if (image != null) {
      data['image'] = image!.map((v) => v.toJson()).toList();
    }
    data['type'] = type;
    data['url'] = url;
    return data;
  }
}

class ADLArtistResponse {
  bool? success;
  MDlArtistData? data;

  ADLArtistResponse({this.success, this.data});

  ADLArtistResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? MDlArtistData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class MDlArtistData {
  String? id;
  String? name;
  String? url;
  String? type;
  int? followerCount;
  String? fanCount;
  bool? isVerified;
  String? dominantLanguage;
  String? dominantType;
  List<Bio>? bio;
  String? dob;
  String? fb;
  String? twitter;
  String? wiki;
  List<String>? availableLanguages;
  bool? isRadioPresent;
  List<MDLImage>? image;
  List<Songs>? topSongs;
  List<MDLAlbumsListResults>? topAlbums;
  List<Songs>? singles;
  List<PlayListArtists>? similarArtists;

  MDlArtistData(
      {this.id,
      this.name,
      this.url,
      this.type,
      this.followerCount,
      this.fanCount,
      this.isVerified,
      this.dominantLanguage,
      this.dominantType,
      this.bio,
      this.dob,
      this.fb,
      this.twitter,
      this.wiki,
      this.availableLanguages,
      this.isRadioPresent,
      this.image,
      this.topSongs,
      this.topAlbums,
      this.singles,
      this.similarArtists});

  MDlArtistData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    url = json['url'];
    type = json['type'];
    followerCount = json['followerCount'];
    fanCount = json['fanCount'];
    isVerified = json['isVerified'];
    dominantLanguage = json['dominantLanguage'];
    dominantType = json['dominantType'];
    if (json['bio'] != null) {
      bio = <Bio>[];
      json['bio'].forEach((v) {
        bio!.add(Bio.fromJson(v));
      });
    }
    dob = json['dob'];
    fb = json['fb'];
    twitter = json['twitter'];
    wiki = json['wiki'];
    availableLanguages = json['availableLanguages'].cast<String>();
    isRadioPresent = json['isRadioPresent'];
    if (json['image'] != null) {
      image = <MDLImage>[];
      json['image'].forEach((v) {
        image!.add(MDLImage.fromJson(v));
      });
    }
    if (json['topSongs'] != null) {
      topSongs = <Songs>[];
      json['topSongs'].forEach((v) {
        topSongs!.add(Songs.fromJson(v));
      });
    }
    if (json['topAlbums'] != null) {
      topAlbums = <MDLAlbumsListResults>[];
      json['topAlbums'].forEach((v) {
        topAlbums!.add(MDLAlbumsListResults.fromJson(v));
      });
    }
    if (json['singles'] != null) {
      singles = <Songs>[];
      json['singles'].forEach((v) {
        singles!.add(Songs.fromJson(v));
      });
    }
    if (json['similarArtists'] != null) {
      similarArtists = <PlayListArtists>[];
      json['similarArtists'].forEach((v) {
        similarArtists!.add(PlayListArtists.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['url'] = url;
    data['type'] = type;
    data['followerCount'] = followerCount;
    data['fanCount'] = fanCount;
    data['isVerified'] = isVerified;
    data['dominantLanguage'] = dominantLanguage;
    data['dominantType'] = dominantType;
    if (bio != null) {
      data['bio'] = bio!.map((v) => v.toJson()).toList();
    }
    data['dob'] = dob;
    data['fb'] = fb;
    data['twitter'] = twitter;
    data['wiki'] = wiki;
    data['availableLanguages'] = availableLanguages;
    data['isRadioPresent'] = isRadioPresent;
    if (image != null) {
      data['image'] = image!.map((v) => v.toJson()).toList();
    }
    if (topSongs != null) {
      data['topSongs'] = topSongs!.map((v) => v.toJson()).toList();
    }
    if (topAlbums != null) {
      data['topAlbums'] = topAlbums!.map((v) => v.toJson()).toList();
    }
    if (singles != null) {
      data['singles'] = singles!.map((v) => v.toJson()).toList();
    }
    if (similarArtists != null) {
      data['similarArtists'] = similarArtists!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Bio {
  String? text;
  String? title;
  int? sequence;

  Bio({this.text, this.title, this.sequence});

  Bio.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    title = json['title'];
    sequence = json['sequence'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['text'] = text;
    data['title'] = title;
    data['sequence'] = sequence;
    return data;
  }
}
