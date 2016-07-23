class SearchesController < ApplicationController

  def new
    @search = Search.new
  end

  def create
    job_results = JobClient.new(search_params).results(0)
    jobs_index = render_to_string 'job_results/index', locals: { jobs: job_results }
    render html: jobs_index
  end

  private

  def search_params
    params[:search].permit(categories: [], companies: [], levels: [], locations: [])
  end
end
