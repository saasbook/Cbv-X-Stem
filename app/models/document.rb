class Document < ApplicationRecord
  # Name of the documents and the download link of the documents are required when creating entry.
  validates_presence_of :name, :url

  # Many to One Relationship :: Each UserHolder owns Many Documents.
  belongs_to :user_holder
end
