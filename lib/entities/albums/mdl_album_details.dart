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


class MDLGetSongParam {
  String? id;

  MDLGetSongParam({
    this.id,
  });

  Map<String, dynamic> get toJson {
    return {
      'id': id,
    };
  }
}
