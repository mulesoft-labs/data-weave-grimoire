# SpeedScope Spell

This spell will process the an `event.log` from the data weave engine. And outputs a file that is https://www.speedscope.app/ compliant

To produce an event.log the user needs to run with the `--telemetry` flag enabled.

# HOW TO RUN IT

## Step 1: Run the spell

`dw  -i payload <pathToEvent.log> --spell SpeedScope -o ./MyFile.txt`

## Step 2: Go to load the spell

Open https://www.speedscope.app/ and load the generated file