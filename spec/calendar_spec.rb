require 'spec_helper'

describe Calendar do
  it { should have_many :events }
end
