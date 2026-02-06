# Drontylity Flight Tier Access System

## Overview

This system implements a 4-phase authentication and authorization model specifically designed for the Drontylity autonomous drone platform. Each tier provides different levels of access and capabilities.

## Architecture

The system uses a concern-based mixin (`FlightTierSystem`) that extends the `Account` model with tier-based permissions and service toggles.

### Core Components

1. **FlightTierSystem Concern** - Located in `app/models/locomotive/concerns/account/flight_tier_system.rb`
2. **FlightAccessController** - Manages tier elevation and service modifications
3. **Dashboard View** - Displays tier-specific content and service controls
4. **Localizations** - Czech and English translations for all UI elements

## The 4 Tiers

### Tier 0: Prospective Visitor (Neregistrovaný uživatel)
- **Purpose**: Marketing and exploration
- **Access**: Read-only view of platform capabilities
- **Upgrade Path**: Can self-upgrade to Tier 1 (Subscriber)

### Tier 1: Active Subscriber (Registrovaný uživatel)
- **Purpose**: Full service access for drone transportation
- **Services Available**:
  - **a) Route Automation** - Automated taxi rides from point A to B
  - **b) Manual Operation** - Personal drone rental with own piloting
  - **c) Freight Handling** - Package transport and logistics
- **Service Control**: Each service can be independently toggled on/off
- **Storage**: Service states stored in `transport_permissions` hash field

### Tier 2: System Overseer (Administrátor)
- **Purpose**: Platform administration
- **Capabilities**: User management, system configuration, platform oversight
- **Restrictions**: Cannot access subscriber services

### Tier 3: Technical Crew (Správce/Údržbář)
- **Purpose**: Fleet maintenance and operations
- **Capabilities**: Diagnostic tools, maintenance protocols, technical management
- **Restrictions**: Cannot access subscriber services

## Database Schema

### New Fields on Account Model

```ruby
field :platform_tier, type: Integer, default: 0
field :transport_permissions, type: Hash, default: {}
field :onboarding_completed_at, type: Time
field :tier_notes, type: String
```

### Transport Permissions Structure

```ruby
{
  'route_automation' => true/false,   # Service a
  'manual_operation' => true/false,   # Service b
  'freight_handling' => true/false    # Service c
}
```

## API Methods

### Tier Queries
- `browsing_prospect?` - Returns true if tier 0
- `subscribed_member?` - Returns true if tier 1
- `system_overseer?` - Returns true if tier 2
- `tech_crew?` - Returns true if tier 3

### Tier Elevation
- `elevate_to_subscriber!` - Promotes to tier 1 with timestamp
- `appoint_overseer!` - Promotes to tier 2 (requires permissions)
- `assign_tech_crew!` - Promotes to tier 3 (requires permissions)

### Service Management (Tier 1 Only)
- `toggle_auto_taxi` - Toggles route automation service
- `toggle_pilot_rental` - Toggles manual operation service
- `toggle_cargo_logistics` - Toggles freight handling service
- `auto_taxi_allowed?` - Checks if route automation is enabled
- `pilot_rental_allowed?` - Checks if manual operation is enabled
- `cargo_logistics_allowed?` - Checks if freight handling is enabled

### Utility Methods
- `tier_description` - Returns human-readable tier name
- `subscriber_services` - Returns array of enabled services

## Routes

```
GET  /flight-access                      # Dashboard
POST /flight-access/elevate/:target      # Change tier level
POST /flight-access/service/:service     # Toggle service on/off
```

## Usage Examples

### Upgrading a User to Subscriber

```ruby
account = Locomotive::Account.find_by_email('user@example.com')
account.elevate_to_subscriber!
```

### Enabling Services for Subscriber

```ruby
account.toggle_auto_taxi        # Enable automated taxi
account.toggle_pilot_rental     # Enable drone rental
account.toggle_cargo_logistics  # Enable package transport
```

### Checking Access

```ruby
if current_account.subscribed_member? && current_account.auto_taxi_allowed?
  # User can book automated taxi ride
end
```

### Administrative Tier Assignment

```ruby
if current_account.super_admin?
  other_account.appoint_overseer!  # Make them an administrator
  other_account.assign_tech_crew!  # Or make them maintenance crew
end
```

## Security Considerations

1. **Tier Elevation Controls**: Only super_admin or system_overseer can promote users to tiers 2 and 3
2. **Service Isolation**: Administrative tiers cannot access subscriber services
3. **Self-Service**: Users can only self-upgrade from tier 0 to tier 1
4. **Audit Trail**: `onboarding_completed_at` timestamp tracks when users became subscribers

## UI Flow

1. **Unregistered visitors** see marketing content and upgrade prompt
2. **Subscribers** see a service grid with toggle controls for each transportation service
3. **Overseers** see platform management tools
4. **Tech Crew** see fleet diagnostic and maintenance interfaces
5. **Super Admins** see tier control buttons to manually set any user's tier

## Localization Keys

All UI text is fully localized in Czech (`cs`) and English (`en`):

- `locomotive.flight_access.dashboard.*` - Main dashboard content
- `locomotive.flight_access.tier_changed` - Success message
- `locomotive.flight_access.tier_change_failed` - Error message
- `locomotive.shared.header.flight_tier` - Navigation menu item

## Testing Recommendations

1. Test tier 0 → tier 1 self-upgrade flow
2. Verify service toggles work only for tier 1 users
3. Confirm tier 2/3 promotion requires proper permissions
4. Test that administrative tiers cannot access subscriber services
5. Verify navigation menu displays flight tier link
6. Check localization for both Czech and English

## Future Enhancements

- Add tariff plan selection and pricing tiers
- Implement service usage analytics
- Add tier-specific dashboards with metrics
- Create admin panel for bulk tier management
- Add email notifications for tier changes
