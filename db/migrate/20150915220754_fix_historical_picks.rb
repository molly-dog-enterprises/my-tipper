class FixHistoricalPicks < ActiveRecord::Migration
  def change
    Fixture.all.each {|f| f.update_result(f.result) if f.result }
  end
end
