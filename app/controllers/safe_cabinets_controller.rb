class SafeCabinetsController < ApplicationController
  unloadable
  
  filter_parameter_logging :data
  filter_parameter_logging :password
  
  def show
    @cabinet = SafeCabinet.find(params[:id])
    @data = nil
  end
  
  
  def unlock
    @cabinet = SafeCabinet.find(params[:id])
    @data = @cabinet.read_data(params[:password])
    render :show
  end

end