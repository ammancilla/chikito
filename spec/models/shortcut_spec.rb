require 'rails_helper'

RSpec.describe Shortcut, type: :model do
  context 'database' do
    describe "columns" do
      it { should have_db_column(:url).of_type(:text).with_options(null: false) }
      it { should have_db_column(:key).of_type(:string).with_options(null: false) }
    end

    describe "indexes" do
      it { should have_db_index(:key).unique }
    end
  end

  describe "validations" do
    subject { build :shortcut }

    it { should validate_presence_of(:url) }
    it { should validate_presence_of(:key) }
    it { should validate_length_of(:key).is_equal_to(7) }
    it { should validate_uniqueness_of(:key) }
  end
end
