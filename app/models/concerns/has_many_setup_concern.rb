module HasManySetupConcern
  extend ActiveSupport::Concern

  module ClassMethods
    def has_many_setup(resource_sym, attrs_have_to_exist_list)
      has_many resource_sym
      accepts_nested_attributes_for resource_sym,
      reject_if: lambda { |attrs| attrs_have_to_exist_list.map { |exist_attr| attrs[exist_attr].blank? }.any? }
    end
  end



end
