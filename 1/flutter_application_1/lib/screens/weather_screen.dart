import 'package:flutter/material.dart';

import '../components/weather_icon.dart';
import '../components/weather_info_card.dart';
import '../constants/styles/colors.dart';
import '../models/weather.dart';
import '../services/location_service.dart';
import '../services/weather_service.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final TextEditingController _cityController = TextEditingController();

  final WeatherService _weatherService = WeatherService();

  final LocationService _locationService = LocationService();

  Weather? _weather;

  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadCurrentLocationWeather();
  }

  Future<void> _loadCurrentLocationWeather() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final position = await _locationService.getCurrentLocation();

      final weather = await _weatherService.getWeatherByLocation(
        latitude: position.latitude,
        longitude: position.longitude,
      );

      setState(() {
        _weather = weather;
      });
    } catch (error) {
      setState(() {
        _errorMessage = error.toString();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _searchCity() async {
    final city = _cityController.text.trim();

    if (city.isEmpty) {
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final weather = await _weatherService.getWeatherByCity(city);

      setState(() {
        _weather = weather;
      });
    } catch (error) {
      setState(() {
        _errorMessage = error.toString();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            children: [
              const Text(
                'Weather App',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: AppColors.text,
                ),
              ),

              const SizedBox(height: 24),

              _buildSearchBar(),

              const SizedBox(height: 15),

              if (_isLoading)
                const Expanded(
                  child: Center(child: CircularProgressIndicator()),
                )
              else if (_errorMessage != null)
                Expanded(child: _buildError())
              else if (_weather != null)
                Expanded(child: _buildWeatherContent(_weather!)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _cityController,
            textInputAction: TextInputAction.search,
            onSubmitted: (_) => _searchCity(),
            decoration: InputDecoration(
              hintText: 'Enter city name...',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),

        const SizedBox(width: 10),

        ElevatedButton.icon(
          onPressed: _searchCity,
          icon: const Icon(Icons.search),
          label: const Text('Search'),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 18),
          ),
        ),
      ],
    );
  }

  Widget _buildWeatherContent(Weather weather) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.location_on, color: AppColors.primary),
              Text(
                '${weather.city}, ${weather.country}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              IconButton(
                onPressed: _loadCurrentLocationWeather,
                tooltip: 'Use current location',
                icon: const Icon(Icons.my_location, color: AppColors.primary),
              ),
            ],
          ),

          const SizedBox(height: 30),

          WeatherIcon(conditionId: weather.conditionId),

          const SizedBox(height: 10),

          Text(
            weather.description,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),

          const SizedBox(height: 10),

          Text(
            '${weather.temperature.round()}°C',
            style: const TextStyle(fontSize: 52, fontWeight: FontWeight.bold),
          ),

          Text(
            'Feels like ${weather.feelsLike.round()}°C',
            style: const TextStyle(color: AppColors.secondaryText),
          ),

          const SizedBox(height: 25),

          Row(
            children: [
              WeatherInfoCard(
                icon: Icons.water_drop,
                title: 'Humidity',
                value: '${weather.humidity}%',
              ),
              WeatherInfoCard(
                icon: Icons.air,
                title: 'Wind Speed',
                value: '${weather.windSpeed.toStringAsFixed(1)} m/s',
              ),
            ],
          ),

          Row(
            children: [
              WeatherInfoCard(
                icon: Icons.thermostat,
                title: 'Min Temp',
                value: '${weather.minTemperature.round()}°C',
              ),
              WeatherInfoCard(
                icon: Icons.thermostat,
                title: 'Max Temp',
                value: '${weather.maxTemperature.round()}°C',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildError() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.error_outline, size: 60, color: Colors.redAccent),
          const SizedBox(height: 10),
          Text(
            _errorMessage ?? 'Something went wrong.',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 15),
          ElevatedButton(
            onPressed: _loadCurrentLocationWeather,
            child: const Text('Try again'),
          ),
        ],
      ),
    );
  }
}
