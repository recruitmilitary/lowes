$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'lowes'
require 'spec'
require 'spec/autorun'

require 'fakeweb'

FIXTURE_PATH = File.expand_path(File.dirname(__FILE__) + "/fixtures")

FakeWeb.allow_net_connect = false

def stub_get(url, fixture_name)
  FakeWeb.register_uri(:get, url, :response => FIXTURE_PATH + "/#{fixture_name}")
end

Lowes::KenexaExpiredJobRedirectURL = "https://careers.lowes.com/GotoKenexa.aspx?jobid=EXPIRED"
Lowes::KenexaExpiredJobURL = "https://sjobs.brassring.com/1033/ASP/TG/cim_jobdetail.asp?partnerid=25239&siteid=5014&AReq=EXPIRED&Codes=LOWES"
Lowes::KenexaJobRedirectURL = "https://careers.lowes.com/GotoKenexa.aspx?jobid=10231BR"
Lowes::KenexaJobURL = "https://sjobs.brassring.com/1033/ASP/TG/cim_jobdetail.asp?partnerid=25239&siteid=5014&AReq=10099BR&Codes=LOWES"
Lowes::KenexaJobMissingLocationRedirectURL = "https://careers.lowes.com/GotoKenexa.aspx?jobid=MISSING_LOCATION"
Lowes::KenexaJobMissingLocationURL = "https://sjobs.brassring.com/1033/ASP/TG/cim_jobdetail.asp?partnerid=25239&siteid=5014&AReq=MISSING_LOCATION&Codes=LOWES"

stub_get("http://feeds2.feedburner.com/Lowes-Careers-All", "rss_feed")
stub_get(Lowes::KenexaExpiredJobURL, "kenexa_expired_job")
stub_get(Lowes::KenexaJobURL, "kenexa_job")
stub_get(Lowes::KenexaJobRedirectURL, "kenexa_redirect")
stub_get(Lowes::KenexaExpiredJobRedirectURL, "kenexa_expired_redirect")
stub_get(Lowes::KenexaJobMissingLocationURL, "kenexa_missing_location_job")
