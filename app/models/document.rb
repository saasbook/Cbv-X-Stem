class Document < ApplicationRecord
  # Name of the documents and the download link of the documents are required when creating entry.
  validates_presence_of :name, :url

  # Many to One Relationship :: Each UserHolder owns Many Documents.
  belongs_to :user_holder

  # === === === === ===
  # Helper function
  # === === === === ===

  # NOTICE All access to Relationship Database should be through UserHolder Relationship,
  # - this function is recommended when accessing Documents database.

  # Access all Documents for that User
  # - Input: user_holder_id for UserHolder
  # - Output: List of all ActiveRecord of Documents of that user.
  def all_documents_by_user_holder_id(user_holder_id)
    UserHolder.find_by_id(user_holder_id).documents
  end

end
