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
          Lowes::Job.should_receive(:parse_url_from_meta).with(Lowes::KenexaJobRedirectURL).and_return(Lowes::KenexaJobURL)
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

      describe "when kenexa and expired" do

        before do
          @item = double("item", :link => Lowes::KenexaExpiredJobRedirectURL)
          Lowes::Job.should_receive(:parse_url_from_meta).with(Lowes::KenexaExpiredJobRedirectURL).and_return(Lowes::KenexaExpiredJobURL)
        end

        it 'should raise Job::ExpiredError' do
          lambda {
            Lowes::Job.parse(@item)
          }.should raise_error(Lowes::Job::ExpiredError)
        end

      end

      describe "when peopleclick" do

        before do
          @category = double("item category", :content => "Repair Services")
          @item = double("item",
                         :link => Lowes::PeopleclickJobRedirectURL,
                         :title => "Program Development Analyst -NC-Wilkesboro",
                         :category => @category)
          Lowes::Job.should_receive(:parse_url_from_meta).with(Lowes::PeopleclickJobRedirectURL).and_return(Lowes::PeopleclickJobURL)
        end

        it 'should return the attributes for the job' do
          Lowes::Job.parse(@item).should == {
            :id => "117530",
            :url => "http://careers.peopleclick.com/careerscp/client_lowes/external/gateway.do?functionName=viewFromLink&jobPostId=155060&localeCode=en-us",
            :title => "Program Development Analyst",
            :category => "Repair Services",
            :location => "Wilkesboro, North Carolina",
            :description => "The Contact Center Program Development Analyst manages the development and implementation of new Contact Center programs, provides stable technology solutions that support program goals, and produces regular and ad-hoc reporting that provide actionable data to Contact Center management and other Lowe\342\200\231s business areas.This requires active project management, frequent collaboration (with Contact Center teams, other Lowe\342\200\231s business areas, and external vendors), managing deliverables and service level commitments (IT), and ongoing proactive data analysis.\342\200\242 Develop and manage cross-functional project plans for key Contact Center initiatives, including establishing timelines and accountabilities for Contact Center resources, other Lowe\342\200\231s business areas, and external vendors.\342\200\242 Conduct ongoing needs analysis to ensure Contact Center technology offers functionality that meets business requirements. \302\240\342\200\242 Implement and manage processes, controls, and IT service levels to ensure the stability of Contact Center technology. \302\240Includes serving as System Administrator for selected technologies.\342\200\242 Establish a methodology and discipline for proactively analyzing the data collected through customer interactions. \302\240Through that analysis, identify opportunities to produce targeted, actionable reporting for Lowe\342\200\231s business areas (stores, Merchandising, Marketing, Installed Sales, SOS, etc.). \302\240The role is to provide recommendations, not data.\342\200\242 Provide regular, actionable reporting to measure overall Contact Center performance, as well as individual and team performance. \302\240Ensure Directors, Managers, and Supervisors receive the information they need to effectively manage their businesses. \302\240Includes analysis of the data to identify trends and make recommendations for process, program, or overall Contact Center performance improvements.\342\200\242 Provide regular feedback and development opportunities to direct reports, with a focus on succession planning within the work group and across the department.\342\200\242 Manage financial, temporal, and deliverable scopes of projects. \342\200\242 Identify and track risk in Contact Center initiatives and take appropriate action to address the risk. Essential Knowledge, Skills, & Abilities\342\200\242 Problem Solving and Decision Making\342\200\242 Cooperation, Collaboration, and Influencing Others\342\200\242 Supervision, Delegation and Coaching\342\200\242 Accountability and Attention to Detail\342\200\242 Planning, Prioritization and Project Management\342\200\242 Oral and Written Communication Skills\r\n\t      \t\t\r\n\t\t\t\t\t\342\200\242 Four-year degree or equivalent work experience \342\200\242 Three to five years of business analysis experience \342\200\242 Three years project management experience with increasing levels of management responsibility \342\200\242 Knowledge of quality standards \342\200\242 Knowledge of Office Suite products and project planning tools \342\200\242 Experience reporting and analyzing data. \342\200\242 Proven ability to take direction and proceed independently \342\200\242 Past roles as a project leader (PM experience) \342\200\242 Experience leading people, whether as primary job responsibility or related to a specific project/initiative \342\200\242 Solid experience with data mining and analysis \342\200\242 Demonstrable experience creating and utilizing the following software and languages: -Software Microsoft SQL Server MS Access Crystal Reports Cognos (secondary to Crystal Reports) -Languages Visual Basic Java JavaScript SQL\r\n          \t\t\r\n\t\t\t\t\t\342\200\242 Four-year degree in Computer Science or Information Systems\342\200\242 Experience with Remedy, Siebel and Avaya\342\200\242 Information Technology acumen\342\200\242 Ability to communicate technology solutions on a high level to non-technical business people, as well as, foster a collaborative environment between IT and the business",
          }
        end

      end

      describe "when peopleclick and expired" do

        before do
          @item = double("item", :link => Lowes::PeopleclickExpiredJobRedirectURL)
          Lowes::Job.should_receive(:parse_url_from_meta).with(Lowes::PeopleclickExpiredJobRedirectURL).and_return(Lowes::PeopleclickExpiredJobURL)
        end

        it 'should raise Job::ExpiredError' do
          lambda {
            Lowes::Job.parse(@item)
          }.should raise_error(Lowes::Job::ExpiredError)
        end

      end

    end

    describe ".all" do

      it 'should return a list of jobs'

    end

  end

end
