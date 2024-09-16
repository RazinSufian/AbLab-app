class AppUrl {

  static var dev = "/dev";
  static var live = "/api";

  // Make current_stage static
  static String current_stage = dev;

  // Now you can use current_stage in the static variable
  static var baseUrl = 'https://3p3xvw09xg.execute-api.ap-south-1.amazonaws.com' + current_stage;

  static var reportMonthlySummary =  baseUrl + '/report_list';

}
