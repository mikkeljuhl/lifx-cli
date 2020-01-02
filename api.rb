# frozen_string_literal: true
require 'singleton'
require 'net/http'
require 'uri'
require 'json'
require 'yaml'
require_relative 'light'

class API
  include Singleton

  def lights
    lights = request('lights/all')

    @lights = []

    lights.each do |light|
      @lights << Light.new(id: light['id'], power: light['power'], label: light['label'])
    end

    @lights
  end

  def change_state(id, state)
    raise 'Invalid state' unless %w(on off).include? state

    request("lights/#{id}/state", :put, { 'power' => state })
  end

  private

  def request(url, type = :get, body = nil)
    request = nil

    uri = URI.parse("#{base}/#{url}")
    if type == :get
      request = Net::HTTP::Get.new(uri)
    elsif type == :put
      request = Net::HTTP::Put.new(uri)
    end

    raise 'Request type not implemented' if request.nil?

    request['Authorization'] = "Bearer #{token}"
    request.set_form_data(body) if body

    response = Net::HTTP.start(uri.hostname, 443, use_ssl: uri.scheme == 'https') do |http|
      http.request(request)
    end

    JSON.parse(response.body)
  end

  def base
    "https://api.lifx.com/v1"
  end

  def token
    YAML.load_file("#{File.expand_path(File.dirname(__FILE__))}/secrets.yml")['token']
  end
end
