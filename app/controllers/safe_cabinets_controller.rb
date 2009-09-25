class SafeCabinetsController < ApplicationController
  unloadable
  
  def show
    @cabinet = SafeCabinet.find(params[:id])
    @data = nil
  end
  
  
  def unlock
    @cabinet = SafeCabinet.find(params[:id])
    @data = @cabinet.read_data(params[:passphrase])
    render :show
  end
end