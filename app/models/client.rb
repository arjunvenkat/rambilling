class Client < ActiveRecord::Base
  attr_accessible :name

  has_many :projects, :dependent => :destroy

  validates_presence_of :name

  def total_time
    total_time = self.projects.inject(0) { |sum, project| sum += project.total_time}
    total_time.round(2)
  end
end
