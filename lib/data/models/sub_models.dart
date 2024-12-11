import '../../core/constants/constants.dart';

class SpritesModel {
  const SpritesModel({
    required this.other,
  });
  final OtherModel other;

  static SpritesModel fromJson(Map<String, dynamic> json) {
    return SpritesModel(
      other: OtherModel.fromJson(json[kOther]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      kOther: other,
    };
  }
}

class OtherModel {
  const OtherModel({required this.officialArtwork, required this.home});

  final Home home;

  final OfficialArtworkModel officialArtwork;

  static OtherModel fromJson(Map<String, dynamic> json) {
    return OtherModel(
        home: Home.fromJson(json[khome]),
        officialArtwork: OfficialArtworkModel.fromJson(json[kOfficialArtwork]));
  }

  Map<String, dynamic> toJson() {
    return {
      kOfficialArtwork: officialArtwork,
    };
  }
}

class Home {
  const Home({
    required this.frontDefault,
    required this.frontShiny,
  });
  final String frontDefault;
  final String frontShiny;

  static Home fromJson(Map<String, dynamic> json) {
    return Home(
      frontDefault: json[kfrontdefault],
      frontShiny: json[kfrontshiny],
    );
  }
}

class OfficialArtworkModel {
  const OfficialArtworkModel({
    required this.frontShiny,
    required this.frontDefault,
  });

  final String frontShiny;
  final String frontDefault;
  static OfficialArtworkModel fromJson(Map<String, dynamic> json) {
    return OfficialArtworkModel(
      frontShiny: json[kfrontshiny],
      frontDefault: json[kfrontdefault],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      kfrontdefault: frontDefault,
      kfrontshiny: frontShiny,
    };
  }
}

//! Types
class TypesModel {
  const TypesModel({
    required this.type,
  });
  final TypeModel type;

  static List<TypesModel> fromJson(List<dynamic> jsonList) {
    List<TypesModel> returnedList = [];
    for (Map<String, dynamic> json in jsonList) {
      returnedList.add(
        TypesModel(
          type: TypeModel.fromJson(json[ktype]),
        ),
      );
    }
    return returnedList;
  }

  Map<String, dynamic> toJson() {
    return {
      ktype: type,
    };
  }
}

class TypeModel {
  const TypeModel({
    required this.name,
  });
  final String name;

  static TypeModel fromJson(Map<String, dynamic> json) {
    return TypeModel(
      name: json[kname],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      kname: name,
    };
  }
}
