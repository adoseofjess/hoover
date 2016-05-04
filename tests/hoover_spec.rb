require 'rspec'
require_relative '../hoover'

describe Hoover do
  let(:hoover) { Hoover.new("input.txt") }

  describe '#initialize' do
    it 'initializes the hoover with the file given' do
      expect(hoover).to_not be_nil
    end

    it 'sets the correct room dimension value' do
      expect(hoover.room_dimensions).to eq([5,5])
    end

    it 'sets the correct hoover position value' do
      expect(hoover.hoover_position).to eq([1,2])
    end

    it 'sets the correct dirt patches values' do
      expect(hoover.dirt_patches).to eq([[1,0],[2,2],[2,3]])
    end

    it 'sets the correct directions values' do
      expect(hoover.directions).to eq(["N", "N", "E", "S", "E", "E", "S", "W", "N", "W", "W"])
    end
  end

  describe "#transform" do
    before(:each) do
      hoover.hoover_position = [3,3]
    end

    it 'correctly transforms hoover_position to north' do
      expect(hoover.transform([0,1])).to eq([3,4])
    end

    it 'correctly transforms hoover_position to south' do
      expect(hoover.transform([0,-1])).to eq([3,2])
    end

    it 'does not go to a negative coordinate' do
      5.times do
        hoover.transform([0,-1])
      end

      expect(hoover.hoover_position).to eq([3,0])
    end

    it 'does not go beyond the room dimension value' do
      5.times do
        hoover.transform([0,1])
      end

      expect(hoover.hoover_position).to eq([3,5])
    end
  end

  describe '#run' do
    it 'correctly increments count of dirt patches' do
      expect{hoover.run}.to change{hoover.count_of_dirt_patches}.from(0).to(1)
    end
  end
end