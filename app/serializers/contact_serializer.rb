class ContactSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :birthdate #, :author

  belongs_to :kind do
    link(:related) { kind_url(object.kind.id) }
  end
  has_many :phones
  has_one  :address

  link(:self) { contact_url(object.id) }
  link(:kind) { kind_url(object.kind.id) }

  # def author
  #   "Jackson"
  # end

  meta do
    { author: "Jackson" }
  end

  def attributes(*args)
    h = super(*args)
    # h[:birthdate] = (I18n.l(object.birthdate) unless self.birthdate.blank?)
    h[:birthdate] = object.birthdate.to_time.iso8601 unless object.birthdate.blank?
    h
  end
end
