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
        @job.description.should == %Q{Position SummaryProvide superior customer service by performing assembly and/or product pre-delivery inspection of all OPE and non OPE products as required for selling, display and other purposes by the store.Job OverviewRequires late evening, night-time and early morning availability any day of the weekRequired to work a Corporate schedule determined by Staffing DepartmentGenerally scheduled 39 to 40 hours; more hours may be required based on the needs of the store. Ability to apply basic mathematical concepts such as adding, subtracting, multiplying, dividing and knowledge of weights and measures.  Understand and respond appropriately to basic customer and employee inquiries.  Read, write and communicate using English language sufficient to perform job functions (Other preferences will be given for special language skills when there is a business need).  Knowledge of company's mission, purpose, goals and the role of every employee in achieving each of them.  Ability to operate store equipment in assigned area (including but not limited to LRT, telephone, paging system, copiers, fax machines, computers, CCTV surveillance system, key cutting, panel saw, paint mixing computer, blind cutting, fork lifts, pallet jacks, electric lifts, etc) .  Satisfactorily complete all Lowe's training requirements (including annual Hazardous Material, Forklift certification/training, etc).  Ability to interpret price tag and UPC information.  Ability to operate/demonstrate/explain merchandise in assigned area.  Possess skill and ability needed to interpret and perform manufacturers' guidelines for product assembly and/or product pre-delivery inspections.}
      end

    end

  end

end
