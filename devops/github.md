# github actions
[See here](https://github.com/datamade/how-to/blob/master/ci/github-actions.md)

github actions help automate tasks for your SDLC. actions are event driven, meaning that you can run a series of commands after a specified event has occured. for example, every time someone creates a PR for a repo, you can automatically run a command that executes a testing script
- workflow: automated procedure for your repo
- events: specific activity that triggers a workflow, like when a PR is created
- jobs: set of steps that execute on the same runner. by default, a workflow with multiple jobs will run those jobs in parallel
- steps: individual task that can run commands in a job. step can be either an action or a shell command
- actions: standalone commands that are combined into steps to create a job. actions are the smallest portable building block of a workflow
- runners: a runner is a server that has the github actions runner application installed. 

[github's guide to creating an example workflow](https://docs.github.com/en/actions/learn-github-actions/introduction-to-github-actions#create-an-example-workflow)

[understanding the workflow file](https://docs.github.com/en/actions/learn-github-actions/introduction-to-github-actions#understanding-the-workflow-file)
