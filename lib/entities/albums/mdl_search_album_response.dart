class MdlSearchAlbumResponse {
  bool? success;
  Data? data;

  MdlSearchAlbumResponse({this.success, this.data});

  MdlSearchAlbumResponse.fromJson(Map<String, dynamic> json) {
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

class Data {
  int? total;
  int? start;
  List<MDLAlbumsListResults>? results;

  Data({this.total, this.start, this.results});

  Data.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    start = json['start'];
    if (json['results'] != null) {
      results = <MDLAlbumsListResults>[];
      json['results'].forEach((v) {
        results!.add(MDLAlbumsListResults.fromJson(v));
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

class MDLAlbumsListResults {
  String? id;
  String? name;
  String? description;
  int? year;
  String? type;
  int? playCount;
  String? language;
  bool? explicitContent;
  Artists? artists;
  String? url;
  List<MDLImage>? image;

  MDLAlbumsListResults(
      {this.id,
        this.name,
        this.description,
        this.year,
        this.type,
        this.playCount,
        this.language,
        this.explicitContent,
        this.artists,
        this.url,
        this.image});

  MDLAlbumsListResults.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    year = json['year'];
    type = json['type'];
    playCount = json['playCount'];
    language = json['language'];
    explicitContent = json['explicitContent'];
    artists =
    json['artists'] != null ? Artists.fromJson(json['artists']) : null;
    url = json['url'];
    if (json['image'] != null) {
      image = <MDLImage>[];
      json['image'].forEach((v) {
        image!.add(MDLImage.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['year'] = year;
    data['type'] = type;
    data['playCount'] = playCount;
    data['language'] = language;
    data['explicitContent'] = explicitContent;
    if (artists != null) {
      data['artists'] = artists!.toJson();
    }
    data['url'] = url;
    if (image != null) {
      data['image'] = image!.map((v) => v.toJson()).toList();
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
  String? type;
  List<MDLImage>? image;
  String? url;

  Primary({this.id, this.name, this.role, this.type, this.image, this.url});

  Primary.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    role = json['role'];
    type = json['type'];
    if (json['image'] != null) {
      image = <MDLImage>[];
      json['image'].forEach((v) {
        image!.add(MDLImage.fromJson(v));
      });
    }
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['role'] = role;
    data['type'] = type;
    if (image != null) {
      data['image'] = image!.map((v) => v.toJson()).toList();
    }
    data['url'] = url;
    return data;
  }
}

class MDLImage {
  String? quality;
  String? url;

  MDLImage({this.quality, this.url});

  MDLImage.fromJson(Map<String, dynamic> json) {
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

class Featured {
  String? id;
  String? name;
  String? role;
  String? type;
  List<MDLImage>? image;
  String? url;

  Featured({this.id, this.name, this.role, this.type, this.image, this.url});

  Featured.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    role = json['role'];
    type = json['type'];
    if (json['image'] != null) {
      image = <MDLImage>[];
      json['image'].forEach((v) {
        image!.add(MDLImage.fromJson(v));
      });
    }
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['role'] = role;
    data['type'] = type;
    if (image != null) {
      data['image'] = image!.map((v) => v.toJson()).toList();
    }
    data['url'] = url;
    return data;
  }
}

class All {
  String? id;
  String? name;
  String? role;
  String? type;
  List<MDLImage>? image;
  String? url;

  All({this.id, this.name, this.role, this.type, this.image, this.url});

  All.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    role = json['role'];
    type = json['type'];
    if (json['image'] != null) {
      image = <MDLImage>[];
      json['image'].forEach((v) {
        image!.add(MDLImage.fromJson(v));
      });
    }
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['role'] = role;
    data['type'] = type;
    if (image != null) {
      data['image'] = image!.map((v) => v.toJson()).toList();
    }
    data['url'] = url;
    return data;
  }
}


class MDLAlbumsParam {
  String? query;

  MDLAlbumsParam({
    this.query,
  });

  Map<String, dynamic> get toJson {
    return {
      'query': query,
    };
  }
}