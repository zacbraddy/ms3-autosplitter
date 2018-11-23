# ms3-autosplitter
An autosplitter implementation for Metal Slug 3 for use with LiveSplit  https://github.com/LiveSplit/LiveSplit

## Installation

1. Clone this repo down to your machine locally.
1. Open livesplit and right click your splits and select `Open Splits > From File...` and select either the `default-livesplit-splits.lss` or the `bosses-only-livesplit-splits.lss` from the `livesplit-splits` folder of the repo you downloaded. The differences between the two are explained below.
1. Right click your splits and select `Open Layout > From File...` and select either the `default-livesplit-layout.lss` or the `bosses-only-livesplit-layout.lss` from the `livesplits-layout` folder of the repo you downloaded. The differences between the two are explained below.
1. Right click your splits and select `Edit Layout`
1. Double click the line at the bottom of the screen that opens up marked `Scriptable Auto Splitter`.
1. Click browse and find the `ms3-autosplitter.asl` file in the root of the repo you downloaded. Once you've selected it then just Ok out of all the windows that you've opened up in previous steps till you get back to your splits.
1. That's it, you should be ready to run.

## Premade setup descriptions
### Default

With this setup your livesplit will be set to use the auto-start and auto-reset functionality as well as all the splits that are explained below.

### Bosses Only

With this setup your live split will still be set to use the auto-start and auto-reset functionality but the splitter will only split on the following splits:

- Huge Hermit
- 10 Commandments of Moses
- Jupiter King
- Sol Dae Rokker
- Hi Do
- Fake Root Mars
- True Root Mars

### Configuration

If you want to turn on or off any of the available splitter functionality then you can do this by right clicking on your splits and going to `Edit Layout` from there double click on the `Scriptable Auto Splitter` row. On the screen that opens up you can see all the options that you can turn on and off. In this way you can use the autosplitter to automatically time segemented runs if you wish or just customise which splits you use so you don't have to use the default templates in this repo.

## Available Functionality
### Auto-split

Auto split just hits the split button for you. It doesn't do anything clever like look at which splits you have setup and split when it sees the specific split or anything. All it does is move you on to the next split when the game gets to a certain point.

So if you decide to change up the things you auto split on then make sure you also update your splits so that you are splitting on the right thing. Here are all the splits that you can use in this auto-splitter. In the default setup we use all of these:

| Mission   | Split Name | Included in Default setup | Included in Bosses Only Setup | Description |
| --- | --- | :---: | :---: | --- |
| Mission 1 | Beach | X |  | Split happens during the screen change between when going in the cannister and arriving in the storage part of the first level |
| | Storage | X | | Split happens during the screen change between the storage part of the level and entering Huge Hermit boss fight |
| | Huge Hermit (Boss) | X | X | Split happens as soon as Huge Hermit dies |
| Mission 2 | 10 Commandments of Moses (Boss) | X | X | Split happens as soon as the second phase of this bosses dies |
| Mission 3 | Underwater | X | | Split happens during the screen change between going into the tube and entering the board walk |
| | Boardwalk | X | | Split happens during the screen change between leaving the boardwalk and entering the Juptier King boss fight |
| | Jupiter King (Boss) | X | X | Split happens as soon as Jupiter King dies |
| Mission 4 | Desert | X | | Split happens during the screen change between the Desert section of the level and beginning the climb of the Temple |
| | Temple | X | | Split happens during the screen change between the Temple and entering the fight with Sol Dae Rokker
| | Sol Dae Rokker (Boss) | X | | Split happens as soon as Sol Dae Rokker dies |
| Mission 5 | Dog Fight | X | | Split happens at the end of the Dog fight sequence whilst transitioning between dog fight and the start of the O'Neil split |
| | O'Neil | X | | Split happens when O'Neil hits the ground |
| | Hi-Do | X | X | Split happens as soon as Hi-Do dies |
| | Rugname | X | | Split happens during the screen change between breaking into the Rugname and entering the Rugname Chute |
| | Rugname Chute | X | | Split happens during the screen change when the character punches through the floor of the inside of the Rugname |
| | Save Morden | X | | Split happens during the screen change after saving Morden that loads into the corridor that leads to Fake Root Mars | 
| | Fake Root Mars | X | X | Split happens during the screen change after the having killed Fake Root Mars as the character loads into the corridor leading to the Clone Bubble |
| | Clone Bubble | X | | Split happens as soon as the clone bubble explodes |
| | True Root Mars | X | X | Split happens as soon as True Root Mars dies |

### Auto-start

If you have any split selected in the first mission then you will be able to use the auto start functionality. If you have auto-start turned on then when your character hits the water at the start of Mission 1 then the timer will automatically start for you.

If you're using the splitter for segemented runs or for whatever reason you aren't splitting on anything in the first mission then the auto start won't work. You can still manually start the splitter however when timing segemented runs and the splitter will still autosplit.

### Auto-reset

If the timer is running and you return the main menu then the timer will automatically reset itself for you. Not this only happens if the timer is actually running. If the timer has stopped after having completed a run you have to manually reset it I believe this is a live split thing so it doesn't accidentally automatically save over your best splits.

### Current state of development
The first version of this splitter has now been released. I've tested fairly rigouriously however I've only tested on one computer on Easy Any% and using default settings. If you are wanting to use the bosses only splitter or your own custom one or use it for segemented runs then I'm confident it will work but I can't make any guarantees without further testing, so keep an eye on it for your first couple of runs just to make sure that it works as expected.

This splitter only works on the Steam version of the game currently. Please feel free to submit a PR if you want to add memory markers for another version of the game or if you think you can make any other improvements.

If you have any issues with the splitter then please feel free to log an issue with as much detail about what went wrong as you can, i.e. which character you were which weapon you had etc. etc.

