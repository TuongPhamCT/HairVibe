class BranchModel {
  String? branchID;
  String? name;
  String? address;
  String? info;

  static String collectionName = 'Branches';

  BranchModel(
      {
        required this.branchID,
        required this.name,
        required this.address,
        this.info
      }
    );

  Map<String, dynamic> toJson() => {
    'branchID': branchID,
    'name': name,
    'address': address,
    'info': info
  };

  static BranchModel fromJson(Map<String, dynamic> json) {
    return BranchModel(
      branchID: json['destinationID'] as String,
      name: json['name'] as String,
      address: json['address'] as String,
      info: json['info'] as String,
    );
  }
}