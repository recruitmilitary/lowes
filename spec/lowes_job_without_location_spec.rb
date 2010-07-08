# -*- coding: utf-8 -*-
require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Lowes::Job::KenexaParser do

  describe "when encountering a job with no location" do

    before do
      @category = double("item category", :content => "Receiving/Stocking")
      @item = double("item",
                     :link => Lowes::KenexaJobMissingLocationRedirectURL,
                     :title => "Receiver/Stocker -SC-Florence",
                     :category => @category)
      Lowes::Job::Parser.should_receive(:parse_url_from_interstitial_page).with(Lowes::KenexaJobMissingLocationRedirectURL).and_return(Lowes::KenexaJobMissingLocationURL)
      @job = Lowes::Job.parse(@item)
    end

    describe "#location" do

      it 'should return nil' do
        @job[:location].should be_nil
      end

    end

  end

end
