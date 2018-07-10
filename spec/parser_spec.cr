require "./spec_helper"

describe Boa::Parser do
  describe ".parse_args" do
    it "parses [-a, 1] arguments" do
      act = Boa::Parser::INSTANCE.parse_args ["-a", "1", "-b", "2"]
      act["a"].should eq "1"
      act["b"].should eq "2"
    end

    it "parses [--a, 1] arguments" do
      act = Boa::Parser::INSTANCE.parse_args ["--a", "1", "--b", "2"]
      act["a"].should eq "1"
      act["b"].should eq "2"
    end

    it "parses [-a=1] arguments" do
      act = Boa::Parser::INSTANCE.parse_args ["-a=1", "-b=2"]
      act["a"].should eq "1"
      act["b"].should eq "2"
    end

    it "parses [--a=1] arguments" do
      act = Boa::Parser::INSTANCE.parse_args ["--a=1", "--b=2"]
      act["a"].should eq "1"
      act["b"].should eq "2"
    end

    it "parses [--a-a, 1] arguments" do
      act = Boa::Parser::INSTANCE.parse_args ["--a-a", "1", "--b-b", "2"]
      act["a-a"].should eq "1"
      act["b-b"].should eq "2"
    end

    it "parses [--a-a=1] arguments" do
      act = Boa::Parser::INSTANCE.parse_args ["--a-a=1", "--b-b=2"]
      act["a-a"].should eq "1"
      act["b-b"].should eq "2"
    end

    it "parses [-a] arguments" do
      act = Boa::Parser::INSTANCE.parse_args ["-a", "-b"]
      act["a"].should eq "true"
      act["b"].should eq "true"
    end

    it "parses [--a] arguments" do
      act = Boa::Parser::INSTANCE.parse_args ["--a", "--b"]
      act["a"].should eq "true"
      act["b"].should eq "true"
    end

    it "parses [--a-a] arguments" do
      act = Boa::Parser::INSTANCE.parse_args ["--a-a", "--b-b"]
      act["a-a"].should eq "true"
      act["b-b"].should eq "true"
    end
  end
end