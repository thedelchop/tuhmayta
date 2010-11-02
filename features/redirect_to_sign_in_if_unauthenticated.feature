Feature: Redirect to sign in if not authenticated

  Scenario: Redirect to sign in if not authenticated
    Given I am a user with the email, "TestMan@example.com"
      And I already have a Tuhmayta account
      And I am not signed in
     When I go to my master list page
     Then I should be on the sign in page
      And I should see "You need to sign in or sign up before continuing."
