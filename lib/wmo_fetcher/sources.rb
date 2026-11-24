# frozen_string_literal: true

module WmoFetcher
  module Sources
    autoload :Base,         "#{__dir__}/sources/base"
    autoload :KnowledgeHub, "#{__dir__}/sources/knowledge_hub"
  end
end
