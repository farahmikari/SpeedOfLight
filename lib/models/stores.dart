class Store {
  int? id;
  String? name;
  int? categoryId;
  String? image;

  Store({
    this.id,
    this.name,
    this.categoryId,
    this.image,
  });

  Store.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    categoryId = json['category_id'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['category_id'] = categoryId;
    data['image'] = image;
    return data;
  }
}

class Stores {
  List<Store>? listOfStore;

  Stores({this.listOfStore});

  Stores.fromJson(List<dynamic> jsonList) {
    listOfStore = <Store>[];
    for (var v in jsonList) {
      listOfStore!.add(Store.fromJson(v));
    }
  }

  List<Map<String, dynamic>>? toJson() {
    return listOfStore?.map((v) => v.toJson()).toList();
  }
}
