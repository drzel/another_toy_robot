describe Input do
  let (:robot) { build :robot }
  let(:input) { build :input_with_valid_command }

  describe "#new_command" do
    it "creates a new xCommand class" do
      expect(input.new_command(target: robot).class.to_s).to eq(
        "#{input.basename.capitalize}Command",
      )
    end
  end

  describe "#basename" do
    it "is a string containing only word characters" do
      expect(input.basename).to match(/\w+/)
    end
  end
end

describe "#params" do
  context "when input has params" do
    let(:input) { build :input_place_with_valid_params }

    it "is a non-empty array" do
      expect(input.params.class).to be Array
      expect(input.params).not_to be_empty
    end
  end

  context "when input has no params" do
    let(:input) { build :input_with_valid_command }

    it "is an empty array" do
      expect(input.params.class).to be Array
      expect(input.params).to be_empty
    end
  end
end
