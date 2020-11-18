class PyqModel {
  int page;
  int limit;
  List<Data> data;

  PyqModel({this.page, this.limit, this.data});

  PyqModel.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    limit = json['limit'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['limit'] = this.limit;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String uName;
  String portrait;
  String text;
  List<String> images;

  Data({this.uName, this.portrait, this.text, this.images});

  Data.fromJson(Map<String, dynamic> json) {
    uName = json['uName'];
    portrait = json['portrait'];
    text = json['text'];
    images = json['images'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uName'] = this.uName;
    data['portrait'] = this.portrait;
    data['text'] = this.text;
    data['images'] = this.images;
    return data;
  }
}
