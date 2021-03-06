class SearchesController < ApplicationController

  def new
    @search = Search.new
  end

  def index
    results_hash = JobClient.new(flash[:search_params]).results(params[:page])
    flash.keep(:search_params)
    @pages = results_hash[:page_count] - 1
    @job_results = results_hash[:job_results]
  end

  def create
    flash[:search_params] = search_params
    flash.keep(:search_params)
    redirect_to '/searches?page=0'
  end

  private

  def search_params
    params[:search].permit(categories: [], companies: [], levels: [], locations: [])
  end
end
