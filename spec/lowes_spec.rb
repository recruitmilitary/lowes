# -*- coding: utf-8 -*-
require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Lowes do

  describe Lowes::Job do

    describe ".parse" do

      describe "when kenexa" do

        before do
          @category = double("item category", :content => "Receiving/Stocking")
          @item = double("item",
                         :link => Lowes::KenexaJobRedirectURL,
                         :title => "Seasonal Receiver/Stocker Overnight -NJ-Egg Harbor Township",
                         :category => @category)
          Lowes::Job::Parser.should_receive(:parse_url_from_meta).with(Lowes::KenexaJobRedirectURL).and_return(Lowes::KenexaJobURL)
        end

        it 'should return the attributes for the job' do
          Lowes::Job.parse(@item).should == {
            :id => "10231BR",
            :url => "https://sjobs.brassring.com/1033/ASP/TG/cim_jobdetail.asp?partnerid=25239&siteid=5014&AReq=10231BR&Codes=LOWES",
            :title => "Seasonal Receiver/Stocker Overnight",
            :category => "Receiving/Stocking",
            :location => "Egg Harbor Township, NJ",
            :description => "Position Description\n\n\nResponsible for safe, accurate and efficient receiving and stocking of in bound freight.\n\nGreet and acknowledge all customers in a friendly, professional manner and provide quick, responsive customer service.\n\n\nJob Requirements\n\n\nAbility to apply basic mathematical concepts such as adding, subtracting, multiplying, dividing and knowledge of weights and measures.  Understand and respond appropriately to basic customer and employee inquiries.  Read, write and communicate using English language sufficient to perform job functions (Other preferences will be given for special language skills when there is a business need).  Knowledge of company's mission, purpose, goals and the role of every employee in achieving each of them.  Ability to operate store equipment in assigned area (including but not limited to LRT, telephone, paging system, copiers, fax machines, computers, CCTV surveillance system, key cutting, panel saw, paint mixing computer, blind cutting, fork lifts, pallet jacks, electric lifts, etc).  Satisfactorily complete all Lowe's training requirements (including annual Hazardous Material, Forklift certification/training, etc).  Ability to interpret price tag and UPC information.  Ability to move throughout all areas of the store; sales floor, receiving, register areas, lawn and garden , including the outside perimeter of the store.  Move objects up to and exceeding 200 pounds with reasonable accommodations."
          }
        end

      end

    end

    describe ".all" do

      it 'should return a list of jobs' do
        Lowes::Job.all.size.should == 1
      end

    end

  end

end
