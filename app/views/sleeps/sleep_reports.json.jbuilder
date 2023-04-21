json.data do
  json.array! @reports do |report|
    json.partial! 'sleep_report', report: report
  end
end