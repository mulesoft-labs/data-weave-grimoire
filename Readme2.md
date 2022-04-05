# Hello Wise Wizard. Welcome to the magic land of DataWeave.

This grimoire contains a collection of interesting DataWeave spells that can be executed with [our DataWeave CLI](https://github.com/mulesoft-labs/data-weave-native).

You can create your own grimoire and be part of the DataWeave Wizards Secret Club.

## Wizard, Grimoires and Spells

### Wizard
A `wizard` is just a name that we trust and we want to have all their `spells` available.

### Grimoire

A `grimoire` is a collection of `spells` from a given `wizard`. 

## Spells
A `spells` are just executables scripts that can be called from the command-line using the `spell` name.

:warning: **Do NOT execute spells you don't trust**: Be very careful here!

### How to Add a Wizard

In order to add a new `wizard` use the DataWeave CLI

```bash
dw --add-wizard <wizard_name>
```
The wizard grimoire is going to be cloned at `{user.home}/.dw/grimoires`

### How to Run a Spell

The following command shows how to run a spell using tge DataWeave CLI 
```bash
dw --spell <spell_name>
```

### How to Create a Spell

- wizard_name = GitHub User Name

All you need is 
 - A repo `<wizard_name>-data-weave-grimoire`
 - A folder that is going to be your spell name i.e `HelloWorld/`
 - Then a file `Main.dwl` that needs to be under `<spell_name>/src/Main.dwl` in our case `HelloWorld/src/Main.dwl`.
 - And then write your script inside Main.dwl for example:

```
  %dw 2.0
  ---
  "Hi Wise Wizard" 
```

Then you go to your command-line and type:
```bash
dw --spell <wizard_name>/HelloWorld
```




## Become a DataWeave wizard

### Step 1: Create the GitHub Repository

In order to become a wizard first create your GitHub repository

`https://github.com/${wizard_name}/${wizard_name}-data-weave-grimoire`

Your wizard name is going to be your GitHub user id

### Step 2: Clone GitHub Repository

`git clone https://github.com/${wizard_name}/${wizard_name}-data-weave-grimoire`

### Step 3: Create a Spell

Inside your cloned repo run

`dw --new-spell <spellName>`

### Step 3: Edit Your Spell

Using VSCode and with the vscode plugin

`code <spellName>`

### Step 4: Try it out

In order to test a local spell you can use

`dw --local-spell ./<spellName>`

Or you if you want to use a live coding XP you can use the `--eval` flag that it will re-run the spell on every save

### Step 5: Push It and Distribute

Once your spell is finished push it to your repo and tell your friends to try it out.
