class MercuryController < ActionController::Base
  include ::Mercury::Authentication

  protect_from_forgery
  layout false
  if Rails::VERSION::MAJOR <= 4
    before_filter :authenticate, :only => :edit
  else
    before_action :authenticate, :only => :edit
  end

  def edit
    if Rails::VERSION::MAJOR <= 4
      render :text => '', :layout => 'mercury'
    else
      render :html => '', :layout => 'mercury'
    end
  end

  def resource
    render :action => "/#{params[:type]}/#{params[:resource]}"
  end

  def snippet_options
    @options = params[:options] || {}
    render :action => "/snippets/#{params[:name]}/options"
  end

  def snippet_preview
    render :action => "/snippets/#{params[:name]}/preview"
  end

  def test_page
    render plain: params
  end

  private

  def authenticate
    redirect_to "/#{params[:requested_uri]}" unless can_edit?
  end
end
