class DemoController < ApplicationController
  def index
    DemoJob.perform_async
  end
end
