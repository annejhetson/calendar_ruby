require 'spec_helper'

describe Event do
  it { should validate_presence_of :description }
  it { should validate_presence_of :start }
  it { should belong_to :calendar }




    it 'ensures that the description field is not empty' do
      test_event = Event.create({description: 'wedding', location: 'courthouse',
                               start: '2014/03/24 1:15', :end => '2014/03/24 1:10'})
      test_event.valid?.should eq false
    end

  describe '.list_todays_events' do
    it 'list all todays events' do
      test_event = Event.create({description: 'wedding', location: 'courthouse',
                               start: '2014-03-27 18:04', :end => '2014-03-27 19:04'})
      Event.list_todays_events.should eq [test_event]
    end
  end
end
#   it 'valideates that the event start time is prior to end time' do
#     test_event = Event.create({description: 'wedding', location: 'courthouse',
#                               start: '2014/03/24 1:15', :end => '2014/03/24 1:10'})

#     binding.pry
#     Event.all.should eq []
#   end

