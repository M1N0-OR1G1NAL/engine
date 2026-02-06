module Locomotive
  module Concerns
    module Account
      module FlightTierSystem
        extend ActiveSupport::Concern
        
        included do
          # Tier hierarchy for drone platform access
          field :platform_tier, type: Integer, default: 0
          field :transport_permissions, type: Hash, default: {}
          field :onboarding_completed_at, type: Time
          field :tier_notes, type: String
          
          after_initialize :setup_transport_hash
        end
        
        # Tier 0: Prospective - browsing only (unregistered)
        # Tier 1: Subscriber - full service access (registered user)
        # Tier 2: Overseer - system administration
        # Tier 3: TechCrew - maintenance and operations
        
        def browsing_prospect?
          platform_tier == 0
        end
        
        def subscribed_member?
          platform_tier == 1
        end
        
        def system_overseer?
          platform_tier == 2
        end
        
        def tech_crew?
          platform_tier == 3
        end
        
        def elevate_to_subscriber!
          update(platform_tier: 1, onboarding_completed_at: Time.current)
        end
        
        def appoint_overseer!
          return false unless can_become_overseer?
          update(platform_tier: 2, transport_permissions: {})
        end
        
        def assign_tech_crew!
          return false unless can_become_tech_crew?
          update(platform_tier: 3, transport_permissions: {})
        end
        
        def toggle_auto_taxi
          return unless subscribed_member?
          transport_permissions['route_automation'] = !transport_permissions.fetch('route_automation', false)
          save
        end
        
        def toggle_pilot_rental
          return unless subscribed_member?
          transport_permissions['manual_operation'] = !transport_permissions.fetch('manual_operation', false)
          save
        end
        
        def toggle_cargo_logistics
          return unless subscribed_member?
          transport_permissions['freight_handling'] = !transport_permissions.fetch('freight_handling', false)
          save
        end
        
        def auto_taxi_allowed?
          subscribed_member? && transport_permissions.fetch('route_automation', false)
        end
        
        def pilot_rental_allowed?
          subscribed_member? && transport_permissions.fetch('manual_operation', false)
        end
        
        def cargo_logistics_allowed?
          subscribed_member? && transport_permissions.fetch('freight_handling', false)
        end
        
        def tier_description
          case platform_tier
          when 0 then 'Prospective Visitor'
          when 1 then 'Active Subscriber'
          when 2 then 'System Overseer'
          when 3 then 'Technical Crew'
          else 'Unknown Tier'
          end
        end
        
        def subscriber_services
          return [] unless subscribed_member?
          
          services = []
          services << 'route_automation' if auto_taxi_allowed?
          services << 'manual_operation' if pilot_rental_allowed?
          services << 'freight_handling' if cargo_logistics_allowed?
          services
        end
        
        private
        
        def setup_transport_hash
          self.transport_permissions ||= {}
        end
        
        def can_become_overseer?
          super_admin? || system_overseer?
        end
        
        def can_become_tech_crew?
          super_admin? || system_overseer?
        end
        
      end
    end
  end
end
