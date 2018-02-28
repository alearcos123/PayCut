module ValidateEmailUniquenessAcrossModels
  extend ActiveSupport::Concern

  @@included_classes = []

  included do
    @@included_classes << self
    validate :email_unique_across_all_models
  end

  private

  def email_unique_across_all_models
    return if self.email.blank?
    @@included_classes.each do |item|
      scope = item.where(email: self.email)
      if self.persisted? && item == self.class
        scope = scope.where('id != ?', self.id)
      end
      if scope.any?
        self.errors.add :email, 'is already taken'
        break
      end
    end
  end
end
