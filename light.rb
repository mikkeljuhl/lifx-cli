# frozen_string_literal: true
# Class of light
class Light
  attr_accessor :id, :power, :label

  def initialize(id:, power:, label:)
    @id = id
    @power = power
    @label = label.rstrip
  end

  def turn_on
    @power = 'on'
    API.instance.change_state(@id, 'on')
  end

  def turn_off
    @power = 'off'
    API.instance.change_state(@id, 'off')
  end
end
