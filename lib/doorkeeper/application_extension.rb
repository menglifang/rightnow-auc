module Doorkeeper
  module ApplicationExtension
    extend ActiveSupport::Concern

    def url
      @url ||= begin
                 uri = URI.parse(redirect_uri)
                 uri.to_s.gsub(uri.path, '')
               end
    end
  end
end

Doorkeeper::Application.send(:include, Doorkeeper::ApplicationExtension)
