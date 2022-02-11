class ImageModel {
  final String name,
      city,
      desc,
      img,
      restaurant,
      shopping,
      museum,
      cost,
      nature;

  ImageModel(this.name, this.city, this.desc, this.img, this.restaurant,
      this.shopping, this.museum, this.cost, this.nature);

  ImageModel.fromJson(Map<String, dynamic> parsedJson)
      : name = parsedJson['name'],
        city = parsedJson['city'],
        desc = parsedJson['desc'],
        img = parsedJson['img'],
        restaurant = parsedJson['restaurant'],
        shopping = parsedJson['shopping'],
        museum = parsedJson['museum'],
        cost = parsedJson['cost'],
        nature = parsedJson['nature'];
}
