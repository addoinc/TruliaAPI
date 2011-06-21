require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require File.expand_path(File.dirname(__FILE__) + '/../lib/trulia.rb')

describe "Trulia" do
  before do
    @location = Trulia::LocationInfo.new("xfkcvmcdapzxkedvsm3cc8uw") 
  end
    
  describe 'get_cities_in_state' do
    it 'should return cities when given a state' do
      cities = @location.get_cities_in_state('VA')
      cities.should be_success
      cities.data.should_not be_blank
    end
  end
end
