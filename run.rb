# frozen_string_literal: true

require_relative 'api'

state = ARGV[0]
device_name = ARGV[1]

raise 'Invalid state' unless %w(off on).include? state

lights = API.instance.lights

if device_name
  lights = lights.filter do |device|
    device.label == device_name.capitalize
  end
end

state == 'on' ? lights.each(&:turn_on) : lights.each(&:turn_off)
