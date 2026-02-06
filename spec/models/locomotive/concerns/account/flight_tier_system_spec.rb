require 'rails_helper'

RSpec.describe Locomotive::Concerns::Account::FlightTierSystem do
  
  let(:account) { Locomotive::Account.new(email: 'test@drontylity.com', name: 'Test User', password: 'password123') }
  
  before do
    account.save
  end
  
  describe 'tier initialization' do
    it 'starts as browsing prospect (tier 0)' do
      expect(account.platform_tier).to eq(0)
      expect(account.browsing_prospect?).to be true
    end
    
    it 'initializes empty transport permissions' do
      expect(account.transport_permissions).to eq({})
    end
  end
  
  describe 'tier transitions' do
    context 'from prospect to subscriber' do
      it 'elevates to tier 1' do
        account.elevate_to_subscriber!
        
        expect(account.platform_tier).to eq(1)
        expect(account.subscribed_member?).to be true
        expect(account.onboarding_completed_at).to be_present
      end
    end
    
    context 'to overseer' do
      before do
        account.update(super_admin: true)
      end
      
      it 'promotes to tier 2' do
        result = account.appoint_overseer!
        
        expect(result).to be_truthy
        expect(account.platform_tier).to eq(2)
        expect(account.system_overseer?).to be true
      end
      
      it 'clears transport permissions' do
        account.update(platform_tier: 1, transport_permissions: { 'route_automation' => true })
        account.appoint_overseer!
        
        expect(account.transport_permissions).to eq({})
      end
    end
    
    context 'to tech crew' do
      before do
        account.update(super_admin: true)
      end
      
      it 'assigns to tier 3' do
        result = account.assign_tech_crew!
        
        expect(result).to be_truthy
        expect(account.platform_tier).to eq(3)
        expect(account.tech_crew?).to be true
      end
    end
  end
  
  describe 'subscriber services' do
    before do
      account.elevate_to_subscriber!
    end
    
    it 'can toggle route automation service' do
      expect(account.auto_taxi_allowed?).to be false
      
      account.toggle_auto_taxi
      expect(account.auto_taxi_allowed?).to be true
      
      account.toggle_auto_taxi
      expect(account.auto_taxi_allowed?).to be false
    end
    
    it 'can toggle manual operation service' do
      expect(account.pilot_rental_allowed?).to be false
      
      account.toggle_pilot_rental
      expect(account.pilot_rental_allowed?).to be true
    end
    
    it 'can toggle freight handling service' do
      expect(account.cargo_logistics_allowed?).to be false
      
      account.toggle_cargo_logistics
      expect(account.cargo_logistics_allowed?).to be true
    end
    
    it 'returns list of enabled services' do
      account.toggle_auto_taxi
      account.toggle_cargo_logistics
      
      services = account.subscriber_services
      expect(services).to include('route_automation', 'freight_handling')
      expect(services).not_to include('manual_operation')
    end
  end
  
  describe 'service restrictions' do
    it 'does not allow services for prospects' do
      account.toggle_auto_taxi
      expect(account.auto_taxi_allowed?).to be false
    end
    
    it 'does not allow services for overseers' do
      account.update(super_admin: true)
      account.appoint_overseer!
      
      account.toggle_auto_taxi
      expect(account.auto_taxi_allowed?).to be false
    end
    
    it 'does not allow services for tech crew' do
      account.update(super_admin: true)
      account.assign_tech_crew!
      
      account.toggle_pilot_rental
      expect(account.pilot_rental_allowed?).to be false
    end
  end
  
  describe '#tier_description' do
    it 'returns correct description for each tier' do
      expect(account.tier_description).to eq('Prospective Visitor')
      
      account.elevate_to_subscriber!
      expect(account.tier_description).to eq('Active Subscriber')
      
      account.update(super_admin: true)
      account.appoint_overseer!
      expect(account.tier_description).to eq('System Overseer')
      
      account.assign_tech_crew!
      expect(account.tier_description).to eq('Technical Crew')
    end
  end
  
end
