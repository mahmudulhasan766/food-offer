class Category {
  int iD;
  String resName;
  String tittle;
  String description;
  String pImage;
  String productPrice;
  String category;
  String pTime;
  String pLocation;

  Category(
      {this.iD,
        this.resName,
        this.tittle,
        this.description,
        this.pImage,
        this.productPrice,
        this.category,
        this.pTime,
        this.pLocation});

  Category.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    resName = json['res_name'];
    tittle = json['tittle'];
    description = json['description'];
    pImage = json['p_image'];
    productPrice = json['product_price'];
    category = json['category'];
    pTime = json['p_time'];
    pLocation = json['p_location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['res_name'] = this.resName;
    data['tittle'] = this.tittle;
    data['description'] = this.description;
    data['p_image'] = this.pImage;
    data['product_price'] = this.productPrice;
    data['category'] = this.category;
    data['p_time'] = this.pTime;
    data['p_location'] = this.pLocation;
    return data;
  }
}
