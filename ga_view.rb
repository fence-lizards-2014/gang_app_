require 'twilio-ruby'


class Text_creator

  def initialize(args = {})
    @mon = args["mon"]
    @tue = args["tue"]
    @wed = args["wed"]
    @thu = args["thu"]
    @fri = args["fri"]
    @week = [@mon, @tue, @wed, @thu, @fri]
    @mon_to_fri = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
    @gangs = @mon.keys
  end

  def print_possible_daily_pairs(i_day, gang_name)
    case i_day
    when "mon" then i_day = 0
    when "tue" then i_day = 1
    when "wed" then i_day = 2
    when "thu" then i_day = 3 
    when "fri" then i_day = 4
    end  

    text = ""
    day = @week[i_day]
    text << "Happy #{@mon_to_fri[i_day].capitalize}!\n" 
    text << " \n"
    day.each do |gang, pairs|
      if gang == "#{gang_name}"  
        text << "You are a member of #{gang.capitalize}. \n"
        # text << "Here you have a possible pair distribution\nfor today: \n"
        # text << " \n"
        pairs.each { |pair| text << "#{pair.a.name}-#{pair.b.name} \n" }
        text << " \n"
      end
    end
    text << "-Pair, make the WORLD a better place"
    text
  end

  def wed_text(gang_name)
    text = ""
    i = 0
    text << "Hey boot, member of #{gang_name}  \n"
    text << "Remember that you maybe paried with \n"
    text << "some of these boots so far. \n"
    text << " \n"
    text << "Give them some Feedback!!!!! \n"
    text << " \n"
    @week[0..2].each do |day|
      text << "#{@mon_to_fri[i].capitalize}: \n"
      day.each do |gang, pairs|
        if gang == gang_name  
          text << "\n"
          pairs.each { |pair| text << "#{pair.a.name} - #{pair.b.name} \n"}
          text << "\n"
        end
      end
      i += 1
    end
    text << "'Pairing makes the WORLD a better place'"
    text 
    end

  def sat_text(gang_name) 
    text = ""
    i = 0
    text << "Hey boot, member of #{gang_name}  \n"
    text << "Remember that you maybe paried with \n"
    text << "some of these boots so far. \n"
    text << " \n"
    text << "Give them some Feedback!!!!! \n"
    text << " \n"
    @week.each do |day|
      text << "#{@mon_to_fri[i].capitalize}: \n"
      day.each do |gang, pairs|
        if gang == gang_name  
          text << "\n"
          pairs.each { |pair| text << "#{pair.a.name} - #{pair.b.name} \n"}
          text << "\n"
        end
      end
      i += 1
    end
    text << "'Pairing makes the WORLD a better place'"
    text 
    end

end

class TextSender
  def initialize
    @account_sid = 'AC9c332190253787c068ae62a0f720XXXX' 
    @auth_token = '0bc52cddbda31dc004dbca6ac538XXXX' 
    @client = Twilio::REST::Client.new @account_sid, @auth_token
  end
   
  def send_text(gang_cell_numbers, text_body)
    puts text_body
    # puts "******"
    # gang_cell_numbers.each do |number|
    #   @client.account.sms.messages.create(
    #   :from => '+1928852XXXX',
    #   :to => number,
    #   :body => text_body)
    # end
  end
end
