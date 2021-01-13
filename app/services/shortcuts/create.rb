module Shortcuts
  class Create
    def self.call(*args)
      new(*args).call
    end

    def initialize(url:)
      @url = url
    end

    def call
      Shortcut.new(url: @url, key: key) do |shortcut|
        shortcut.save
      end
    end

    private

    def key
      loop do
        random_alnum = SecureRandom.alphanumeric(7)

        break random_alnum unless Shortcut.exists?(key: random_alnum)
      end
    end
  end
end
