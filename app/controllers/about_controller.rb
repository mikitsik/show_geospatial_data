class AboutController < ApplicationController
  def about
    @about_content = File.read("README.md")
  end
end
