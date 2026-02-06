# Copilot Instructions for Drontylity Engine

## Project Overview

Drontylity Engine is a revolutionary autonomous drone-sharing platform for urban mobility. This software system manages a fleet of autonomous aerial vehicles, enabling users to order drone transport from point A to point B with real-time flight tracking and various service levels.

## Core Concept

The platform provides urban transportation through autonomous drones powered by renewable energy (solar and wind charging stations). The system offers three service levels:

- **Level 1 - Basic Transport**: User goes to a predetermined station where the drone waits ready for departure
- **Level 2 - Personal Arrival**: Drone flies directly to the user's current position and transports them to the destination
- **Level 3 - Autonomous Sharing**: Carsharing-like model where users rent drones for any duration and return them to any available dock in the network

## Key Features to Implement

### 1. Drone Taxi Ordering
- User enters starting position (A) and destination position (B)
- Option to choose between fixed pickup point (level 1) or flight to user's location (level 2)
- Real-time route calculation and optimization

### 2. Autonomous Control
- Drone operates using sensor-controlled artificial intelligence
- Navigation and collision avoidance systems
- Communication with other drones and objects in the environment
- Safety-first approach with emergency landing procedures

### 3. Drone Sharing (Level 3)
- Users can borrow drones similar to carsharing vehicles
- Flexibility in usage and return to predetermined "docks"
- Real-time availability tracking
- Battery status and range information

### 4. Charging Infrastructure
- Solar and wind stations distributed in localities providing drone energy
- Drones equipped with solar panels for supplementary charging
- Energy management and optimization algorithms

### 5. Safety and Compliance Features
- **Photo Control**: Photo verification of rented drone before and after flight by the user
- **Pilot Authorization**: Verification of user's permission to pilot drones
- **Legislative Control**: Compliance with aviation regulations and airspace restrictions
- **Weather Monitoring**: Automatic service suspension during adverse conditions

## Problems Being Solved

- Overcrowded urban traffic and long commute times
- Insufficient flexibility of shared resources in hard-to-reach areas
- Ecological problems of traditional transportation
- Carbon emissions reduction in transportation sector

## Target Audience

- Urban cities with large population volumes
- Companies seeking efficient fleet management for package or employee transport
- Ecologically-minded customers wanting to use sustainable transportation
- Early adopters interested in innovative mobility solutions

## Architecture and Functionality

### 1. Frontend (Mobile Application)
- **Route Selection**: User selects points A and B on the map (Google Maps API integration)
- **Real-time Localization**: Tracking the position of the ordered drone
- **Payments and Reservations**: Reservation capability and payment gateway integration
- **Drone Management (for level 3 sharing)**: Information about flight range, battery status, dock locations
- **User Dashboard**: Service level selection, trip history, user profile
- **Photo Documentation**: Before/after flight photo capture and verification

### 2. Backend (Server Logic)
- **Routing Algorithm**: Optimization for flight routes (e.g., A* algorithm, custom navigation AI)
- **Sensor Integration**: Data analysis from drones (for collision detection, weather, etc.)
- **Energy Management**: Monitoring charge status and charging operations
- **Fleet Management**: Drone assignment, availability tracking, maintenance scheduling
- **Analytics**: Predictive demand modeling, usage patterns, optimization
- **Compliance Engine**: Legislative checks, airspace restrictions, pilot authorization verification

### 3. Integration with Drones (IoT)
- Direct connection of drones to cloud system (AWS IoT, Azure IoT)
- Autonomous sensors and cameras for navigation and collision avoidance
- Drones for transporting live persons or cargo
- Real-time telemetry and diagnostics
- Automatic emergency procedures

## Technology Stack

**Planned Technologies:**
- Cloud: AWS IoT / Azure IoT Hub
- Backend: Microservices architecture
- Database: PostgreSQL + Redis
- Real-time: WebSocket communication
- AI/ML: TensorFlow for navigation models
- Mapping: Custom implementation over open-source data
- Mobile: React Native or Flutter

**For Development:**
- Backend: Python, Node.js, or Go
- Start with integration of existing drones like DJI Matrice for testing software
- API connections with navigation systems

## Implementation Approach

### MVP (Minimum Viable Product)
1. **Start with simple use case**: Drone reservation and flight simulation environment
2. **Connect with existing technologies**: Integrate available drones like DJI Matrice (for software testing)
3. **Focus on software part**:
   - Backend for reservation management, routing, and fleet control
   - API connections with navigation systems
   - Basic mobile app with reservation functionality

### Development Priorities
1. Reservation system and basic UI
2. Route optimization algorithms
3. Real-time tracking and telemetry
4. Energy management system
5. Level 1 service implementation
6. Extend to Level 2 and Level 3

### Patent Strategy
- Patent relates to "methods and systems used in autonomous aerial transport"
- Register invention with patent offices (e.g., USPTO, European Patent Office)
- Specify unique elements:
  - Integration of mechanical sensors, solar and wind charging
  - Autonomous control based on individual service levels
  - Dynamic fleet optimization algorithms

## Coding Conventions

### General Guidelines
- Write clean, maintainable code with clear documentation
- Use meaningful variable and function names
- Follow DRY (Don't Repeat Yourself) principle
- Implement proper error handling and logging
- Write unit tests for critical functionality

### API Design
- RESTful API design principles
- Clear endpoint naming conventions
- Proper HTTP status codes
- Comprehensive API documentation
- Version your APIs (e.g., /api/v1/)

### Data Models
- Use clear, descriptive model names
- Implement proper data validation
- Handle edge cases and invalid data gracefully
- Consider scalability in data structure design

### Security Considerations
- Never commit secrets or credentials
- Implement proper authentication and authorization
- Validate all user inputs
- Use secure communication (HTTPS, WSS)
- Follow OWASP security best practices
- Protect user privacy and data

### Testing
- Write tests before or alongside code changes
- Ensure tests are isolated and repeatable
- Test edge cases and error conditions
- Maintain high test coverage for critical paths

## Team Structure

- Developers (backend, frontend)
- Specialists in drone technology
- Lawyers focused on intellectual property
- AI/ML engineers for navigation systems
- IoT engineers with drone experience
- DevOps for cloud infrastructure

## Important Notes

- This is a conceptual project in active development
- All specifications and timeframes are indicative and may change
- Safety is the top priority - no compromises
- Regulatory compliance is mandatory
- Focus on sustainability and ecological impact
- The platform currently handles one passenger or equivalent cargo weight (approx. 80-100 kg)
- Service is not available in all weather conditions
- Not a replacement for all transportation but optimized for urban short-to-medium distances

## Language Note

The project documentation and user-facing content should support Czech language (CS) as the primary language, with consideration for internationalization (i18n) for future expansion.
