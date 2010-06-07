# -*- coding: undecided -*-
require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Lowes do

  describe Lowes::Job do

    describe ".all" do

      before do
        @jobs = Lowes::Job.all
      end

      it 'should return a list of jobs' do
        @jobs.size.should == 1
      end

    end

    describe "instance" do

      before do
        @jobs = Lowes::Job.all
        @job  = @jobs.first
      end

      it 'should extract the title' do
        @job.title.should == "Assembler -NJ-North Bergen"
      end

      it 'should extract the link' do
        @job.redirect_url.should == "https://careers.lowes.com/GotoKenexa.aspx?jobid=10856BR"
      end

      it 'should extract the id' do
        @job.id.should == "10856BR"
      end

      it 'should extract the category' do
        @job.category.should == "Customer Service"
      end

      it 'should extract the url from the meta tag' do
        @job.url.should == "https://sjobs.brassring.com/1033/ASP/TG/cim_jobdetail.asp?partnerid=25239&siteid=5014&AReq=10856BR&Codes=LOWES"
      end

      it 'should extract the location' do
        @job.location.should == "Mooresville, North Carolina"
      end

      it 'should extract the city from location' do
        @job.city.should == "Mooresville"
      end

      it 'should extract the state from location' do
        @job.state.should == "North Carolina"
      end

      it 'should extract the description' do
        @job.description.should == %Q{The Lowes.com IT Project Manager is responsible for the management of various Lowes.com projects and/or the maintenance and enhancement of the Lowes.com family of applications. The Lowes.com IT Project Manager works closely with the Lowes.com business, other IT departments, and resource and software vendors in  the analysis, design, scheduling, development, and implementation of new and upgrades to Lowes.com systems and the maintenance of current systems. The Lowes.com  IT Project Manager manages day-to-day operational aspects of project which includes but is not limited to:o Identifies resource needs and monitors individual activitieso Performs project planning and estimatingo Produces/reviews status reports and take action on issueso Manages issues to timely resolutiono Identifies and track riskso Monitors project hourso Budget trackingo Manages financial, temporal, and deliverable scopes of projects o Facilitates weekly status meetingso Reviews and approves deliverables prepared by teamo Ensures documents are complete, current and stored in appropriate locationo Complies with Lowe’s methodology, enforces policies, standards, including internal and external controls o Provides timely review and approval of time and invoices according to policieso Selects and manages contract personnelo Manages offsite resourceso Manages 3rd party software vendors\r\n\t      \t\t\r\n\t\t\t\t\t• Seven to ten years of systems development experience with increasing levels of management responsibility• A minimum of a Bachelor’s Degree or comparable job-related experience is required• Strong understanding of large-scale commerce enabled web properties• Demonstrable ability to successfully deliver web-based applications• Demonstrable ability to successfully deliver technical solutions to business problems• Demonstrable leadership and coaching skills• Demonstrable communication skills• Demonstrable planning skills• Strong prioritization skills• Demonstrable knowledge of quality standards• Demonstrable knowledge of IT methodology• Demonstrable knowledge of office suite products and project planning tools\r\n          \t\t\r\n\t\t\t\t\t• Time management skills • Organizational skills• Negotiating skills• Retail systems and eCommerce business knowledge• Four-year degree in Computer Science or Information Systems• Advanced degree in business or technical subject areas is helpful• Knowledge of general accepted computing controls• Familiarity with IBM Websphere Commerce• Familiarity with object oriented methodologies, tools, and techniques}
      end

    end

  end

end
