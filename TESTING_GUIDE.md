# Manual Testing Guide for Flight Tier System

This guide provides manual testing procedures to validate the 4-phase flight tier authentication system.

## Prerequisites

1. Rails environment running
2. MongoDB connection configured
3. At least one super_admin account created

## Test Scenarios

### Scenario 1: New User Tier 0 (Prospective Visitor)

**Steps:**
1. Create a new account via console or registration
2. Navigate to `/flight-access`
3. **Expected:** See "Prospective Visitor" badge
4. **Expected:** See "Fáze 1: Neregistrovaný návštěvník" with upgrade button
5. **Expected:** No service toggles visible

**Console Verification:**
```ruby
account = Locomotive::Account.last
account.browsing_prospect?  # => true
account.platform_tier  # => 0
account.transport_permissions  # => {}
```

### Scenario 2: Upgrade to Tier 1 (Subscriber)

**Steps:**
1. From Tier 0 dashboard, click "Přejít na předplatné" button
2. Confirm the upgrade
3. **Expected:** Redirect to dashboard showing "Active Subscriber" badge
4. **Expected:** See service grid with 3 service boxes (all inactive)
5. **Expected:** See activate buttons for each service

**Console Verification:**
```ruby
account.reload
account.subscribed_member?  # => true
account.platform_tier  # => 1
account.onboarding_completed_at.present?  # => true
```

### Scenario 3: Toggle Subscriber Services

**Steps:**
1. As Tier 1 user, click "Aktivovat tuto službu" for Automated Taxi
2. **Expected:** Service box gets "active" styling
3. **Expected:** Button changes to "Deaktivovat službu"
4. Click activate for Manual Flight service
5. Click activate for Cargo Delivery service
6. **Expected:** All three services show as active

**Console Verification:**
```ruby
account.reload
account.auto_taxi_allowed?  # => true
account.pilot_rental_allowed?  # => true
account.cargo_logistics_allowed?  # => true
account.subscriber_services  # => ['route_automation', 'manual_operation', 'freight_handling']
```

### Scenario 4: Deactivate a Service

**Steps:**
1. From active service, click "Deaktivovat službu"
2. **Expected:** Service box loses "active" styling
3. **Expected:** Button changes back to "Aktivovat tuto službu"

**Console Verification:**
```ruby
account.reload
account.auto_taxi_allowed?  # => false (if auto taxi was deactivated)
```

### Scenario 5: Promote to Tier 2 (System Overseer)

**Pre-requisite:** Login as super_admin

**Steps:**
1. Navigate to `/flight-access`
2. Scroll to "Administrátorské ovládání úrovní"
3. Click "Nastavit jako administrátora"
4. **Expected:** Dashboard shows "System Overseer" badge
5. **Expected:** See "Fáze 3: Administrátor platformy"
6. **Expected:** See "Správa platformy" button
7. **Expected:** No service toggles visible

**Console Verification:**
```ruby
account.reload
account.system_overseer?  # => true
account.platform_tier  # => 2
account.transport_permissions  # => {} (cleared)
```

### Scenario 6: Assign to Tier 3 (Tech Crew)

**Pre-requisite:** Login as super_admin or tier 2 overseer

**Steps:**
1. Navigate to `/flight-access`
2. Click "Nastavit jako technika"
3. **Expected:** Dashboard shows "Technical Crew" badge
4. **Expected:** See "Fáze 4: Správce / Údržbář"
5. **Expected:** See "Diagnostika flotily" button
6. **Expected:** No service toggles visible

**Console Verification:**
```ruby
account.reload
account.tech_crew?  # => true
account.platform_tier  # => 3
```

### Scenario 7: Navigation Menu Integration

**Steps:**
1. Login with any account
2. Click on avatar/name in top navigation
3. **Expected:** See "Drontylity Přístup" menu item
4. Click "Drontylity Přístup"
5. **Expected:** Navigate to `/flight-access` dashboard

### Scenario 8: Permission Restrictions

**Test A - Services restricted to Tier 1:**
```ruby
account = Locomotive::Account.find_by_email('overseer@example.com')
account.appoint_overseer!  # Tier 2
account.toggle_auto_taxi
account.auto_taxi_allowed?  # => false (not allowed for tier 2)
```

**Test B - Tier promotion requires permissions:**
```ruby
regular_account = Locomotive::Account.find_by_email('user@example.com')
regular_account.super_admin = false
regular_account.save

regular_account.appoint_overseer!  # => false (not allowed)
regular_account.system_overseer?  # => false (unchanged)
```

## Localization Testing

### Czech (cs) Locale
1. Set account locale to 'cs'
2. Navigate to `/flight-access`
3. **Expected:** All text in Czech
4. **Expected:** Service names match problem statement:
   - "a) Automatizovaná taxi jízda z A do B"
   - "b) Půjčení persona dronu - vlastní pilotování"
   - "c) Transport balíků / Logistika"

### English (en) Locale
1. Set account locale to 'en'
2. Navigate to `/flight-access`
3. **Expected:** All text in English
4. **Expected:** Consistent English terminology

## Edge Cases

### Edge Case 1: Direct URL Access
- Non-authenticated users accessing `/flight-access`
- **Expected:** Redirect to sign-in page

### Edge Case 2: Service Toggle Spam
- Rapidly clicking activate/deactivate buttons
- **Expected:** No errors, state correctly reflects final click

### Edge Case 3: Multiple Browser Tabs
- Open `/flight-access` in two tabs
- Change tier in one tab
- Refresh second tab
- **Expected:** Second tab shows updated tier

## API Testing (JSON format)

```bash
curl -H "Content-Type: application/json" \
     -H "X-User-Email: user@example.com" \
     -H "X-User-Token: AUTH_TOKEN" \
     http://localhost:3000/flight-access.json
```

**Expected Response:**
```json
{
  "tier_level": 1,
  "tier_name": "Active Subscriber",
  "services": ["route_automation", "manual_operation"],
  "onboarded_at": "2026-02-06T12:34:56.789Z"
}
```

## Automated Test Execution

If RSpec environment is available:

```bash
bundle exec rspec spec/models/locomotive/concerns/account/flight_tier_system_spec.rb
```

**Expected:** All tests pass (16 examples, 0 failures)

## Checklist

- [ ] Tier 0 displays correctly with upgrade option
- [ ] Tier 1 upgrade works and sets timestamp
- [ ] All 3 services can be toggled independently
- [ ] Service toggles only work for Tier 1
- [ ] Tier 2 promotion clears services
- [ ] Tier 3 assignment works
- [ ] Navigation menu shows flight tier link
- [ ] Czech localization displays correctly
- [ ] English localization displays correctly
- [ ] Permissions prevent unauthorized tier changes
- [ ] JSON API returns correct data
- [ ] Automated tests pass (if available)
