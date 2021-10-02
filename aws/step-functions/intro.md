# step functions

## overview

### when to use them
- business critical workflows
- complex workflows with a lot of conditional logic
- long-running workflows

### 7 types of states

#### task
- does some work, typically invoking a lambda. 
- invoke what's set in the Resource attribute
- `Next`: state machine execution transitions to this attribute
- timeout: set how long the task runs. optional, default of 60 seconds. the state machine doesn't know the lambda's timeout, so coordinate these two.
- resource can be more than lambda, can be all sorts of aws services

#### pass
- passes input to output without doing any work
- can modify the state without invoking a lambda


#### wait
- wait before transitioning to the next state
- wait for seconds or a particular timestamp


#### choice
- adds branching logic to the state machine
- has several choices for next, depending on the input
- need to specify a default in case none of the choices are true

#### parallel 
- performs task in parallel
- state will complete when all the parallel branches have completed or failed

#### succeed
- terminates the state machine successfully

#### fail
- terminates the state machine and mark it as failure
- specify the error
- add a cause


### managing execution state
when you start an execution, you provide an input to the execution. passed into the first state as input.

after a state, the state's output is the next state's input.

### error handling
- retry fail states
- catch any errors 
- retry and catch are only allowed on task and parallel state

there are predefined error codes:
- ALL: matches any error name
- Timeout
- TaskFailed
- Permissions

specify retry behavior by adding retry array to a task/parallel state's definition

each "retrier" keeps track of its own retry count

see docs on retry behavior: https://docs.aws.amazon.com/step-functions/latest/dg/welcome.html#amazon-states-language-retrying-after-error


### monitoring and debugging
you can set up cloudwatch alarms for the different state status's

### service limits
pay attention to the hard limits. if you're hitting them, then you're probably using it wrong.

- 1 million open executions
- 1 year execution time
- maximum input size == 37kb. (put big stuff into s3 so lambda can fetch the data)
- limit of 1k concurrent pollers if you're using activities (describe state machine, get executions, etc)

docs: https://docs.aws.amazon.com/step-functions/latest/dg/limits-overview.html

### express workflows
- stripped down version of step functions. cheaper. no visualization tools and not auditing. 
- operates at a much higher throughput.
- 5 minute duration max
- over 100k executions per second
- priced differently, more like lambda
- idempotency is your responsibility
- doesn't support all of the aws integrations