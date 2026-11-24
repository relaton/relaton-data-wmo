# frozen_string_literal: true

module WmoFetcher
  module Sources
    # Base class for WMO sources: each source knows how to enumerate its
    # documents as SourceEntry objects.
    class Base
      def each_entry
        raise NotImplementedError, "#{self.class} must enumerate its entries"
      end
    end
  end
end
