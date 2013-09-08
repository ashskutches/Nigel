require 'spec_helper'

describe NigalController do

  describe "POST #listen" do


  let(:valid_attributes) { { "name" => "Ash Skutches", "number" => "6100002312" } }

    it "responds successfully with an HTTP 200 status code" do
      post :talk
      expect(response).to be_success
      expect(response.status).to eq(200)
    end

    it "returns text" do
      post :talk, content: "How are you?"
      expect(response).to be_success
      expect(response.status).to eq(200)
    end

  end

  end

