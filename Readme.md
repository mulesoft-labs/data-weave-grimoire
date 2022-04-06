# Hello Wise Wizard. Welcome to the magic land of DataWeave.

This grimoire contains a collection of interesting DataWeave spells that can be executed with our [DataWeave CLI](https://github.com/mulesoft-labs/data-weave-native).

You can create your own grimoire and be part of the DataWeave Wizards Secret Club.

Let's start defining some concepts:

## Wizard
A `wizard` is just a name that we trust and we want to have all their `spells` available.

A `wizard` has a `grimoire`, a GitHub repository that is inferred by `https://github.com/${wizard_name}/${wizard_name}-data-weave-grimoire`, that includes all the `spells` from this `wizard`.

## Grimoire

A `grimoire` is a collection of `spells` from a given `wizard`. 

## Spells

A `spell` is a very simple way to distribute and share a DataWeave transformation.

A `spell` is just an executable script that can be called from the command line using the `spell`'s name.

## DataWeave Grimoire

The DataWeave Grimoire is the default grimoire provided by the DataWeave CLI.

This grimoire contains the following spells:

| Spell        | Description                                                        |
|--------------|--------------------------------------------------------------------|
| HelloWizard  | Just a simple example that shows how to create a very basic spell. |
| CountWizards | Spell to find other DataWeave wizards.                             |
| Playground   | This spell will launch the playground UI.                          |

## How to Add a Wizard

In order to add a new `wizard` use the DataWeave CLI

```bash
dw --add-wizard <wizard_name>
```
The wizard grimoire is going to be cloned at `{user.home}/.dw/grimoires`

:warning: **Do NOT add a wizard you don't trust**

## Listing All the Available Spells

Using the `--list-spells` it will show all the available spells for each wizard with the documentation of each spell.

```bash
dw --list-spells
```

## How to Run a Spell

There are several ways to run a spell using the DataWeave CLI.

:warning: **Do NOT execute spells you don't trust**

### Running a Spell From a Wizard

```bash
dw --spell <wizard_name>/<spell_name>
```

### Running a Spell From the DataWeave Grimoire

```bash
dw --spell <spell_name>
```

### Running a Spell From a Grimoire a Local Folder

```bash
dw --local-spell <spell_name>
```

## Becoming a DataWeave Wizard

### Step 1: Create the GitHub Repository

In order to become a `wizard` first create your GitHub repository

```bash
https://github.com/${wizard_name}/${wizard_name}-data-weave-grimoire
```

Your wizard name is going to be your GitHub user id

### Step 2: Clone GitHub Repository

```bash
git clone https://github.com/${wizard_name}/${wizard_name}-data-weave-grimoire
```

### Step 3: Create a Spell

Inside your cloned repository run

```bash
dw --new-spell <spell_name>
```

### Step 3: Edit Your Spell

Use [DataWeave VSCode Plugin](https://marketplace.visualstudio.com/items?itemName=MuleSoftInc.dataweave) to develop your script.

### Step 4: Try it out

In order to test a local spell you can use

```bash
dw --local-spell <spell_name>
```

### Step 5: Push It and Distribute

Once your spell is finished push it to your repository and tell your friends to try it out.

## Running the DataWeave Playground Locally

The following example shows how run a DataWeave Playground locally:

```bash 
dw --eval --spell Playground
```

It is going to execute the `Playground` spell that is going to be located in `{user.home}/.dw/grimoires/data-weave-grimoire/Playground/src/Main.dwl`