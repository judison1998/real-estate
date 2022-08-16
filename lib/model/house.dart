class House {
  int? id;
  String? location;
  String? rooms;
  int? price;
  String? img;
  String? addedOn;
  House({
    this.id,
    this.location,
    this.rooms,
    this.price,
    this.img,
    this.addedOn,
  });
  House.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    location = json["location"];
    rooms = json["rooms"];
    price = json["price"];
    addedOn = json["addedOn"];
    img = json["img"];
    location = json["location"];
  }
  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "name": this.location,
      "price": this.price,
      "img": this.img,
      "location": this.location,
      "createdAt": this.addedOn,
    };
  }
}
