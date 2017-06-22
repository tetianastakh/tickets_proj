require 'elasticsearch/model'

class Ticket < ActiveRecord::Base
  include Elasticsearch::Model

  validates :from_name, :from_email, :subject, :body, presence: true
  has_many :replies, :dependent => :destroy

  def as_indexed_json(options={})
    as_json(
      only: [:id, :subject, :from_name, :from_email, :body, :uniq_identifier]
    )
  end
end
