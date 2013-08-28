require 'spec_helper'

describe NigalController do

  describe "POST #listen" do


  let(:valid_attributes) { { "name" => "Ash Skutches", "number" => "6100002312" } }

    it "responds successfully with an HTTP 200 status code" do
      post :listen
      expect(response).to be_success
      expect(response.status).to eq(200)
    end

    it "returns whatever text you inputted" do
      post :listen, content: "How are you?"
      expect(response).to be_success
      expect(response.status).to eq(200)
      puts response.body

      expect(response.body) == "How are you?"
    end

  end

  end

