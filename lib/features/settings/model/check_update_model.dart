class CheckUpdateModel {
  CheckUpdateData? data;

  CheckUpdateModel({this.data});

  CheckUpdateModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null
        ? new CheckUpdateData.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class CheckUpdateData {
  String? platform;
  String? currentVersion;
  int? currentBuildNumber;
  String? latestVersion;
  int? latestBuildNumber;
  int? minimumBuildNumber;
  bool? updateAvailable;
  bool? forceUpdate;
  dynamic storeUrl;
  dynamic releaseNotes;

  CheckUpdateData(
      {this.platform,
      this.currentVersion,
      this.currentBuildNumber,
      this.latestVersion,
      this.latestBuildNumber,
      this.minimumBuildNumber,
      this.updateAvailable,
      this.forceUpdate,
      this.storeUrl,
      this.releaseNotes});

  CheckUpdateData.fromJson(Map<String, dynamic> json) {
    platform = json['platform'];
    currentVersion = json['current_version'];
    currentBuildNumber = json['current_build_number'];
    latestVersion = json['latest_version'];
    latestBuildNumber = json['latest_build_number'];
    minimumBuildNumber = json['minimum_build_number'];
    updateAvailable = json['update_available'];
    forceUpdate = json['force_update'];
    storeUrl = json['store_url'];
    releaseNotes = json['release_notes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['platform'] = this.platform;
    data['current_version'] = this.currentVersion;
    data['current_build_number'] = this.currentBuildNumber;
    data['latest_version'] = this.latestVersion;
    data['latest_build_number'] = this.latestBuildNumber;
    data['minimum_build_number'] = this.minimumBuildNumber;
    data['update_available'] = this.updateAvailable;
    data['force_update'] = this.forceUpdate;
    data['store_url'] = this.storeUrl;
    data['release_notes'] = this.releaseNotes;
    return data;
  }
}
