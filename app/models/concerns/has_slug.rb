# frozen_string_literal: true

module HasSlug
  extend ActiveSupport::Concern

  included do
    validates :slug, presence: true

    before_validation :set_slug

    def set_slug
      self.slug = SecureRandom.uuid if slug.nil?
    end

    def to_param
      slug
    end
  end
end
