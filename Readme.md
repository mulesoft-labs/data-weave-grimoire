# Hello Wise Wizard. Welcome to the magic land of DW.

This Grimore contains a collection of interesting DataWeave spells that can be executed with our CLI.

You can create your own grimore and be part of the DataWeave Wizard's Secret Club.

## How to create a SPELL

All you need is 
 - A repo *${github-user-name}*-data-weave-grimoire
 - A folder that is going to be your spell name i.e HelloWorld/
 - Then a file Main.dwl that needs to be under <spell_name>/src/Main.dwl in our case HelloWorld/src/Main.dwl
 - And then write your script inside Main.dwl for example:
```
  %dw 2.0
  ---
  "Hi Wise Wizard" 
```


Then you go to your command line and type `dw --spell <wizard-name>/HelloWorld`
