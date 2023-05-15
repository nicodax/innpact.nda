## Ticket
[Ticket Number](ticket_url)

## Description
- What?
- Why?
- How?
- Anything Else?

## Type of changes

- [ ]  Docs changes
- [ ]  Refactoring
- [ ]  Dependency upgrade
- [ ]  Bug fix
- [ ]  New feature
- [ ]  Breaking changes

## PR creator checklist

- [ ]  My code follows the company code style and best practices (Rubocop)
- [ ]  No logging or debugging code
- [ ]  I updated the documentation (if applicable)
- [ ]  I wrote/updated unit/integration tests
- [ ]  I test the work on my machine
- [ ]  My changes generate no new warnings
- [ ]  My changes do not introduce new/update dependency
- [ ]  I performed self code review
- [ ]  My commit messages follow the best practices
- [ ]  I set proper PR (title, description & labels)
- [ ]  The description refers to issue(s)/Jira card(s) the PR solves.
- [ ]  Brakeman doesn't show alerts - if false positive, add them to ignore file and add explaination in the PR
- [ ]  Rubycritic reports no new complexity/smells issue with the new code 

## Reviewer Checklist

- [ ]  The code follows the project code style and best practices
- [ ]  The tests are successful
- [ ]  No logging or debugging code
- [ ]  The documentation was updated
- [ ]  PR follow the project guidelines
- [ ]  No security issue (Brakeman is ok and false/positive explanations are relevant)
- [ ]  Rubycritic doesn't report new issues

