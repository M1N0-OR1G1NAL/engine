module Locomotive
  class FlightAccessController < BaseController
    
    before_action :authenticate_locomotive_account!
    
    def dashboard
      @current_tier = current_account.platform_tier
      @tier_label = current_account.tier_description
      
      respond_to do |format|
        format.html
        format.json { render json: build_tier_data }
      end
    end
    
    def elevate_tier
      target_tier = params[:target].to_i
      
      result = case target_tier
      when 1
        current_account.elevate_to_subscriber!
      when 2
        current_account.appoint_overseer!
      when 3
        current_account.assign_tech_crew!
      else
        false
      end
      
      if result
        flash[:notice] = I18n.t('locomotive.flight_access.tier_changed')
        redirect_to flight_access_dashboard_path
      else
        flash[:alert] = I18n.t('locomotive.flight_access.tier_change_failed')
        redirect_back(fallback_location: flight_access_dashboard_path)
      end
    end
    
    def modify_service
      service_key = params[:service]
      
      case service_key
      when 'auto_taxi'
        current_account.toggle_auto_taxi
      when 'pilot_rental'
        current_account.toggle_pilot_rental
      when 'cargo_logistics'
        current_account.toggle_cargo_logistics
      end
      
      redirect_to flight_access_dashboard_path
    end
    
    private
    
    def build_tier_data
      {
        tier_level: current_account.platform_tier,
        tier_name: current_account.tier_description,
        services: current_account.subscriber_services,
        onboarded_at: current_account.onboarding_completed_at
      }
    end
    
  end
end
