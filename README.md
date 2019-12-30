# Setup

Get token from https://cloud.lifx.com/settings.

Put token in secrets.yml in the following format

```
token: THIS IS YOUR TOKEN
```

# How to run?

To turn on all lights:
`ruby run.rb on`  

To turn off all lights:
`ruby run.rb off`  

To turn on/off a specific light:

`ruby run.rb on|off ceiling`
