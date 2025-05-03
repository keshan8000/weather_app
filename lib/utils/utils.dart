class UtilFunctions {
  // Function to get the weather animation based on the weather condition
  String getWeatherAnimation({required String condition}) {
    switch (condition.toLowerCase()) {
      case "clouds":
      case "mist":
      case "smoke":
      case "haze":
      case "dust":
      case "fog":
        return "assests/sunny.json";

      case "rain":
      case "drizzle":
      case "shower rain":
        return "assests/rain.json";

      case "thunderstorm":
        return "assests/rain.json";

      case "clear":
        return "assests/rain.json";

      default:
        return "assests/sunny.json";
    }
  }
}
