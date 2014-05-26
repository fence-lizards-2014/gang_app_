require_relative 'ga_model'
require_relative 'ga_view'

class PairGenerator
  def initialize
    @fence_lizards = Cohort.new("Fence Lizards")
    @gangs = @fence_lizards.gang_creator(7,7,7,6)
    gangs_pairs = @fence_lizards.final_weekly_hash
    @text = Text_creator.new(gangs_pairs)
    @cell_number = Gangs_phones.new(@gangs)
    @gang_names = @gangs.keys
    @text_sender = TextSender.new
    
    self.daily_text("mon")
    self.daily_text("tue")
    self.daily_text("wed")
    self.wednesday_text 
    self.daily_text("thu")
    self.daily_text("fri")
    self.saturday_text

  end

  def daily_text(day)
    @gang_names.each do |gang_name|
      body = @text.print_possible_daily_pairs(day, gang_name)
      gang_cell_numbers =  @cell_number.cell_number(gang_name)
      @text_sender.send_text(gang_cell_numbers, body)
    end
  end

  def wednesday_text
    @gang_names.each do |gang_name|      
      puts body = @text.wed_text(gang_name)
      gang_cell_numbers = @cell_number.cell_number(gang_name)
      @text_sender.send_text(gang_cell_numbers, body)
    end
  end

  def saturday_text
    @gang_names.each do |gang_name|         
      body = @text.sat_text(gang_name)
      gang_cell_numbers = @cell_number.cell_number(gang_name)
      @text_sender.send_text(gang_cell_numbers, body)
    end
  end

end


PairGenerator.new