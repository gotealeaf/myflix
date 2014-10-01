VCR.configure do |c|
  c.cassette_library_dir = 'vcr_cassettes'
  c.hook_into :webmock # or :fakeweb
  c.ignore_localhost = true
end