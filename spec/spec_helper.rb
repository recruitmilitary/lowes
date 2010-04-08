$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'lowes'
require 'spec'
require 'spec/autorun'

require 'fakeweb'

FIXTURE_PATH = File.expand_path(File.dirname(__FILE__) + "/fixtures")

FakeWeb.allow_net_connect = false

FakeWeb.register_uri(:get, "http://feeds2.feedburner.com/Lowes-Careers-All", :body => FIXTURE_PATH + "/lowes.rss")
FakeWeb.register_uri(:get, "https://careers.lowes.com/GotoKenexa.aspx?jobid=10856BR", :response => FIXTURE_PATH + "/redirect.html")
FakeWeb.register_uri(:get, "https://sjobs.brassring.com/1033/ASP/TG/cim_jobdetail.asp?partnerid=25239&siteid=5014&AReq=10856BR&Codes=LOWES", :response => FIXTURE_PATH + "/job.html")
