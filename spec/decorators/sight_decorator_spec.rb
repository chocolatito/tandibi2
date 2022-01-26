# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SightDecorator do
  let(:sight) { Sight.new.extend SightDecorator }
  subject { sight }
  it { should be_a Sight }
end
