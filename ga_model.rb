require_relative 'cohort_list'

class Cohort

  def initialize(name)
    @name = name
    @all_boots = COHORT_LIST.map {|boot|Boot.new(boot)} #database
    @mon_to_fri = ["mon", "tue", "wed", "thu", "fri"]
    @gangs_of_the_week = {}

  end

  def gang_creator(*boots_per_gang) 

    cohort_names = @all_boots

    raise("Check your boots per gang!") if cohort_names.length != boots_per_gang.inject(:+)

    number_of_gangs = boots_per_gang.length

    # Shuffle the cohort and boots_per_gang
    cohort_shuffled = cohort_names.shuffle
    boots_per_gang_shuffled = boots_per_gang.shuffle

    # Creates a Hash of group_number as keys and boots as values
    number_of_gangs.times do |counter|
      @gangs_of_the_week["gang_#{counter+1}"] = cohort_shuffled.pop(boots_per_gang_shuffled.pop)
    end

    @gangs_of_the_week
  end

  def possible_pairs_per_gang
    possible_pairs = {}
    @gangs_of_the_week.each do |gang_name, boots|

      pairs = []

      boots.shuffle.each_slice(2) do |pair|
        pairs << Pair.new(*pair)
      end

      possible_pairs[gang_name] = pairs
    end

    possible_pairs
  end

  def  final_weekly_hash
    final = {}
    @mon_to_fri.each {|day| final[day] = self.possible_pairs_per_gang}
    final
  end

end

class Boot
  attr_reader :name, :cellphone_number
  def initialize(args = {})
    @name = args[:name]
    @cellphone_number = args[:cellphone_number]
  end
end

class Pair
  attr_reader :a, :b
  def initialize(a, b = Solo.new)
    @a, @b = a, b
    self.sort_it 
  end

  def to_s
    "#{@a.name} is paired up with #{@b.name}"
  end

  def sort_it
    if @b.name < @a.name
      @a, @b = @b, @a
    end 
  end

  class Solo
    attr_reader :name
    def initialize
      @name = "Zolo"
    end
  end
end

class Gangs_phones
  def initialize(args = {})
    @gangs = [args["gang_1"], args["gang_2"], args["gang_3"], args["gang_4"]]
  end

  def cell_number(gang)
    case gang
    when "gang_1" then gang = 0
    when "gang_2" then gang = 1
    when "gang_3" then gang = 2
    when "gang_4" then gang = 3
    end
    phones = @gangs[gang].map {|boot| boot.cellphone_number}
  end
end


