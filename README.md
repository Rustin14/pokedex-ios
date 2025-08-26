# PokéDex - SwiftUI Pokémon Information App

A modern SwiftUI application that provides comprehensive information about all 1025+ Pokémon, designed to work completely offline and available for free.

## 🚀 Features

- **Complete Pokémon Database**: Browse information for all 1025+ Pokémon
- **Offline First**: All data available without internet connection
- **Modern UI**: Built with SwiftUI for a native iOS experience
- **Smooth Animations**: Enhanced user experience with CoreAnimation
- **Free & Open Source**: No ads, no in-app purchases, completely free

## 🛠 Technologies Used

### Core Technologies
- **SwiftUI** - Modern declarative UI framework for iOS
- **Combine** - Reactive programming framework for handling asynchronous data flows
- **CoreData** - Local data persistence and management
- **CoreAnimation** - Smooth animations and visual effects

### Networking & Data
- **Alamofire** - HTTP networking for initial data fetching and updates
- **JSON Decoding** - Native Swift JSON parsing for Pokémon data

### Additional Features
- **MVVM Architecture** - Clean separation of concerns
- **Async/Await** - Modern concurrency for smooth performance
- **Search & Filter** - Quick Pokémon discovery functionality

## 📱 Screenshots

*Coming soon - Screenshots will be added as development progresses*

## 🎯 Requirements

- iOS 15.0+
- Xcode 14.0+
- Swift 5.7+

## 🔧 Installation

1. Clone the repository:
```bash
git clone https://github.com/rustin14/pokedex-ios.git
```

2. Open the project in Xcode:
```bash
cd pokedex-ios
open PokeDex.xcodeproj
```

3. Build and run the project (⌘ + R)

## 📊 Data Source

This app utilizes Pokémon data from reliable sources to provide accurate and up-to-date information about:
- Basic Pokémon stats (HP, Attack, Defense, etc.)
- Evolution chains
- Pokédex entries and descriptions
- Sprite images and artwork

## 🏗 Architecture

The app follows the **MVVM (Model-View-ViewModel)** pattern:

- **Models**: CoreData entities and Pokémon data structures
- **Views**: SwiftUI views for different screens
- **ViewModels**: Combine-powered reactive data handling
- **Services**: Alamofire-based networking and CoreData management

## 🎨 Key Components

### Data Layer
- **CoreData Stack**: Persistent storage for offline functionality
- **Network Service**: Alamofire-based API communication
- **Repository Pattern**: Clean abstraction for data access

### UI Layer
- **Custom SwiftUI Views**: Reusable components for Pokémon cards, stats, etc.
- **CoreAnimation Integration**: Smooth transitions and micro-interactions
- **Responsive Design**: Optimized for all iOS device sizes

### Reactive Programming
- **Combine Publishers**: Reactive data streams
- **Property Wrappers**: @StateObject, @ObservedObject for SwiftUI integration
- **Async/Await**: Modern concurrency for network operations

## 🔄 Development Status

- [X] Initial project setup
- [X] CoreData model design
- [ ] Networking layer with Alamofire
- [ ] Basic SwiftUI views
- [ ] Combine integration
- [ ] CoreAnimation implementations
- [ ] Search and filter functionality
- [ ] Offline data management
- [ ] Testing and optimization

*Built with ❤️ and Swift*
