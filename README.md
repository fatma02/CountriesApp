# CountriesApp

A SwiftUI-based iOS application that fetches and displays a list of countries. Users can view details about each country, including its flag, region, population, and capital.


Architecture

The project follows MVVM (Model-View-ViewModel) for better separation of concerns:
├── Models          # Data structures for Country
├── ViewModels      # Handles business logic and API calls
├── Views           # SwiftUI views for displaying data
├── Services        # Networking layer for fetching data
├── Tests           # Unit tests for ViewModel
