class Daily < ApplicationRecord

validates :date, uniqueness: { scope: :habit, message: "can only have one of each daily habit type" }
validates :date, presence: true
validates :habit, presence: true


  ##
  ## ##
  ## ## ## DATA QUERIES
  ## ##
  ##

  def self.alcohol_days_per_week
    @start_date = Date.new(2019,12,30)
    @end_date = Date.today
    unless @end_date.sunday?
      until @end_date.sunday?
        @end_date += 1
      end
    end

    @weeks = []
    until @start_date > @end_date
      @weeks << [@start_date,@start_date+6]
      @start_date += 7
    end

    @return_data = []
    @weeks.each{|mon,sun|
      @return_data << Daily.where(habit: "no alcohol").where("date >=? and date <= ?", mon, sun).where(done: true).count
    }

    @return_data
  end

private


end
