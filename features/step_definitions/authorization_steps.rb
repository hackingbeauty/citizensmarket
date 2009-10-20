Then /^it should tell me I am not authorized$/ do
  response.should contain(CmSnippets.not_authorized_message)
end