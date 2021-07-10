package;
import Section.SwagSection;
import flixel.FlxState;
import Song.SwagSong;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.effects.FlxFlicker;
import flixel.util.FlxTimer;



class SelectState extends MusicBeatState
{
	var menuItems:Array<String> = ['FNF'];
	
	
	var curSelected:Int = 0;
	var txtDescription:FlxText;
	var remixCharacter:FlxSprite;
	var menuBG:FlxSprite;
	
	public static var SONG:SwagSong;
	public var targetY:Float = 0;
	var grpWeekCharacters:FlxTypedGroup<MenuCharacter>;
	

	private var grpMenuShit:FlxTypedGroup<Alphabet>;
	private var grpMenuShiz:FlxTypedGroup<FlxSprite>;
	var alreadySelectedShit:Bool = false;

	var remixNames:Array<String> = [
		"FRIDAY NIGHT FUNKIN"];

	

	var txtOptionTitle:FlxText;

	override function create()
	{
		menuBG = new FlxSprite().loadGraphic(Paths.image('gameSelect/bg'));
		add(menuBG);

	//	if(sys.FileSystem.isDirectory('assets/data/b-blammed')){
			menuItems.push('PTR');
			remixNames.push('PARAPPA THE RAPPER');
	//	}
		
		//if(sys.FileSystem.isDirectory('assets/data/u-satin-panties')){
		menuItems.push('PTR2');
		remixNames.push('PARAPPA THE RAPPER 2');


		menuItems.push('VSPARAPPA');
		remixNames.push('VS PARAPPA');
		
	//	}
	


		grpMenuShit = new FlxTypedGroup<Alphabet>();
		add(grpMenuShit);

		grpMenuShiz = new FlxTypedGroup<FlxSprite>();
		add(grpMenuShiz);

		for (i in 0...menuItems.length)
		{
			var songText:Alphabet = new Alphabet(0, (70 * i) + 30, menuItems[i], true, false);
			songText.screenCenter(X);
			songText.targetY = i;
			grpMenuShit.add(songText);
		}

		txtDescription = new FlxText(FlxG.width * 0.075, menuBG.y + 200, 0, "", 32);
		txtDescription.alignment = CENTER;
		txtDescription.setFormat("assets/fonts/vcr.ttf", 32);
		txtDescription.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, 1.5, 1);
		txtDescription.color = FlxColor.WHITE;
		add(txtDescription);

		remixCharacter = new FlxSprite().loadGraphic(Paths.image('gameSelect/fnf'));
		
		remixCharacter.scale.set(0.4, 0.4);
		remixCharacter.updateHitbox();
		remixCharacter.screenCenter(XY);
		remixCharacter.antialiasing = true;
		add(remixCharacter);

		var remixSelHeaderText:Alphabet = new Alphabet(0, 50, 'SELECT GAME', true, false);
		remixSelHeaderText.screenCenter(X);
		add(remixSelHeaderText);

		var shittyArrows:FlxSprite = new FlxSprite().loadGraphic(Paths.image('gameSelect/arrowsz'));
		shittyArrows.setGraphicSize(Std.int(shittyArrows.width * 0.85));
		shittyArrows.updateHitbox();
		shittyArrows.screenCenter();
		shittyArrows.antialiasing = true;
		add(shittyArrows);

		txtOptionTitle = new FlxText(FlxG.width * 0.7, 10, 0, "dfgdfgdg", 32);
		txtOptionTitle.setFormat("VCR OSD Mono", 32, FlxColor.WHITE, RIGHT);
		txtOptionTitle.alpha = 0.7;
		add(txtOptionTitle);

		changeSelection();

		cameras = [FlxG.cameras.list[FlxG.cameras.list.length - 1]];

		super.create();
	}

	override function update(elapsed:Float)
	{
		txtOptionTitle.text = remixNames[curSelected].toUpperCase();
		txtOptionTitle.x = FlxG.width - (txtOptionTitle.width + 10);
		var upP = controls.LEFT_P;
		var downP = controls.RIGHT_P;
		var accepted = controls.ACCEPT;

		if (!alreadySelectedShit)
		{
			if (upP)
				{
					changeSelection(-1);
				}
				if (downP)
				{
					changeSelection(1);
				}
		
				if (accepted)
				{
					alreadySelectedShit = true;
					var daSelected:String = menuItems[curSelected];
					FlxFlicker.flicker(remixCharacter, 0);
					
				
					
		
					switch (daSelected)
					{
						case "FNF":
							FlxG.sound.play(Paths.sound('confirmMenu'));
							
							FlxFlicker.flicker(grpMenuShit.members[curSelected],0);
							
							new FlxTimer().start(0.7, function(tmr:FlxTimer)
							{
								FlxG.switchState(new DisclaimerState());
								
							});
						case "PTR":
							FlxG.sound.play(Paths.sound('confirmMenu'));
							
							FlxFlicker.flicker(grpMenuShit.members[curSelected],0);
							new FlxTimer().start(0.7, function(tmr:FlxTimer)
							{
								FlxG.switchState(new StoryMenuState1());
							
							});
						
						case "PTR2":
							FlxG.sound.play(Paths.sound('confirmMenu'));
							
							FlxFlicker.flicker(grpMenuShit.members[curSelected],0);
							new FlxTimer().start(0.7, function(tmr:FlxTimer)
							{
								FlxG.switchState(new SelectState());
							
							});

							case "VSPARAPPA":
								FlxG.sound.play(Paths.sound('confirmMenu'));
								
								FlxFlicker.flicker(grpMenuShit.members[curSelected],0);
								new FlxTimer().start(0.7, function(tmr:FlxTimer)
								{
									FlxG.switchState(new SelectState());
								
								});
					
						
						default:
							// so it doesnt crash lol
							
					}
				}
		
				if (controls.BACK)
					FlxG.switchState(new MainMenuState());
		}

		super.update(elapsed);
	}

	function changeSelection(change:Int = 0):Void
	{
		FlxG.sound.play(Paths.sound('scrollMenu'));

		curSelected += change;
	
		if (curSelected < 0)
			curSelected = menuItems.length - 1;
		if (curSelected >= menuItems.length)
			curSelected = 0;
	
		var bullShit:Int = 0;
	
		for (item in grpMenuShit.members)
		{
			item.x = bullShit - curSelected;
			bullShit++;

			item.alpha = 0;
			// item.setGraphicSize(Std.int(item.width * 0.8));
	
			if (item.x == 0)
			{
				// item.setGraphicSize(Std.int(item.width));
			}
		}

		charCheckLmao();
	}

	function charCheckLmao()
	{
		var daSelected:String = menuItems[curSelected];

		switch (daSelected)
		{
			case "FNF":
				remixCharacter.loadGraphic(Paths.image('gameSelect/fnf'));
				remixCharacter.setGraphicSize(Std.int(remixCharacter.width * .65));
				remixCharacter.updateHitbox();
				remixCharacter.screenCenter();
				menuBG.loadGraphic(Paths.image('gameSelect/bg'));
				
				
				
			case "PTR":
				remixCharacter.loadGraphic(Paths.image('gameSelect/ptr'));
				remixCharacter.setGraphicSize(Std.int(remixCharacter.width * .65));
				remixCharacter.offset.x += 130;
				remixCharacter.updateHitbox();
				remixCharacter.screenCenter();
				menuBG.loadGraphic(Paths.image('gameSelect/bg'));
				
			
			case "PTR2":
			remixCharacter.loadGraphic(Paths.image('gameSelect/ptr2'));
			remixCharacter.setGraphicSize(Std.int(remixCharacter.width * .50));
			remixCharacter.updateHitbox();
			remixCharacter.offset.y -= 90;
			remixCharacter.offset.x -= 80;
			menuBG.loadGraphic(Paths.image('gameSelect/bg'));
			
			case "VSPARAPPA":
			remixCharacter.loadGraphic(Paths.image('gameSelect/vsparappa'));
			remixCharacter.setGraphicSize(Std.int(remixCharacter.width * .50));
			remixCharacter.updateHitbox();
			remixCharacter.offset.y -= 90;
			remixCharacter.offset.x -= 80;
			menuBG.loadGraphic(Paths.image('gameSelect/bg'));
					
				
				
				
		
		}
	}
}