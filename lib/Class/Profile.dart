class Profile {
  String iD;
  String rName;
  String ownName;
  String email;
  String phone;
  String resLocation;
  String rBanner;
  String password;

  Profile(
      {this.iD,
        this.rName,
        this.ownName,
        this.email,
        this.phone,
        this.resLocation,
        this.rBanner,
        this.password});

  Profile.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    rName = json['r_name'];
    ownName = json['own_name'];
    email = json['email'];
    phone = json['phone'];
    resLocation = json['res_location'];
    rBanner = json['r_banner'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['r_name'] = this.rName;
    data['own_name'] = this.ownName;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['res_location'] = this.resLocation;
    data['r_banner'] = this.rBanner;
    data['password'] = this.password;
    return data;
  }
}
